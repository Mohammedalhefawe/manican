import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomDatePicker extends StatefulWidget {
  final String hintText;
  final void Function(String?)? onChanged;

  const CustomDatePicker({
    super.key,
    required this.hintText,
    this.onChanged,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
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
    return Container(
      alignment: Alignment.center,
      height: 6.h,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: TextFormField(
        controller: _controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          constraints: BoxConstraints(
            minWidth: 7.w,
            maxWidth: 15.w,
          ),
          hintText: DateFormat('yyyy-MM-dd').format(DateTime.now()),
          hintStyle: const TextStyle(
              fontSize: 14, fontWeight: FontWeight.w300, color: blackColor),
          border: InputBorder.none,
          contentPadding: EdgeInsetsDirectional.only(top: 1.h),
          suffixIcon: const Icon(
            Icons.calendar_today,
            color: Colors.black54,
          ),
        ),
        readOnly: true,
        onTap: () => _selectDate(context),
      ),
    );
  }
}
