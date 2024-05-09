part of '../components.dart';

class AppTextField extends StatefulWidget {
  final Color background;
  final Color? colorVisibility;
  final double radius;
  final double? height, width, widthVisibility;
  final TextStyle? textStyle;
  final List<BoxShadow>? listShadow;
  final Widget? prefix, suffix;
  final bool showClear;
  final bool readOnly;
  final BoxBorder? border;
  final BoxShape shape;
  final BoxConstraints? constraints;
  final String? hintText;
  final int? maxLines;
  final TypeTF typeTF;
  final int? maxLength;
  final TextAlignVertical? textAlignVertical;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String, Map<String, dynamic>)? onAppPrivateCommand;
  final void Function(String content)? onSubmitted, onChanged;
  final void Function()? onTap, onEditingComplete, onClearTap;
  TextInputType keyboardType;
  TextEditingController? controller;
  EdgeInsets? margin, padding;
  FocusNode? focusNode;
  TextStyle? hintStyle;
  TextInputAction? textInputAction;
  final String? labelText;
  final bool isRequired;
  final bool? enabled;
  final Color? colorBorder;
  final InputBorder? enabledBorder;
  final bool autofocus;
  final TextAlign textAlign;

  AppTextField({
    Key? key,
    this.background = Colors.white,
    this.colorVisibility,
    this.margin = EdgeInsets.zero,
    this.padding,
    this.radius = 10,
    this.textStyle,
    this.maxLength,
    this.listShadow,
    this.inputFormatters,
    this.autofocus = false,
    this.height,
    this.width,
    this.textAlignVertical,
    this.maxLines = 1,
    this.prefix,
    this.isRequired = false,
    this.suffix,
    this.showClear = true,
    this.readOnly = false,
    this.controller,
    this.focusNode,
    this.enabledBorder,
    this.onSubmitted,
    this.onTap,
    this.onClearTap,
    this.onChanged,
    this.onEditingComplete,
    this.onAppPrivateCommand,
    this.border,
    this.shape = BoxShape.rectangle,
    this.constraints,
    this.hintText,
    this.hintStyle,
    this.typeTF = TypeTF.normal,
    this.keyboardType = TextInputType.text,
    this.widthVisibility,
    this.textInputAction,
    this.labelText,
    this.enabled,
    this.colorBorder,
    this.textAlign = TextAlign.start,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _PTextFieldState();
}

class _PTextFieldState extends State<AppTextField> {
  late TextEditingController editingController;
  late FocusNode focusNode;
  TextInputType? keyboardType;
  EdgeInsets? margin, padding;
  TextStyle? hintStyle, textStyle;

  double? _fontSize;
  var _showClear = false;
  var _visibility = false;
  late final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(widget.radius),
    borderSide: BorderSide(width: 1, color: widget.colorBorder ?? AppColor.divider),
  );

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() {
    editingController = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    padding = widget.padding ?? const EdgeInsets.only(left: 8);
    margin = widget.margin;
    _fontSize = (widget.textStyle?.fontSize == null ? AppStyle.normal.fontSize : widget.textStyle!.fontSize) ?? AppStyle.normal.fontSize;

    hintStyle = widget.hintStyle ??
        TextStyle(
          color: AppColor.divider,
          fontSize: _fontSize,
          height: 1.3,
        );
    textStyle = widget.textStyle ??
        TextStyle(
          fontSize: _fontSize,
          height: 1,
        );

    if (widget.typeTF == TypeTF.password) {
      keyboardType = TextInputType.visiblePassword;
      _visibility = true;
    } else {
      keyboardType = widget.keyboardType;
    }
    editingController.addListener(listenerTF);
    focusNode.addListener(listenerFocus);
  }

  @override
  void dispose() {
    editingController.removeListener(listenerTF);
    focusNode.removeListener(listenerFocus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: widget.height ?? 40.dm,
      margin: margin,
      width: widget.width,
      decoration: BoxDecoration(
        color: widget.background,
        borderRadius: BorderRadius.circular(widget.radius),
        boxShadow: focusNode.hasFocus == true && !widget.readOnly
            ? [
                BoxShadow(
                  color: AppColor.primary.withOpacity(0.3),
                  blurRadius: 3.dm,
                  spreadRadius: 1.dm,
                  offset: const Offset(0, 0),
                ),
              ]
            : [],
      ),
      child: TextField(
        textAlign: widget.textAlign,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        cursorColor: AppColor.primary,
        maxLength: widget.maxLength,
        maxLines: widget.maxLines,
        textAlignVertical: widget.textAlignVertical ?? TextAlignVertical.top,
        expands: widget.maxLines == null ? true : false,
        readOnly: widget.readOnly,
        controller: editingController,
        focusNode: focusNode,
        style: textStyle,
        keyboardType: keyboardType,
        inputFormatters: widget.inputFormatters,
        cursorHeight: _fontSize,
        obscureText: _visibility,
        onSubmitted: widget.onSubmitted,
        // onChanged: widget.onChanged,
        onEditingComplete: widget.onEditingComplete,
        onTap: widget.onTap,
        textInputAction: widget.textInputAction,
        onAppPrivateCommand: widget.onAppPrivateCommand,
        decoration: InputDecoration(
          label: widget.labelText != null
              ? Container(
                  color: widget.readOnly ? Colors.transparent : Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: widget.maxLines != null ? MainAxisAlignment.center : MainAxisAlignment.start,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: widget.maxLines == null
                            ? !focusNode.hasFocus && editingController.text.isEmpty
                                ? 10.dm
                                : 37.dm
                            : 0,
                        constraints: const BoxConstraints(maxWidth: 0),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 4.dm),
                        child: RichText(
                          text: TextSpan(
                            style: AppStyle.normal.copyWith(
                              color: focusNode.hasFocus && widget.enabled != false && !widget.readOnly ? AppColor.primary : AppColor.divider,
                              height: widget.maxLines != null && (focusNode.hasFocus || editingController.text.isNotEmpty) ? 0.1 : 0,
                            ),
                            children: [
                              TextSpan(
                                text: widget.labelText,
                              ),
                              if (widget.isRequired)
                                TextSpan(
                                  text: " *",
                                  style: AppStyle.normal.copyWith(
                                    color: AppColor.error,
                                    height: widget.maxLines != null && (focusNode.hasFocus || editingController.text.isNotEmpty) ? 0.1 : 0,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : null,
          contentPadding: EdgeInsets.only(
            left: 16.dm,
            right: 10.dm,
            top: _fontSize!,
            bottom: (widget.height != null && _fontSize! - 5.dm >= widget.height! / 2) ? _fontSize! - 5.dm : 0,
          ),
          prefixIcon: widget.prefix != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    widget.prefix!,
                  ],
                )
              : null,
          suffixIcon: widget.typeTF == TypeTF.password || widget.showClear && _showClear || widget.suffix != null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: widget.maxLines == null ? MainAxisAlignment.start : MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.showClear && _showClear && widget.enabled != false && !widget.readOnly)
                          GestureDetector(
                            onTap: () {
                              editingController.clear();
                              if (widget.onClearTap != null) widget.onClearTap!.call();
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    right: widget.typeTF == TypeTF.password ? 3.dm : 15.dm,
                                    left: 5.dm,
                                  ),
                                  padding: EdgeInsets.all(3.dm),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColor.divider.withAlpha(90),
                                      )
                                    ],
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.close,
                                      color: AppColor.textIcon,
                                      size: 12.dm,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (widget.typeTF == TypeTF.password)
                          Padding(
                            padding: EdgeInsets.only(left: 10.dm, right: 16.dm),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _visibility = !_visibility;
                                });
                              },
                              child: Icon(
                                _visibility ? Icons.remove_red_eye_rounded : Icons.remove_red_eye_outlined,
                                size: 14.dm,
                              ),
                            ),
                          ),
                        if (widget.suffix != null) widget.suffix!.wPadding(EdgeInsets.only(right: 12.dm))
                      ],
                    ),
                  ],
                )
              : null,
          hintText: widget.hintText,
          hintStyle: hintStyle,
          border: InputBorder.none,
          enabledBorder: widget.enabledBorder ?? inputBorder,
          focusedBorder: widget.readOnly
              ? inputBorder
              : OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  borderSide: const BorderSide(width: 1, color: Colors.transparent),
                  gapPadding: 1,
                ),
          errorBorder: InputBorder.none,
          focusedErrorBorder: InputBorder.none,
          // disabledBorder: inputBorder,
          disabledBorder: inputBorder.copyWith(
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.1),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  void listenerTF() {
    widget.onChanged?.call(editingController.text);
    if (widget.showClear && editingController.text.isNotEmpty != _showClear) {
      if (!mounted) return;
      _showClear = !_showClear;
      setState(() {});
    }
  }

  void listenerFocus() {
    if (!mounted) return;
    if (widget.showClear && focusNode.hasFocus && editingController.text.isNotEmpty != _showClear) {
      _showClear = !_showClear;
    } else if (!focusNode.hasFocus) {
      _showClear = false;
    }
    setState(() {});
  }
}

enum TypeTF {
  normal,
  password,
  submit,
}
