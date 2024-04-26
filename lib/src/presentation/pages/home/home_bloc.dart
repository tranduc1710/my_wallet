part of 'home_view.dart';

class HomeBloc extends Bloc<_HomeEvent, _HomeState> {
  HomeBloc() : super(_InitState()) {
    on<InitEvent>(_init);
    on<_PushView>(_pushView);
  }

  void _init(InitEvent event, Emitter<_HomeState> emit) {
    emit(_CompleteState());
  }

  FutureOr<void> _pushView(_PushView event, Emitter<_HomeState> emit) {
    emit(event.state);
  }
}
