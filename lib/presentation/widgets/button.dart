part of 'widgets.dart';

class AppButton extends StatelessWidget {
  final void Function()? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final double? height;
  final double? minWidth;
  final BorderRadius? borderRadius;
  final bool isOutline;
  Color? color;
  Color? splashColor;
  Color? highlightColor;
  Widget? child;

  AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.child,
    this.splashColor,
    this.highlightColor,
    this.textStyle,
    this.height,
    this.minWidth,
    this.color,
    this.borderRadius,
    this.isOutline = false,
  }) : super(key: key) {
    child ??= Container();
    color ??= AppColor.primary;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        FocusScope.of(context).requestFocus(FocusNode());
        if (onPressed != null) onPressed!();
      },
      color: color,
      disabledColor: AppColor.primary,
      elevation: 0,
      height: height,
      splashColor: splashColor,
      highlightColor: highlightColor,
      minWidth: minWidth,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: text != null
          ? Text(
              text!,
              style: textStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
            )
          : child,
    );
  }
}
