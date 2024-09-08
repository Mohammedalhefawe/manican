abstract class StatisticState {}

class StatisticInitial extends StatisticState {}

class ChangeElementInDropDownState extends StatisticState {}

class ViewAllState extends StatisticState {}

class SuccessStatisticState extends StatisticState {}

class LoadingStatisticState extends StatisticState {}

class ErrorStatisticState extends StatisticState {
  final String message;

  ErrorStatisticState({required this.message});
}
