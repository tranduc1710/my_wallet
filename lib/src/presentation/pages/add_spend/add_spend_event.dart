part of 'add_spend_view.dart';

abstract class _AddSpendEvent {}

class InitEvent extends _AddSpendEvent {}

class AddSpendEvent extends _AddSpendEvent {
  AddSpendEvent();
}

class ShowTimePickerEvent extends _AddSpendEvent {
  final TypePicker type;

  ShowTimePickerEvent(this.type);
}

class ChoiceTimePickerEvent extends _AddSpendEvent {
  final DateTime? day;
  final TimeOfDay? time;
  final TypePicker type;

  ChoiceTimePickerEvent(this.time, this.type, this.day);
}

class ThemLoaiChiTieuEvent extends _AddSpendEvent {
  final String name;
  final int idTab;

  ThemLoaiChiTieuEvent(this.name, this.idTab);
}
