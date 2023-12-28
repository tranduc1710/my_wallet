part of 'components.dart';

class Line extends StatelessWidget {
  final Symmetric symmetric;
  final double? width, height;
  final Color? color;

  const Line({
    Key? key,
    this.symmetric = Symmetric.horizontal,
    this.width,
    this.height,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? (symmetric == Symmetric.horizontal ? double.infinity : 1),
      height: height ?? (symmetric == Symmetric.vertical ? double.infinity : 1),
      color: color ?? AppColor.border,
    );
  }
}

enum Symmetric { horizontal, vertical }
