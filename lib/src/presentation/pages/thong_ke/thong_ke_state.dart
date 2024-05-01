part of 'thong_ke_view.dart';

abstract class _ThongKeState {}

class _InitState extends _ThongKeState {}

class _ErrorState extends _ThongKeState {
  final String content;

  _ErrorState(this.content);
}

class _AlertState extends _ThongKeState {
  final String message;

  _AlertState(this.message);
}

class _CompleteState extends _ThongKeState {}
