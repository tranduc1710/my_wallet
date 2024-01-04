part of 'components.dart';

class AppButton extends StatefulWidget {
  final Function()? onPressed;
  final String? text;
  final TextStyle? textStyle;
  final double? height;
  final double? minWidth;
  final BorderRadius? borderRadius;
  final bool isOutline;
  Color? color;
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
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> with TickerProviderStateMixin {
  final _rxLoading = false.rx;
  final key = GlobalKey();

  @override
  void dispose() {
    super.dispose();
    _rxLoading.close();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: _rxLoading.stream,
        initialData: false,
        builder: (context, snapshot) {
          return MaterialButton(
            key: key,
            onPressed: () async {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_rxLoading.value == true) return;
              if (widget.onPressed != null) {
                _rxLoading.value = true;
                try {
                  await widget.onPressed!();
                } catch (e, s) {
                  kPrint("$e\n$s");
                }
                _rxLoading.value = false;
              }
            },
            color: widget.color,
            disabledColor: AppColor.primary,
            elevation: 0,
            height: widget.height,
            splashColor: widget.splashColor,
            highlightColor: widget.highlightColor,
            minWidth: widget.minWidth,
            shape: RoundedRectangleBorder(
              borderRadius: widget.borderRadius ?? BorderRadius.circular(10),
              side: const BorderSide(
                color: Colors.transparent,
                width: 1,
              ),
            ),
            child: snapshot.data.getBool()
                ? Builder(builder: (context) {
                    final renderBox = key.currentContext?.findRenderObject() as RenderBox;
                    final size = renderBox.size;

                    return SizedBox(
                      width: min(size.width, size.height) * .5,
                      height: min(size.width, size.height) * .5,
                      child: LoadingIndicator(
                        indicatorType: Indicator.circleStrokeSpin,
                        colors: const [Colors.white],
                        strokeWidth: 2.5.dm,
                      ),
                    );
                  })
                : widget.text != null
                    ? Text(
                        widget.text!,
                        style: widget.textStyle ??
                            const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                            ),
                      )
                    : widget.child,
          );
        });
  }
}
