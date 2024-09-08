import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:manicann/features/employees/data/models/file_employee_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/core/components/custom_toast.dart';
import 'package:manicann/core/function/error_message.dart';
import 'package:manicann/features/employees/domain/entities/attendance.dart';
import 'package:manicann/features/employees/domain/entities/file_attendance.dart';
import 'package:manicann/features/employees/domain/usecases/add_employee_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/delete_employee_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/get_all_employees_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/get_all_services_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/get_employee_attendance_use_case.dart';
import 'package:manicann/features/employees/domain/usecases/upload_file_attendance_use_case.dart';
import 'package:manicann/features/employees/presentation/bloc/states.dart';
import 'package:manicann/models.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/constance/constance.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/employee.dart';
import '../../domain/entities/service.dart';
import '../../domain/usecases/edit_employee_use_case.dart';

class EmployeesCubit extends Cubit<EmployeesStates> {
  EmployeesCubit({
    required this.getAllEmployeesUseCase,
    required this.fileEmployeeAttendanceUseCase,
    required this.getAllServicesUseCase,
    required this.addEmployeeUseCase,
    required this.deleteEmployeeUseCase,
    required this.editEmployeeUseCase,
    required this.getEmployeeAttendanceUseCase,
  }) : super(EmployeesInitialState()) {
    isBuiled = true;
  }
  static EmployeesCubit get(context) => BlocProvider.of(context);
  bool isBuiled = false;
  List<Employee> allEmployeesList = [];
  List<Employee> employeesList = [];

