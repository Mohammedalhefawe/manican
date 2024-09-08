abstract class BranchesState {}

class BranchesStateInitial extends BranchesState {}

class LoadingBranchesState extends BranchesState {}

class SuccessBranchesState extends BranchesState {}

class ErrorBranchesState extends BranchesState {
  final String message;

  ErrorBranchesState({required this.message});

  @override
  List<Object> get props => [message];
}
