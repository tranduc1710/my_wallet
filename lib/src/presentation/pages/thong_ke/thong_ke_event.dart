part of 'thong_ke_view.dart';

abstract class _ThongKeEvent {}

class InitEvent extends _ThongKeEvent {}

class DoiLoaiTKEvent extends _ThongKeEvent {
  final ThongKeTheo loai;

  DoiLoaiTKEvent(this.loai);
}
