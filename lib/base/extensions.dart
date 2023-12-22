part of 'base.dart';

extension ExObject<O> on O {
  BehaviorSubject<O> get rx => BehaviorSubject<O>.seeded(this);
}

extension ExObjectNull on Object? {
  bool get getBool => this is bool? ? (this as bool?) ?? false : false;

  double get getDouble => this is double? ? (this as double?) ?? 0 : 0;

  int get getInt => this is int? ? (this as int?) ?? 0 : 0;

  String get getString => this is String? ? (this as String?) ?? '' : '';
}

extension ExList<O> on List<O>? {
  List<O> get getList => this is List<O> ? this! : <O>[];
}

extension ExNum on num {
  Future delayed([FutureOr Function()? computation]) async => await Future.delayed(
        Duration(milliseconds: (this * 1000).toInt()),
        computation,
      );

  double get w => MediaQuery.of(context).size.width * this;

  double get h => MediaQuery.of(context).size.height * this;

  double get sp => screenUtil.setSp(this);

  double get dm => screenUtil.diameter(this);
}

extension ExDoubleNull on double? {
  double get value => this ?? 0;

  String get valueString => "${this ?? 0}";
}

extension ExIntNull on int? {
  int get value => this ?? 0;

  String get valueString => "${this ?? 0}";
}

extension ExDateTime on DateTime {
  String withFormat([String? format]) {
    format ??= "dd/MM/yyyy";
    return DateFormat(format).format(this);
  }
}

extension ExStringNull on String? {
  String get value => this ?? '';
}

extension ExFunction on Function() {
  void postFrame() => WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((_) => this());
}

extension ExBehaviorSubject on BehaviorSubject {
  void refresh() {
    add(value);
  }
}

extension ExBuildContext on BuildContext {
  void back<T extends Object?>([T? result]) {
    Navigator.pop(this, result);
  }
}

extension ExWidget on Widget {
  Widget wPadding([EdgeInsets? edgeInsets]) => Padding(
        padding: edgeInsets ?? AppEdgeInsets.item,
        child: this,
      );

  Widget wCenter() => Center(child: this);
}
