abstract class EmployeesStates {}

class EmployeesInitialState extends EmployeesStates {}

class EmployeesTableChangingFilterState extends EmployeesStates {}

class EmployeesTableSearchState extends EmployeesStates {}

class EmployeesTableChangingPageState extends EmployeesStates {}

class EmployeesJobPositionSelectionState extends EmployeesStates {}

class EmployeesSalaryTypeSelectionState extends EmployeesStates {}

class EmployeesAddProfilePictureSuccessState extends EmployeesStates {}

class EmployeesAddProfilePictureErrorState extends EmployeesStates {}

class EmployeesAddPageViewState extends EmployeesStates {}

class ChangeSelectedServicesState extends EmployeesStates {}

class GetEmployeesLoadingState extends EmployeesStates {}

class GetEmployeesSuccessState extends EmployeesStates {}

class GetEmployeesErrorState extends EmployeesStates {
  final String error;

  GetEmployeesErrorState({required this.error});
}

class GetServicesLoadingState extends EmployeesStates {}

class GetServicesSuccessState extends EmployeesStates {}

class GetServicesErrorState extends EmployeesStates {
  final String error;

  GetServicesErrorState({required this.error});
}

class DeleteEmployeeLoadingState extends EmployeesStates {}

class DeleteEmployeeSuccessState extends EmployeesStates {}

class DeleteEmployeeErrorState extends EmployeesStates {
  final String error;

  DeleteEmployeeErrorState({required this.error});
}

class ReportEmployeeLoadingState extends EmployeesStates {}

class ReportEmployeeSuccessState extends EmployeesStates {}

class ReportEmployeeErrorState extends EmployeesStates {
  final String error;

  ReportEmployeeErrorState({required this.error});
}

class AddEmployeeLoadingState extends EmployeesStates {}

class AddEmployeeSuccessState extends EmployeesStates {}

class AddEmployeeErrorState extends EmployeesStates {
  final String error;

  AddEmployeeErrorState({required this.error});
}

class AddEmployeeEmptyFieldsWarningState extends EmployeesStates {
  final String error;

  AddEmployeeEmptyFieldsWarningState({required this.error});
}

class EmployeeToEditSelectionState extends EmployeesStates {}

class EmployeesEditProfilePictureSuccessState extends EmployeesStates {}

class EmployeesEditProfilePictureErrorState extends EmployeesStates {}

class EditEmployeeNothingChangedState extends EmployeesStates {}

class EditEmployeeLoadingState extends EmployeesStates {}

class EditEmployeeSuccessState extends EmployeesStates {}

class EditEmployeeErrorState extends EmployeesStates {
  final String error;

  EditEmployeeErrorState({required this.error});
}

class EmployeeToShowDetailsSelectionState extends EmployeesStates {}

class AttendanceTableChangingFilterState extends EmployeesStates {}

class AttendanceTableChangingPageState extends EmployeesStates {}

class GetEmployeeAttendanceLoadingState extends EmployeesStates {}

class GetEmployeeAttendanceSuccessState extends EmployeesStates {}

class GetEmployeeAttendanceErrorState extends EmployeesStates {
  final String error;

  GetEmployeeAttendanceErrorState({required this.error});
}

abstract class UploadFileAttendanceState {}

class UploadFileAttendanceInitial extends EmployeesStates {}

class UploadFileAttendanceSuccess extends EmployeesStates {}

class UploadFileAttendanceLoading extends EmployeesStates {}

class UploadFileAttendanceError extends EmployeesStates {
  final String message;

  UploadFileAttendanceError({required this.message});
}
