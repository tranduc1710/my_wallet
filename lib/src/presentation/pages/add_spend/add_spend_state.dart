part of 'add_spend_view.dart';

abstract class _AddSpendState {}

class _InitState extends _AddSpendState {}

class _AddSuccessState extends _AddSpendState {}

class _ErrorState extends _AddSpendState {
  final String content;

  _ErrorState(this.content);
}

class _AlertState extends _AddSpendState {
  final String message;

  _AlertState(this.message);
}

class _CompleteState extends _AddSpendState {}

class _ChoiceTimeState extends _AddSpendState {
  final TypePicker type;

  _ChoiceTimeState(this.type);
}
