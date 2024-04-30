part of 'thong_ke_view.dart';

class ThongKeBloc extends Bloc<_ThongKeEvent, _ThongKeState> {
  ThongKeBloc() : super(_InitState()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<_ThongKeState> emit) {}
}
