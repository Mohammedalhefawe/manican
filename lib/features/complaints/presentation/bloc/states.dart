abstract class ComplaintsStates {}

class ComplaintsInitialState extends ComplaintsStates {}

class ComplaintsTableChangingFilterState extends ComplaintsStates {}

class ComplaintsTableSearchState extends ComplaintsStates {}

class ComplaintsTableChangingPageState extends ComplaintsStates {}

class GetComplaintsLoadingState extends ComplaintsStates {}

class GetComplaintsSuccessState extends ComplaintsStates {}

class GetComplaintsErrorState extends ComplaintsStates {
  final String error;

  GetComplaintsErrorState({required this.error});
}

class HideComplaintLoadingState extends ComplaintsStates {}

class HideComplaintSuccessState extends ComplaintsStates {}

class HideComplaintErrorState extends ComplaintsStates {
  final String error;

  HideComplaintErrorState({required this.error});
}
