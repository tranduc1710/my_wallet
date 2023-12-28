part of 'components.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? leading;
  final Widget? trailing;
  final bool showClear;
  final bool enabled;
  final bool autofocus;
  final bool isMultiLine;
  final bool isPassword;
  final double? height;
  final double? radius;
  final String? hintText;
  final Alignment align;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onTap;

  const AppTextField({
    super.key,
    this.leading,
    this.trailing,
    this.showClear = true,
    this.enabled = true,
    this.autofocus = false,
    this.isMultiLine = false,
    this.isPassword = false,
    this.align = Alignment.topCenter,
    this.controller,
    this.hintText,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textAlign = TextAlign.start,
    this.height,
    this.textStyle,
    this.radius,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late final TextEditingController controller = widget.controller ?? TextEditingController();
  late bool isPassword = widget.isPassword;

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.enabled ? Colors.white : Colors.grey[100],
        borderRadius: BorderRadius.circular(widget.radius ?? Constant.radius),
        border: Border.all(
          color: AppColor.border,
          width: .7,
        ),
      ),
      child: Row(
        children: [
          if (widget.leading != null) widget.leading!.wPadding(AppEdgeInsets.left),
          Expanded(
            child: TextField(
              controller: controller,
              onTap: widget.onTap,
              onSubmitted: widget.onSubmitted,
              focusNode: widget.focusNode,
              autofocus: widget.autofocus,
              enabled: widget.enabled,
              keyboardType: widget.keyboardType,
              textAlign: widget.textAlign,
              maxLines: widget.height != null && widget.isMultiLine
                  ? widget.height.value ~/ ((widget.textStyle ?? AppStyle.normal).fontSize ?? 14.0)
                  : 1,
              style: widget.textStyle ?? AppStyle.normal,
              obscureText: isPassword,
              onChanged: (value) {
                setState(() {});
                widget.onChanged?.call(value);
              },
              decoration: InputDecoration.collapsed(
                hintText: widget.hintText.value,
              ),
            ).wPadding(AppEdgeInsets.item),
          ),
          if (widget.isPassword)
            GestureDetector(
              onTap: () {
                setState(() {
                  isPassword = !isPassword;
                });
              },
              child: Container(
                padding: EdgeInsets.all(2.dm),
                margin: AppEdgeInsets.horizontal,
                child: Icon(
                  isPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded,
                  size: 15.dm,
                  color: Colors.grey,
                ),
              ).wCenter(),
            ),
          if (controller.text.isNotEmpty && widget.showClear)
            GestureDetector(
              onTap: () {
                setState(() {
                  controller.clear();
                });
              },
              child: Container(
                padding: EdgeInsets.all(2.dm),
                margin: AppEdgeInsets.horizontal,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(.25),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Icon(
                  Icons.clear_outlined,
                  size: 10.dm,
                  color: Colors.white,
                ),
              ).wCenter(),
            ),
          if (widget.trailing != null) widget.trailing!.wPadding(AppEdgeInsets.right),
        ],
      ),
    );
  }
}
