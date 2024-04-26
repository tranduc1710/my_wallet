part of 'components.dart';

class AppButton extends StatelessWidget {
  final Function()? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final double? height;
  final double? minWidth;
  final BorderRadius? borderRadius;
  final bool isOutline;
  final EdgeInsetsGeometry? padding;
  final ValueNotifier<bool>? loading;
  final bool enable;
  Color? color;
  Color? borderColor;
  Color? splashColor;
  Color? highlightColor;
  Color? loadingColor;
  Widget? child;

  AppButton({
    Key? key,
    this.onPressed,
    this.text,
    this.child,
    this.splashColor,
    this.highlightColor,
    this.textStyle,
    this.height = 43,
    this.minWidth,
    this.color,
    this.borderRadius,
    this.borderColor,
    this.padding,
    this.isOutline = false,
    this.loading,
    this.enable = true,
  }) : super(key: key) {
    child ??= Container();
    color ??= AppColor.primary;
  }

  final _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      key: _key,
      onPressed: !enable
          ? null
          : () async {
              FocusScope.of(context).requestFocus(FocusNode());
              if (loading?.value == true) return;
              if (onPressed != null) {
                try {
                  await onPressed!();
                } catch (e, s) {
                  kPrint("$e\n$s");
                }
              }
            },
      color: isOutline ? Colors.white : color,
      disabledColor: AppColor.divider,
      elevation: 0,
      height: height,
      splashColor: splashColor,
      highlightColor: highlightColor,
      minWidth: minWidth,
      padding: padding,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(10),
        side: BorderSide(
          color: isOutline ? AppColor.primary : borderColor ?? Colors.transparent,
          width: 1,
        ),
      ),
      child: loading == null
          ? _content(context, false)
          : ValueListenableBuilder(
              valueListenable: loading!,
              builder: (context, value, child) {
                return _content(context, value);
              }),
    );
  }

  Widget _content(BuildContext context, bool isLoading) {
    if (isLoading) {
      final renderBox = context.findRenderObject() as RenderBox?;
      final size = renderBox?.size;

      if (size != null) {
        return SizedBox(
          width: min(size.width, size.height),
          height: min(size.width, size.height),
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2.5.dm,
          ),
        );
      }
    }
    if (text != null) {
      return Text(
        text!,
        textAlign: TextAlign.center,
        style: textStyle ??
            AppStyle.s16.copyWith(
              color: isOutline ? AppColor.primary : Colors.white,
              fontWeight: FontWeight.w700,
              height: 1,
            ),
      );
    }
    return child ?? const SizedBox();
  }
}
