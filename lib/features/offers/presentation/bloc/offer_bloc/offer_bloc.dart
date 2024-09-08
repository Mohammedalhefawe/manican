import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/features/offers/domain/entities/offer.dart';
import 'package:manicann/features/offers/domain/entities/offer_entity_data.dart';
import 'package:manicann/features/offers/domain/usecases/offers_usecase.dart';
import 'package:manicann/features/offers/presentation/bloc/offer_bloc/offer_state.dart';

class OffersBloc extends Cubit<OfferState> {
  late TextEditingController title = TextEditingController();
  late TextEditingController description = TextEditingController();
  late OffersUsecase offersUsecase;
  File? pickedImage;
  bool selecetImage = false, isValid = true;
  Uint8List webImage = Uint8List(8);
  GlobalKey<FormState>? formstate = GlobalKey<FormState>();

  List<OfferEntity> data = [];
  OffersBloc(super.initialState, {required this.offersUsecase}) {
    print('API:getAllServices:====>fetch');
    getOffers();
    print('API:getAllServices:====>done');
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final ImagePicker pick = ImagePicker();
      XFile? image = await pick.pickImage(source: ImageSource.gallery);
      if (image != null) {
        webImage = await image.readAsBytes();
        pickedImage = File(image.name);
        selecetImage = true;
        emit(SuccessOfferState());
      }
    }
  }

  addOffer(BuildContext context) async {
    if (!selecetImage) {
      Navigator.of(context).pop();
      const CustomToast(type: "Warning", msg: "الرجاء إضافة صورة العرض")(
          context);
      // showSnackBar(context, 'Please select image for the sevice', false);
    } else if (formstate!.currentState!.validate()) {
      isValid = true;
      OfferEntityData offerEntity = offerEntityData();
      emit(LoadingOfferState());
      final mapData = await offersUsecase.addOffer(offerEntity);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      emit(mapFailureOrAddOfferToState(mapData, context, null));
    } else {
      isValid = false;
      emit(SuccessOfferState());
    }
  }

  editOffer(String id, BuildContext context) async {
    if (!selecetImage) {
      Navigator.of(context).pop();
      const CustomToast(type: "Warning", msg: "الرجاء إضافة صورة العرض")(
          context);
    } else if (formstate!.currentState!.validate()) {
      isValid = true;
      OfferEntityData offerEntity = offerEntityData();
      emit(LoadingOfferState());
      final mapData = await offersUsecase.editOffer(offerEntity, id);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      emit(mapFailureOrEditOfferToState(mapData, context, null));
    } else {
      isValid = false;
      emit(SuccessOfferState());
    }
  }

  fillDataForEdit(OfferEntity offerEntity) {
    title = TextEditingController(text: offerEntity.title);
    description = TextEditingController(text: offerEntity.description);
  }

  deleteOffer(String id, BuildContext context) async {
    emit(LoadingOfferState());
    final mapData = await offersUsecase.deleteOffer(id);
    emit(mapFailureOrDeleteOfferToState(mapData, context, null));
  }

  OfferEntityData offerEntityData() {
    return OfferEntityData(
        name: title.text,
        description: description.text,
        image: webImage,
        filePath: pickedImage!.path);
  }

  Future getOffers() async {
    emit(LoadingOfferState());
    final mapData = await offersUsecase.getAllOffers();
    emit(mapFailureOrOffersToState(mapData));
    // mapData.fold((Failure l) => l, (r) => r);
  }

  OfferState mapFailureOrOffersToState(
      Either<Failure, List<OfferEntity>> either) {
    return either.fold(
      (l) => ErrorOfferState(message: mapFailureToMessage(l)),
      (r) {
        data = r;
        return SuccessOfferState();
      },
    );
  }

  OfferState mapFailureOrAddOfferToState(
      Either<Failure, Unit> either, BuildContext context, String? msg) {
    return either.fold(
      (l) => ErrorAddOfferState(message: mapFailureToMessage(l)),
      (r) {
        getOffers().then((v) {
          if (msg != null) {
            CustomToast(type: "Success", msg: msg)(context);
          }
        });
        // showSnackBar(context, 'The service has been added successfully.', true);

        return SuccessAddOfferState();
      },
    );
  }

  OfferState mapFailureOrEditOfferToState(
      Either<Failure, Unit> either, BuildContext context, String? msg) {
    return either.fold(
      (l) => ErrorEditOfferState(message: mapFailureToMessage(l)),
      (r) {
        getOffers().then((v) {
          if (msg != null) {
            CustomToast(type: "Success", msg: msg)(context);
          }
        });
        // showSnackBar(context, 'The service has been added successfully.', true);

        return SuccessEditOfferState();
      },
    );
  }

  OfferState mapFailureOrDeleteOfferToState(
      Either<Failure, Unit> either, BuildContext context, String? msg) {
    return either.fold(
      (l) => ErrorDeleteOfferState(message: mapFailureToMessage(l)),
      (r) {
        getOffers().then((v) {
          if (msg != null) {
            CustomToast(type: "Success", msg: msg)(context);
          }
        });
        // showSnackBar(context, 'The service has been added successfully.', true);

        return SuccessDeleteOfferState();
      },
    );
  }
}
