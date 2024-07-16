import 'package:flutter/material.dart';

class AddCustomer {
  final TextEditingController firstName;
  final TextEditingController midName;
  final TextEditingController lastName;
  final TextEditingController phoneNumber;
  final onCancel;
  final onAdd;
  AddCustomer(this.firstName, this.midName, this.lastName, this.phoneNumber,
      this.onCancel, this.onAdd);
}
