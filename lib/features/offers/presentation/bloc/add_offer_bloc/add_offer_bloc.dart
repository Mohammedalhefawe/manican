import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manican/features/offers/presentation/bloc/add_offer_bloc/add_offer_state.dart';

class AddOfferBloc extends Cubit<AddOfferState> {
  late TextEditingController title;
  late TextEditingController description;
  File? file;
  bool hasImage = false;


  AddOfferBloc() : super(AddOfferInitial()) {
    title = TextEditingController();
    description = TextEditingController();
  }

  addImage() {
    //    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   file = File(image.path);
    //   hasImage = true;
    //   print(file);
    //   update();
    // } else {
    //   // Get.defaultDialog(middleText: 'You must switch image');
    // }
  }

  addOffer() {}
}
