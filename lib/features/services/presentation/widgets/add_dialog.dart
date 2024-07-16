import 'package:flutter/material.dart';

class AddServiceData {
  final TextEditingController controller;
  final String hintText;
  final void Function()? addImage;
  final onCancel;
  final onAdd;
  AddServiceData(
      this.controller, this.hintText, this.addImage, this.onCancel, this.onAdd);
}
