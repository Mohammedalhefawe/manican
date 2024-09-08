import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/features/before_after/data/models/before_after_model.dart';
import 'package:manicann/features/before_after/domain/entities/before_after_entity_data.dart';
import 'package:manicann/features/before_after/domain/usecases/before_after_usecase.dart';
import 'package:manicann/features/before_after/presentation/bloc/cubit/before_after_state.dart';

class BeforeAfterBloc extends Cubit<BeforeAfterState> {
  BeforeAfterBloc(super.initialState, {required this.beforeAfterUsecase}) {
    print('API:getAllBeforeAfters:====>fetch');
    getAllData();
    print('API:getAllBeforeAfters:====>done');
  }
  late BeforeAfterUsecase beforeAfterUsecase;
  TextEditingController controllerDiscription = TextEditingController();
  List<BeforeAfterModel> data = [];
  File? pickedImageBefore, pickedImageAfter;
  bool selecetImageBefore = false, selecetImageAfter = false, isValid = true;
  Uint8List webImageBefore = Uint8List(8);
  Uint8List webImageAfter = Uint8List(8);
  GlobalKey<FormState>? formstate = GlobalKey<FormState>();

  Future<void> pickImage(bool isBefore) async {
    if (kIsWeb) {
      final ImagePicker pick = ImagePicker();
      XFile? image = await pick.pickImage(source: ImageSource.gallery);
      if (image != null) {
        if (isBefore) {
          webImageBefore = await image.readAsBytes();
          pickedImageBefore = File(image.name);
          selecetImageBefore = true;
        } else {
          webImageAfter = await image.readAsBytes();
          pickedImageAfter = File(image.name);
          selecetImageAfter = true;
        }
        emit(SuccessBeforeAfterState());
      }
    }
  }

  void getAllData() async {
    emit(LoadingBeforeAfterState());
    final mapData = await beforeAfterUsecase.getAllBeforeAfter();
    emit(mapFailureOrBeforeAfterToState(mapData));
    // mapData.fold((Failure l) => l, (r) => r);
  }

  void addData(BuildContext context) async {
    if (!selecetImageBefore) {
      Navigator.of(context).pop();
      const CustomToast(type: "Warning", msg: "الرجاء إضافة صورة قبل المعالجة")(
          context);
      // showSnackBar(context, 'Please select image for the before', false);
    }
    if (!selecetImageAfter) {
      if (selecetImageBefore) Navigator.of(context).pop();
      const CustomToast(type: "Warning", msg: "الرجاء إضافة صورة بعد المعالجة")(
          context);
      // showSnackBar(context, 'Please select image for the after', false);
    } else if (formstate!.currentState!.validate()) {
      isValid = true;
      BeforeAfterEntityData beforeAfterEntityData = beforeAfterEntity();
      emit(LoadingBeforeAfterState());
      final mapData =
          await beforeAfterUsecase.addBeforeAfter(beforeAfterEntityData);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      emit(mapFailureOrAddBeforeAfterToState(mapData, context));
    } else {
      isValid = false;
      emit(SuccessBeforeAfterState());
    }
  }

  Future deleteData(String idBeforAfter, BuildContext context) async {
    emit(LoadingBeforeAfterState());
    final mapData = await beforeAfterUsecase.deleteBeforeAfter(idBeforAfter);
    // ignore: use_build_context_synchronously
    emit(mapFailureOrDeleteBeforeAfterToState(mapData, context));
  }

  void editData(String id) {}

  BeforeAfterEntityData beforeAfterEntity() {
    print(controllerDiscription.text.toString());
    return BeforeAfterEntityData(
        description: controllerDiscription.text.toString(),
        imageBefore: webImageBefore,
        imageAfter: webImageAfter,
        filePathBefore: pickedImageBefore!.path,
        filePathAfter: pickedImageAfter!.path);
  }

  BeforeAfterState mapFailureOrBeforeAfterToState(
      Either<Failure, List<BeforeAfterModel>> either) {
    return either.fold(
      (l) => ErrorBeforeAfterState(message: mapFailureToMessage(l)),
      (r) {
        data = r;
        return SuccessBeforeAfterState();
      },
    );
  }

  BeforeAfterState mapFailureOrAddBeforeAfterToState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold(
      (l) => ErrorBeforeAfterState(message: mapFailureToMessage(l)),
      (r) {
        getAllData();
        const CustomToast(
            type: "Success",
            msg: "تم إضافة عملية قبل وبعد المعالجة بنجاح")(context);
        // showSnackBar(
        //     context, 'The Before & After has been added successfully.', true);
        return SuccessBeforeAfterState();
      },
    );
  }

  BeforeAfterState mapFailureOrDeleteBeforeAfterToState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold(
      (l) => ErrorBeforeAfterState(message: mapFailureToMessage(l)),
      (r) {
        getAllData();

        return SuccessBeforeAfterState();
      },
    );
  }
}
