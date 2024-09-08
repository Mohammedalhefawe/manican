import 'package:flutter/material.dart';
import 'package:manicann/core/theme/app_colors.dart';
import 'package:sizer/sizer.dart';

class CustomMultiSelectDropdown extends StatefulWidget {
  final List<ItemModel> listItems;
  final String hintText;
  final bool isMultiSelect;
  final void Function(bool?, int)? onSelect;
  const CustomMultiSelectDropdown(
      {super.key,
      required this.listItems,
      this.onSelect,
      required this.hintText,
      required this.isMultiSelect});

  @override
  // ignore: library_private_types_in_public_api
  _CustomMultiSelectDropdownState createState() =>
      _CustomMultiSelectDropdownState();
}

class _CustomMultiSelectDropdownState extends State<CustomMultiSelectDropdown> {
  bool isOpened = false;
  List selectedItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void toggleDropdown() {
    setState(() {
      isOpened = !isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.hintText,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          GestureDetector(
              onTap: toggleDropdown,
              child: Material(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: Container(
                  width: 100.w,
                  height: 7.h,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: lightGrey,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          selectedItems.isEmpty ? '' : selectedItems.join(', '),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.arrow_drop_down),
                    ],
                  ),
                ),
              )),
          if (isOpened)
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: lightGrey, width: 0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              margin: const EdgeInsets.only(top: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    width: 27.w,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: widget.listItems.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                            leading: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(widget
                                              .listItems[index].imageUrl ??
                                          'https://mirdereva64.ru/wp-content/themes/MirDereva64/img/image-not-found-placeholder.jpg')),
                                  color: AppColors.secondary.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                            title: Text(widget.listItems[index].name),
                            trailing: Checkbox(
                              activeColor: AppColors.primary,
                              checkColor: Colors.white,
                              value: selectedItems
                                  .contains(widget.listItems[index].name),
                              onChanged: (bool? value) {
                                //edit
                                if (widget.onSelect != null) {
                                  widget.onSelect!(
                                      value, widget.listItems[index].id);
                                }
                                setState(() {
                                  if (selectedItems
                                      .contains(widget.listItems[index].name)) {
                                    selectedItems
                                        .remove(widget.listItems[index].name);
                                  } else {
                                    if (widget.isMultiSelect == false) {
                                      selectedItems = [];
                                    }
                                    selectedItems
                                        .add(widget.listItems[index].name);
                                  }
                                });
                              },
                              side: MaterialStateBorderSide.resolveWith(
                                (states) {
                                  if (!states
                                      .contains(MaterialState.selected)) {
                                    return const BorderSide(color: lightGrey);
                                  }
                                  return BorderSide(color: AppColors.primary);
                                },
                              ),
                            ));
                      },
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: widget.listItems.length * 55,
                      width: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: const BorderRadius.only(
                                      topRight: Radius.circular(5))),
                              width: 7,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                  color: lightGrey,
                                  borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(5))),
                              width: 7,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class ItemModel {
  final int id;
  final String name;
  final String? imageUrl;
  ItemModel({required this.id, required this.name, this.imageUrl});
}
