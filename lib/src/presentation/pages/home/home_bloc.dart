part of 'home_view.dart';

class HomeBloc extends Bloc<_HomeEvent, _HomeState> {
  final lstKey = GlobalKey<AnimatedListState>();

  final indexTab = 1.rx;
  final lstDate = <String>[].rx;
  final lstChiTieu = AppHive.boxChiTieu.values.toList();

  HomeBloc() : super(_InitState()) {
    on<InitEvent>(_init);
    on<_PushView>(_pushView);
  }

  void _init(InitEvent event, Emitter<_HomeState> emit) {
    for (var element in AppHive.boxChiTieu.values) {
      if (lstDate.value.contains(element.ngay.value)) continue;
      lstDate.value.add(element.ngay.value);
    }

    lstDate.value.sort();

    AppHive.boxChiTieu.watch().listen((event) {
      kPrint(event);
      if (event.value is GhiChiTieuModel) {
        final banGhi = event.value as GhiChiTieuModel;
        if (!event.deleted) {
          lstChiTieu.add(banGhi);
        } else {
          lstChiTieu.removeWhere((element) => element.id == banGhi.id);
        }

        if (!lstDate.value.contains(banGhi.ngay)) {
          lstDate.value.add(banGhi.ngay.value);
          lstDate.value.sort();
        }
        lstDate.refresh();
      }
    });

    emit(_CompleteState());
  }

  void _pushView(_PushView event, Emitter<_HomeState> emit) {
    emit(event.state);
  }
}
