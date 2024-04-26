part of 'home_view.dart';

abstract class _HomeEvent {}

class InitEvent extends _HomeEvent {}

class _PushView extends _HomeEvent {
  final _HomeState state;

  _PushView(this.state);
}
