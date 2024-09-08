import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/app_cubit/cubit.dart';
import 'package:manicann/core/components/app_cubit/states.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/components/delete_dialog.dart';
import 'package:manicann/core/constance/appLink.dart';
import 'package:manicann/core/error/failures.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/features/booking/presentation/bloc/cubit/booking_bolc_cubit.dart';
import 'package:manicann/features/bookings/presentation/bloc/cubit.dart';
import 'package:manicann/features/branches/data/models/branch_model.dart';
import 'package:manicann/features/branches/domain/entities/branch_entity.dart';
import 'package:manicann/features/branches/domain/usecases/branches_usecase.dart';
import 'package:manicann/features/branches/presentation/bloc/branches_bloc/branches_state.dart';
import 'package:manicann/features/branches/presentation/pages/add_branch_screen.dart';
import 'package:manicann/di/injectionContainer.dart' as di;
import 'package:manicann/features/branches/presentation/pages/all_branches_screen.dart';
import 'package:manicann/features/clients/presentation/bloc/cubit.dart';
import 'package:manicann/features/complaints/presentation/bloc/cubit.dart';
import 'package:manicann/features/employees/presentation/bloc/cubit.dart';
import 'package:manicann/features/services/presentation/bloc/cubit/service_bolc_cubit.dart';
import 'package:manicann/features/statistic/presentation/bloc/statistic_bloc/statistic_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BranchesBloc extends Cubit<BranchesState> {
  int branchSelected = 0;
  late BranchesUsecase branchesUsecase;
  List<BranchModel> data = [];
  List<String> selectedWorkDays = [];
  TextEditingController controllerNameBranch = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerLocation = TextEditingController();
  String? startTime, endTime;
  File? pickedImage;
  bool selecetImage = false, isValid = true;
  Uint8List webImage = Uint8List(8);
  GlobalKey<FormState>? formstate = GlobalKey<FormState>();
  SharedPreferences sharedPreferences;
  BranchesBloc(super.initialState,
      {required this.branchesUsecase, required this.sharedPreferences}) {
    print('API:getAllBranches:====>fetch');
    getAllBranches();
    print('API:getAllBranches:====>done');
  }
  changeBrancheSelected(int index, BuildContext context) {
    if (index != branchSelected) {
      showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            function: () async {
              branchSelected = index;
              AppLink.branchId = data[index].id.toString();
              di
                  .sl<SharedPreferences>()
                  .setString('branchId', AppLink.branchId);
              Navigator.pop(context);
              await refreshData(context);
              const CustomToast(type: "Success", msg: "تم تغيير الفرع بنجاح")(
                  context);
              emit(SuccessBranchesState());
            },
            text:
                'تأكيد عملية التغيير من الفرع ${data[branchSelected].id} إلى \nالفرع ${data[index].id} ؟',
          );
        },
      );
    }
  }

  Future<void> selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      // ignore: use_build_context_synchronously
      startTime = picked.format(context);
      emit(SuccessBranchesState());
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
      emit(SuccessBranchesState());
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
        emit(SuccessBranchesState());
      }
    }
  }

  void getAllBranches() async {
    emit(LoadingBranchesState());
    final mapData = await branchesUsecase.getAllBranches();
    emit(mapFailureOrBranchesToState(mapData));
  }

  void addBranch(BuildContext context) async {
    if (!selecetImage) {
      const CustomToast(type: "Warning", msg: "الرجاء إضافة صورة الفرع")(
          context);
      // showSnackBar(context, 'Please select image for the branch', false);
    } else if (selectedWorkDays.isEmpty) {
      const CustomToast(type: "Warning", msg: "الرجاء تحديد أيام عمل الفرع")(
          context);
      // showSnackBar(context, 'Please select work days for the branch', false);
    } else if (formstate!.currentState!.validate()) {
      isValid = true;
      BranchEntity branchEntity = branchEntityData(this);
      emit(LoadingBranchesState());
      final mapData = await branchesUsecase.addBranch(branchEntity);
      // ignore: use_build_context_synchronously
      emit(mapFailureOrBranchToState(mapData, context));
    } else {
      isValid = false;
      emit(SuccessBranchesState());
    }
  }

  BranchesState mapFailureOrBranchesToState(
      Either<Failure, List<BranchModel>> either) {
    return either.fold(
      (l) => ErrorBranchesState(message: mapFailureToMessage(l)),
      (r) {
        data = r;
        print(':::: ${AppLink.branchId}');
        print(data.isNotEmpty);
        if (AppLink.branchId == '0' && data.isNotEmpty) {
          print('333333333333333333333333333');
          AppLink.branchId = data.first.id.toString();
          di.sl<SharedPreferences>().setString('branchId', AppLink.branchId);
        }
        int index = data.indexWhere(
          (element) {
            return element.id == int.parse(AppLink.branchId);
          },
        );

        if (index != -1) {
          branchSelected = index;
        }

        return SuccessBranchesState();
      },
    );
  }

  BranchesState mapFailureOrBranchToState(
      Either<Failure, Unit> either, BuildContext context) {
    return either.fold(
      (l) => ErrorBranchesState(message: mapFailureToMessage(l)),
      (r) {
        getAllBranches();
        var cubit = AppCubit.get(context);
        cubit.screens[1] = const BranchesScreen();
        cubit.emit(ScreenNavigationState());
        const CustomToast(type: "Success", msg: "تم إضافة الفرع بنجاح")(
            context);
        // showSnackBar(context, 'The branch has been added successfully.', true);
        return SuccessBranchesState();
      },
    );
  }

  refreshData(BuildContext context) {
    BookingBloc bookingBloc = BlocProvider.of<BookingBloc>(context);
    StatisticBloc statisticBloc = BlocProvider.of<StatisticBloc>(context);
    ServiceBloc serviceBloc = BlocProvider.of<ServiceBloc>(context);
    EmployeesCubit employeesCubit = BlocProvider.of<EmployeesCubit>(context);
    ClientsCubit clientsCubit = BlocProvider.of<ClientsCubit>(context);
    BookingsCubit bookingsCubit = BlocProvider.of<BookingsCubit>(context);
    ComplaintsCubit complaintsCubit = BlocProvider.of<ComplaintsCubit>(context);
    if (serviceBloc.isBuiled) {
      serviceBloc.getAllServices();
    }
    if (bookingBloc.isBuiled) {
      bookingBloc.getData();
    }
    if (clientsCubit.isBuiled) {
      clientsCubit.getAllClients(int.parse(AppLink.branchId));
    }
    if (statisticBloc.isBuiled) {
      statisticBloc.getAllData();
    }
    if (employeesCubit.isBuiled) {
      employeesCubit.getAllEmployees(int.parse(AppLink.branchId));
    }
    if (bookingsCubit.isBuiled) {
      bookingsCubit.getAllCurrentBookings(int.parse(AppLink.branchId));
    }
    if (complaintsCubit.isBuiled) {
      complaintsCubit.getAllComplaints(int.parse(AppLink.branchId));
    }
  }
}
