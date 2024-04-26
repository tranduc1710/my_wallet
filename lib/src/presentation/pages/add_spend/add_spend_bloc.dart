part of 'add_spend_view.dart';

class AddSpendBloc extends Bloc<_AddSpendEvent, _AddSpendState> {
  AddSpendBloc() : super(_InitState()) {
    on<InitEvent>(_init);
  }

  void _init(InitEvent event, Emitter<_AddSpendState> emit) {}
}
