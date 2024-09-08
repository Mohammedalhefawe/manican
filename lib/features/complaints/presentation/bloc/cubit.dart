import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:manicann/features/complaints/domain/entities/complaint.dart';
import 'package:manicann/features/complaints/domain/usecases/delete_complaint.dart';
import 'package:manicann/features/complaints/domain/usecases/get_all_complaints.dart';
import 'package:manicann/features/complaints/presentation/bloc/states.dart';
import '../../../../core/constance/appLink.dart';
import '../../../../core/constance/constance.dart';
import '../../../../core/error/failures.dart';

class ComplaintsCubit extends Cubit<ComplaintsStates> {
  ComplaintsCubit(
      {required this.getAllComplaintsUseCase,
      required this.hideComplaintUseCase})
      : super(ComplaintsInitialState()) {
    isBuiled = true;
  }
  static ComplaintsCubit get(context) => BlocProvider.of(context);
  bool isBuiled = false;
  List<Complaint> allComplaintsList = [];
  List<Complaint> complaintsList = [];

  // Drop Down Section
  List<DropdownMenuItem<Text>> employeesFilterTypes = [
    const DropdownMenuItem<Text>(
      value: Text("الأحدث"),
      child: Text("الأحدث"),
    ),
    const DropdownMenuItem<Text>(
      value: Text("العميل"),
      child: Text("العميل"),
    ),
  ];

  Text? complaintsTableFilter;
  void changeText(Text? text) {
    complaintsTableFilter = text;
    if (text != null) {
      sortList(text.data);
    } else {
      complaintsTableFilter = const Text("الأحدث");
    }

    emit(ComplaintsTableChangingFilterState());
  }

  void sortList(String? type) {
    if (type == null) return;
    if (type == "الأحدث") {
      complaintsList.sort((a, b) {
        if (a.date != null && b.date != null) {
          return b.date!.compareTo(a.date!);
        } else {
          return 1;
        }
      });
    } else {
      complaintsList.sort((a, b) {
        final int firstNameComparison =
            b.customerFirstName?.compareTo(a.customerFirstName!) ?? 0;
        if (firstNameComparison != 0) {
          return firstNameComparison;
        }
        return b.customerLastName?.compareTo(a.customerLastName!) ?? 0;
      });
    }
    changeEmpTablePage(1);
  }

  // Search Section
  void searchInList(String? text) {
    complaintsTablePageIndex = 1;
    final List<Complaint> filteredList = [];
    if (text == null || text == "") {
      complaintsList = allComplaintsList;
    } else {
      for (final complaint in allComplaintsList) {
        if (complaint.customerFirstName != null &&
            complaint != complaint.customerLastName) {
          if (complaint.customerFirstName!
                  .toLowerCase()
                  .startsWith(text.toLowerCase()) ||
              complaint.customerLastName!
                  .toLowerCase()
                  .startsWith(text.toLowerCase())) {
            filteredList.add(complaint);
          }
        }
      }
      complaintsList = filteredList;
    }
    emit(ComplaintsTableSearchState());
  }

  // Table Section
  int complaintsTablePageIndex = 1;
  void changeEmpTablePage(int page) {
    complaintsTablePageIndex = page;
    emit(ComplaintsTableChangingPageState());
  }

  // UseCase Calls Section

  final GetAllComplaintsUseCase getAllComplaintsUseCase;
  void getAllComplaints(int branchId) async {
    emit(GetComplaintsLoadingState());
    final failureOrUser = await getAllComplaintsUseCase(branchId: branchId);
    failureOrUser.fold(
      (failure) {
        emit(GetComplaintsErrorState(error: _mapFailureToString(failure)));
      },
      (employees) {
        complaintsList = employees;
        allComplaintsList = employees;
        sortList("الأحدث");
        //print(employeesList[0].firstName.toString());
        emit(GetComplaintsSuccessState());
      },
    );
  }

  final HideComplaintUseCase hideComplaintUseCase;
  void hideComplaint(int complaintId) async {
    emit(HideComplaintLoadingState());
    final failureOrUser = await hideComplaintUseCase(complaintId: complaintId);
    failureOrUser.fold(
      (failure) {
        emit(HideComplaintErrorState(error: _mapFailureToString(failure)));
      },
      (unit) {
        getAllComplaints(int.parse(AppLink.branchId));
        emit(HideComplaintSuccessState());
      },
    );
  }

  String _mapFailureToString(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure _:
        return SERVER_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
