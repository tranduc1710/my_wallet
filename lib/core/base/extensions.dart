part of 'base.dart';

extension ExObject<O> on O {
  BehaviorSubject<O> get rx => BehaviorSubject<O>.seeded(this);
}

extension ExObjectNull on Object? {
  bool getBool([bool value = false]) => this is bool? ? (this as bool?) ?? value : value;

  double getDouble([double value = 0]) => this is double? ? (this as double?) ?? value : value;

  int getInt([int value = 0]) => this is int? ? (this as int?) ?? value : value;

  String getString([String value = '']) => this is String? ? (this as String?) ?? value : value;
}

extension ExList<O> on List<O>? {
  List<O> get getList => this is List<O> ? this! : <O>[];
}

extension ExNum on num {
  Future delayed([FutureOr Function()? computation]) async => await Future.delayed(
        Duration(milliseconds: (this * 1000).toInt()),
        computation,
      );

  double get w => screenUtil.setWidth(this);

  double get h => screenUtil.setHeight(this);

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

  Widget wUnFocus() => GestureDetector(
        child: this,
        onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      );

  Widget onTap(Function() onTap) => GestureDetector(
        onTap: onTap,
        child: this,
      );
}
