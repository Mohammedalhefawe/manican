import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:manicann/core/theme/font_styles.dart';
import 'package:sizer/sizer.dart';

class CustomDatePickerAsTextFiled extends StatefulWidget {
  final String hintText;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final double? height;

  const CustomDatePickerAsTextFiled({
    super.key,
    required this.hintText,
    this.onChanged,
    this.validator,
    this.height,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePickerAsTextFiled> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        _controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
      });
      if (widget.onChanged != null) {
        widget.onChanged!(DateFormat('yyyy-MM-dd').format(pickedDate));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    InputBorder border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    );
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        widget.hintText,
        style: textFieldLabelStyle,
      ),
      const SizedBox(
        height: 5,
      ),
      Material(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: 50.w,
            height: widget.height ?? 35,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: TextFormField(
              onTap: () => _selectDate(context),
              validator: widget.validator,
              readOnly: true,
              controller: _controller,
              decoration: InputDecoration(
                filled: true,
                fillColor: lightGrey,
                contentPadding: const EdgeInsets.symmetric(horizontal: 7),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
              style: textFromStyle,
            ),
          ))
    ]);
  }
}
