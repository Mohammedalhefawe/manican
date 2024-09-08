import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/core/function/time_formatter.dart';
import 'package:manicann/features/services/domain/entities/service.dart';
import 'package:manicann/features/services/domain/entities/service_discount_entity_data.dart';
import 'package:manicann/features/services/domain/entities/service_entity_data.dart';
import 'package:manicann/features/services/domain/usecases/services_usecase.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_state.dart';

class ServiceBloc extends Cubit<ServiceState> {
  ServiceBloc(super.initialState, {required this.servicesUsecase}) {
    isBuiled = true;
    print('API:getAllServices:====>fetch');
    getAllServices();
    print('API:getAllServices:====>done');
  }
  bool isBuiled = false;
  late ServicesUsecase servicesUsecase;
  TextEditingController controllerNameService = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  TextEditingController controllerPerioud = TextEditingController();
  TextEditingController controllerDiscount = TextEditingController();
  String? startTime, endTime;
  String? startDate, endDate;
  List<ServiceEntity> data = [];
  List<int> serviceIds = [];
  File? pickedImage;
  bool selecetImage = false, isValid = true;
  Uint8List webImage = Uint8List(8);
  GlobalKey<FormState>? formstate = GlobalKey<FormState>();

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      // ignore: use_build_context_synchronously
      startTime = picked.format(context);
      emit(SuccessServiceState());
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      // ignore: use_build_context_synchronously
      endTime = picked.format(context);
      emit(SuccessServiceState());
    }
  }

  Future<void> pickImage() async {
    if (kIsWeb) {
      final ImagePicker pick = ImagePicker();
      XFile? image = await pick.pickImage(source: ImageSource.gallery);
      if (image != null) {
        webImage = await image.readAsBytes();
        pickedImage = File(image.name);
        selecetImage = true;
        emit(SuccessServiceState());
      }
    }
  }

  void getAllServices() async {
    emit(LoadingServiceState());
    final mapData = await servicesUsecase.getAllServices();
    emit(mapFailureOrServicesToState(mapData));
    // mapData.fold((Failure l) => l, (r) => r);
  }

  void addService(BuildContext context) async {
    if (!selecetImage) {
      Navigator.of(context).pop();
      const CustomToast(type: "Warning", msg: "يرجى اضافة صورة الخدمة")(
          context);

      // showSnackBar(context, 'Please select image for the service', false);
    } else if (formstate!.currentState!.validate()) {
      isValid = true;
      ServiceEntityData serviceEntityData = serviceEntity();
      emit(LoadingServiceState());
      final mapData = await servicesUsecase.addService(serviceEntityData);
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      emit(mapFailureOrServiceToState(mapData, context));
    } else {
      isValid = false;

      emit(SuccessServiceState());
    }
  }

  void addSpecialist(BuildContext context) {}

  void addDiscount(BuildContext context) async {
    if (formstate!.currentState!.validate()) {
      isValid = true;
      ServiceDiscountEntity serviceDiscount = serviceDiscountEntity();
      emit(LoadingServiceState());
      final mapData = await servicesUsecase.addDiscount(serviceDiscount);
      Navigator.of(context).pop();
      // ignore: use_build_context_synchronously
      emit(mapFailureOrServiceDiscountToState(mapData, context));
    } else {
      isValid = false;
      emit(SuccessServiceState());
    }
  }

  ServiceEntityData serviceEntity() {
    return ServiceEntityData(
        branchId: AppLink.branchId,
        name: controllerNameService.text,
        price: controllerPrice.text.toString(),
        period: controllerPerioud.text.toString(),
        from: convertTimeFormatForBackEnd(startTime ?? "1:00 PM"),
        to: convertTimeFormatForBackEnd(endTime ?? "2:00 PM"),
        image: webImage,
        filePath: pickedImage!.path);
  }

  ServiceDiscountEntity serviceDiscountEntity() {
    return ServiceDiscountEntity(
      services: serviceIds,
      from: startDate ?? "2024-07-10",
      to: endDate ?? "2024-08-10",
      value: controllerDiscount.text.toString(),
    );
  }

  ServiceState mapFailureOrServicesToState(
      Either<Failure, List<ServiceEntity>> either) {
    return either.fold(
      (l) => ErrorServiceState(message: mapFailureToMessage(l)),
      (r) {
        data = r;
        return SuccessServiceState();
      },
    );
  }

  ServiceState mapFailureOrServiceToState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold(
      (l) => ErrorServiceState(message: mapFailureToMessage(l)),
      (r) {
        getAllServices();
        const CustomToast(type: "Success", msg: "تم إضافة الخدمة بنجاح")(
            context);
        // showSnackBar(context, 'The servic has been added successfully.', true);
        return SuccessServiceState();
      },
    );
  }

  ServiceState mapFailureOrServiceDiscountToState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold(
      (l) => ErrorServiceState(message: mapFailureToMessage(l)),
      (r) {
        getAllServices();
        // showSnackBar(
        //     context, 'The discount has been added successfully.', true);
        const CustomToast(type: "Success", msg: "تم إضافة الخصم  بنجاح")(
            context);
        return SuccessServiceState();
      },
    );
  }
}