  // Drop Down Section
  List<DropdownMenuItem<Text>> employeesFilterTypes = [
    const DropdownMenuItem<Text>(
      value: Text("أبجدياً"),
      child: Text("أبجدياً"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("الأحدث"),
      child: Text("الأحدث"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("الوظيفة"),
      child: Text("الوظيفة"),
    ),
  ];

  Text? employeesTableFilterType;
  void changeEmployeesTableFilter(Text? text) {
    employeesTableFilterType = text;
    if (text != null) sortList(text.data);
    emit(EmployeesTableChangingFilterState());
  }

  void invalidFieldErrorTrigger() {
    emit(AddEmployeeEmptyFieldsWarningState(
        error: "هنالك خلل في البيانات المدخلةً"));
  }

  void sortList(String? type) {
    if (type == null) return;
    if (type == "الأحدث") {
      employeesList.sort((a, b) {
        if (a.startDate != null && b.startDate != null) {
          return b.startDate!.compareTo(a.startDate!);
        } else {
          return 0;
        }
      });
    } else if (type == "الوظيفة") {
      employeesList.sort((a, b) {
        if (a.position != null && b.position != null) {
          return a.position!.compareTo(b.position!);
        } else {
          return 0;
        }
      });
    } else {
      employeesList.sort((a, b) {
        if (a.firstName != null &&
            a.lastName != null &&
            b.firstName != null &&
            b.lastName != null) {
          final int firstNameComparison =
              b.firstName?.compareTo(a.firstName!) ?? 0;
          if (firstNameComparison != 0) {
            return firstNameComparison;
          }
          return b.lastName?.compareTo(a.lastName!) ?? 0;
        }
        return 0;
      });
    }
    changeEmpTablePage(1);
  }

  // Search Section
  void searchInList(String? text) {
    employeesTablePageIndex = 1;

    final List<Employee> filteredList = [];
    if (text == null || text == "") {
      employeesList = allEmployeesList;
    } else {
      for (final employee in allEmployeesList) {
        if (employee.firstName!.toLowerCase().startsWith(text.toLowerCase()) ||
            employee.lastName!.toLowerCase().startsWith(text.toLowerCase())) {
          filteredList.add(employee);
        }
      }
      employeesList = filteredList;
    }
    emit(EmployeesTableSearchState());
  }

  // Table Section
  int employeesTablePageIndex = 1;
  void changeEmpTablePage(int page) {
    employeesTablePageIndex = page;
    emit(EmployeesTableChangingPageState());
  }

  // Add Employee Page Section
  int addEmpPageIndex = 0;
  void addEmpPageChange(int index) {
    addEmpPageIndex = index;
    emit(EmployeesAddPageViewState());
  }

  List<String> jobPositions = [];
  int selectedJobPosition = 0;
  void selectJobPosition(int index) {
    selectedJobPosition = index;
    selectedSalaryType = 0;
    if (index == 0) {
      salaryTypes = ["ثابت", "ثابت مع نسبة"];
    } else if (index == 2) {
      salaryTypes = ["نسبة"];
    } else {
      salaryTypes = ["ثابت"];
    }
    emit(EmployeesJobPositionSelectionState());
  }

  List<String> salaryTypes = ["ثابت", "ثابت مع نسبة"];
  List<String> allSalaryTypes = ["ثابت", "ثابت مع نسبة", "نسبة"];

  int selectedSalaryType = 0;
  void selectSalaryType(int index) {
    selectedSalaryType = index;
    emit(EmployeesSalaryTypeSelectionState());
  }

  Uint8List? imageBytes;
  PlatformFile? imageFile;
  void addEmployeeProfilePicture() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        imageFile = result.files.first;
        imageBytes = imageFile!.bytes!;
      }
      emit(EmployeesAddProfilePictureSuccessState());
    } catch (e) {
      emit(EmployeesAddProfilePictureErrorState());
    }
  }

  // UseCase Calls Section

  final GetAllEmployeesUseCase getAllEmployeesUseCase;
  void getAllEmployees(int branchId) async {
    emit(GetEmployeesLoadingState());
    final failureOrEmployees = await getAllEmployeesUseCase(branchId: branchId);
    failureOrEmployees.fold(
      (failure) {
        emit(GetEmployeesErrorState(error: _mapFailureToString(failure)));
      },
      (employees) {
        employeesList = employees;
        allEmployeesList = employees;
        sortList("أبجدياً");
        jobPositions = "admin" == AppLink.role
            ? ["اختصاصي تجميل", "محاسب", "دكتور", "مسؤول موارد بشرية"]
            : ["اختصاصي تجميل", "محاسب", "دكتور"];
        getAllServices(branchId);
        emit(GetEmployeesSuccessState());
      },
    );
  }

  List<ServiceEntity> servicesList = [];
  List<ServiceEntity> selectedServices = [];

  void selectServiceForEmployee(int index) {
    if (selectedServices.contains(servicesList[index])) {
      selectedServices.remove(servicesList[index]);
    } else {
      selectedServices.add(servicesList[index]);
    }
    emit(ChangeSelectedServicesState());
  }

  final GetAllServicesUseCase getAllServicesUseCase;
  void getAllServices(int branchId) async {
    emit(GetServicesLoadingState());
    final failureOrServices = await getAllServicesUseCase(branchId: branchId);
    failureOrServices.fold(
      (failure) {
        emit(GetServicesErrorState(error: _mapFailureToString(failure)));
      },
      (services) {
        servicesList = services;
        emit(GetServicesSuccessState());
      },
    );
  }

  final DeleteEmployeeUseCase deleteEmployeeUseCase;
  void deleteEmployee({required int employeeId}) async {
    emit(DeleteEmployeeLoadingState());
    final failureOrUnit = await deleteEmployeeUseCase(employeeId);
    failureOrUnit.fold(
      (failure) {
        emit(DeleteEmployeeErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        getAllEmployees(int.parse(AppLink.branchId));
        emit(DeleteEmployeeSuccessState());
      },
    );
  }

  final AddEmployeeUseCase addEmployeeUseCase;
  void addEmployee({
    required String firstName,
    required String middleName,
    required String lastName,
    required String phoneNumber,
    required String nationalId,
    required String? pin,
    required String salary,
    required String? ratio,
    required String? email,
    required String? password,
  }) async {
    emit(AddEmployeeLoadingState());
    final failureOrUnit = await addEmployeeUseCase(
      Employee(
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        branchId: int.parse(AppLink.branchId),
        role: "employee",
        salary: double.parse(salary),
        isFixed:
            salaryTypes[selectedSalaryType] == allSalaryTypes[0] ? true : false,
        position: jobPositions[selectedJobPosition],
        startDate: DateTime.now(),
        nationalId: nationalId,
        pin: pin != null ? int.parse(pin) : null,
        email: email,
        password: password,
        services: selectedServices,
        ratio: ratio != null ? double.parse(ratio) : null,
      ),
      imageFile,
    );
    failureOrUnit.fold(
      (failure) {
        emit(AddEmployeeErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        imageBytes = null;
        imageFile = null;

        emit(AddEmployeeSuccessState());
      },
    );
  }

  //edit
  Employee? selectedEmployeeToEdit;
  selectEmployeeToEdit({required Employee employee}) {
    List<ServiceEntity> tmp = [];
    for (int i = 0; i < employee.services!.length; i++) {
      tmp.add(ServiceEntity(
          id: employee.services![i].id, name: employee.services![i].name));
    }
    selectedEmployeeToEdit = Employee(
      id: employee.id,
      firstName: employee.firstName,
      middleName: employee.middleName,
      lastName: employee.lastName,
      phoneNumber: employee.phoneNumber,
      nationalId: employee.nationalId,
      branchId: employee.branchId,
      role: employee.role,
      position: employee.position,
      pin: employee.id,
      email: employee.email,
      password: employee.password,
      salary: employee.salary,
      ratio: employee.ratio,
      isFixed: employee.isFixed,
      image: employee.image != null
          ? ImageModel(
              id: employee.image!.id,
              imageableType: employee.image!.imageableType,
              imageableId: employee.image!.imageableId,
              image: employee.image!.image,
              type: employee.image!.type,
            )
          : null,
      services: tmp,
      startDate: employee.startDate,
    );
    emit(EmployeeToEditSelectionState());
  }

  Uint8List? editImageBytes;
  PlatformFile? editImageFile;
  void editEmployeeProfilePicture() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null) {
        editImageFile = result.files.first;
        editImageBytes = editImageFile!.bytes!;
      }
      emit(EmployeesEditProfilePictureSuccessState());
    } catch (e) {
      emit(EmployeesEditProfilePictureErrorState());
    }
  }

  EditEmployeeUseCase editEmployeeUseCase;
  void editEmployee({
    required String? firstName,
    required String? middleName,
    required String? lastName,
    required String? phoneNumber,
    required String? nationalId,
    required String? pin,
    required String? salary,
    required String? ratio,
    required String? email,
    required String? password,
  }) async {
    bool nothingChanged = true;
    List<int> addedServices = [];
    List<int> deletedServices = [];
    if (true) {
      if (firstName == selectedEmployeeToEdit!.firstName) {
        firstName = null;
      } else {
        nothingChanged = false;
      }
      if (middleName == selectedEmployeeToEdit!.middleName) {
        middleName = null;
      } else {
        nothingChanged = false;
      }
      if (lastName == selectedEmployeeToEdit!.lastName) {
        lastName = null;
      } else {
        nothingChanged = false;
      }
      if (phoneNumber == selectedEmployeeToEdit!.phoneNumber) {
        phoneNumber = null;
      } else {
        nothingChanged = false;
      }
      if (nationalId == selectedEmployeeToEdit!.nationalId) {
        nationalId = null;
      } else {
        nothingChanged = false;
      }
      if (pin != null && selectedEmployeeToEdit!.pin != null) {
        if (int.parse(pin) == selectedEmployeeToEdit!.pin) {
          pin = null;
        } else {
          nothingChanged = false;
        }
      }
      if (email != null && selectedEmployeeToEdit!.email != null) {
        if (email == selectedEmployeeToEdit!.email) {
          email = null;
        } else {
          nothingChanged = false;
        }
      }
      if (password != null && selectedEmployeeToEdit!.password != null) {
        if (password == selectedEmployeeToEdit!.password) {
          password = null;
        } else {
          nothingChanged = false;
        }
      }
      if (salary != null) {
        if (double.parse(salary) == selectedEmployeeToEdit!.salary) {
          salary = null;
        } else {
          nothingChanged = false;
        }
      }
      if (ratio != null && selectedEmployeeToEdit!.ratio != null) {
        if (double.parse(ratio) == selectedEmployeeToEdit!.ratio) {
          ratio = null;
        } else {
          nothingChanged = false;
        }
      }

      if (jobPositions[selectedJobPosition] != selectedEmployeeToEdit!.position)
        nothingChanged = false;

      if (selectedJobPosition == 0 || selectedJobPosition == 2) {
        addedServices = _differenceWithLoop(
            selectedServices, selectedEmployeeToEdit!.services!);
        deletedServices = _differenceWithLoop(
            selectedEmployeeToEdit!.services!, selectedServices);
        if (addedServices.isNotEmpty || deletedServices.isNotEmpty)
          nothingChanged = false;
      }

      bool tmp =
          salaryTypes[selectedSalaryType] == allSalaryTypes[0] ? true : false;

      if (tmp != selectedEmployeeToEdit!.isFixed) nothingChanged = false;

      if (editImageBytes != null) nothingChanged = false;
    }
    if (nothingChanged) {
      emit(EditEmployeeNothingChangedState());
      return;
    } else {
      emit(EditEmployeeLoadingState());
      final failureOrUnit = await editEmployeeUseCase(
        Employee(
          id: selectedEmployeeToEdit!.id,
          firstName: firstName,
          middleName: middleName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          branchId: int.parse(AppLink.branchId),
          role: "employee",
          salary: salary != null ? double.parse(salary) : null,
          isFixed: salaryTypes[selectedSalaryType] == allSalaryTypes[0]
              ? true
              : false,
          position: jobPositions[selectedJobPosition],
          startDate: null,
          nationalId: nationalId,
          pin: pin != null ? int.parse(pin) : null,
          email: email,
          password: password,
          ratio: ratio != null ? double.parse(ratio) : null,
        ),
        editImageFile,
        addedServices,
        deletedServices,
      );
      failureOrUnit.fold(
        (failure) {
          emit(EditEmployeeErrorState(error: _mapFailureToString(failure)));
        },
        (unit) {
          editImageBytes = null;
          editImageFile = null;

          emit(EditEmployeeSuccessState());
        },
      );
    }
  }

  // Details
  Employee? detailsEmployee;
  selectEmployeeToShowDetails({required Employee employee}) {
    detailsEmployee = employee;
    emit(EmployeeToShowDetailsSelectionState());
  }

  List<Attendance> attendanceList = [];

  // Attendance

  List<DropdownMenuItem<Text>> attendanceFilterTypes = [
    const DropdownMenuItem<Text>(
      value: Text("الأحدث"),
      child: Text("الأحدث"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("اليوم"),
      child: Text("اليوم"),
    ),
  ];

  Text? attendanceTableFilterType;
  void changeAttendanceTableFilter(Text? text) {
    attendanceTableFilterType = text;
    if (text != null) sortAttendanceList(text.data);
    emit(AttendanceTableChangingFilterState());
  }

  void sortAttendanceList(String? type) {
    if (type == null) return;
    if (type == "الأحدث") {
      attendanceList.sort((a, b) {
        if (a.date != null && b.date != null) {
          return a.date!.compareTo(b.date!);
        } else {
          return 0;
        }
      });
    } else {
      attendanceList.sort((a, b) {
        if (a.day != null &&
            a.date != null &&
            b.date != null &&
            b.day != null) {
          final int dayComparison = b.day?.compareTo(a.day!) ?? 0;
          if (dayComparison != 0) {
            return dayComparison;
          }
          return b.date?.compareTo(a.date!) ?? 0;
        }
        return 0;
      });
    }
    changeAttendanceTablePage(1);
  }

  int attendanceTablePageIndex = 1;
  void changeAttendanceTablePage(int page) {
    attendanceTablePageIndex = page;
    emit(AttendanceTableChangingPageState());
  }

  GetEmployeeAttendanceUseCase getEmployeeAttendanceUseCase;
  getEmployeeAttendance({required int employeeId}) async {
    emit(GetEmployeeAttendanceLoadingState());
    final failureOrServices =
        await getEmployeeAttendanceUseCase(employeeId: employeeId);
    failureOrServices.fold(
      (failure) {
        emit(GetEmployeeAttendanceErrorState(
            error: _mapFailureToString(failure)));
      },
      (attendance) {
        attendanceList = attendance;
        emit(GetEmployeeAttendanceSuccessState());
      },
    );
  }

  List<int> _differenceWithLoop(List<ServiceEntity> a, List<ServiceEntity> b) {
    List<int> result = [];
    for (var element in a) {
      if (!b.contains(element)) result.add(element.id);
    }
    return result;
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }

///////////////////////////////////
  File? pickedTextFile;
  Uint8List? webTextFile;

  Future<void> pickTextFile(BuildContext context) async {
    if (kIsWeb) {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'json'], // Allow both TXT and JSON files
      );
      if (result != null && result.files.isNotEmpty) {
        // Ensure that the result is not null and contains files
        webTextFile = result.files.first.bytes;
        // Create a temporary file path for the web
        pickedTextFile = File(result.files.first.name);
        uploadFileAttendance(context);
      } else {
        // Handle the case where no file was selected
        const CustomToast(type: "Warning", msg: 'لم يتم أختيار ملف البصامة')(
            context);
      }
    }
  }

  FileEmployeeAttendanceUseCase fileEmployeeAttendanceUseCase;
  uploadFileAttendance(BuildContext context) async {
    emit(UploadFileAttendanceLoading());
    final mapData = await fileEmployeeAttendanceUseCase.uploadFileAttendance(
        FileAttendanceEntity(
            file: webTextFile, filePath: pickedTextFile!.path));
    // Navigator.of(context).pop();
    emit(mapFailureOrOfferToState(mapData, context, "تم رفع الملف بنجاح"));
  }

  EmployeesStates mapFailureOrOfferToState(
      Either<Failure, Unit> either, BuildContext context, String msg) {
    return either.fold(
      (l) {
        const CustomToast(
            type: "Error",
            msg: 'حدث خطأ إثناء رفع الملف , أعد المحاولة لاحقاً')(context);
        return UploadFileAttendanceError(message: mapFailureToMessage(l));
      },
      (r) {
        CustomToast(type: "Success", msg: msg)(context);
        return UploadFileAttendanceSuccess();
      },
    );
  }

  DateTime? _selectedDate;
  bool validTime = false;
  Future<void> selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      _selectedDate = pickedDate;
      validTime = true;
      emit(ReportEmployeeSuccessState());
    } else {
      const CustomToast(
        type: "Warning",
        msg: " الرجاء اختيار تاريخ",
      )(context);
    }
  }

  getReportEmployee(String? idEmployee, BuildContext context) async {
    await selectDate(context);
    if (validTime) {
      emit(ReportEmployeeLoadingState());
      final mapData = await fileEmployeeAttendanceUseCase
          .downloadFileAttendance(DownloadFileEntity(
              date: DateFormat('yyyy-MM-dd').format(_selectedDate!),
              idEmployee: idEmployee));
      validTime = false;
      emit(mapFailureOrReportEmployeeToState(
          mapData, context, 'تم تحميل التقرير بنجاح'));
    }
  }

  EmployeesStates mapFailureOrReportEmployeeToState(
      Either<Failure, FileResponseModel> either,
      BuildContext context,
      String msg) {
    return either.fold(
      (l) {
        return ReportEmployeeErrorState(error: mapFailureToMessage(l));
      },
      (r) {
        if (r.original.fileUrl != null) {
          launchURL(r.original.fileUrl!, context);
        }
        return ReportEmployeeSuccessState();
      },
    );
  }

  void launchURL(String url, BuildContext context) async {
    final Uri uri = Uri.parse(url);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Show an error message if the URL cannot be launched
        const CustomToast(
          type: "Error",
          msg: 'حدث خطأ أثناء فتح الرابط , حاول مجدداً',
        )(context);
      }
    } catch (e) {
      // Handle any exceptions that occur during the launch
      print('Error launching URL: $e');
      const CustomToast(
        type: "Error",
        msg: 'حدث خطأ أثناء فتح الرابط, حاول مجدداً',
      )(context);
    }
  }
}
