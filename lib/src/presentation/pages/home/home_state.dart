part of 'home_view.dart';

abstract class _HomeState {}

class _InitState extends _HomeState {}

class _LoadingState extends _HomeState {}

class _ErrorState extends _HomeState {
  final String content;

  _ErrorState(this.content);
}

class _AlertState extends _HomeState {
  final String message;

  _AlertState(this.message);
}

class _CompleteState extends _HomeState {}

class _AddSpendState extends _HomeState {}

class _EditSpendState extends _HomeState {}
