part of '../components.dart';

class AppDropdownTF<O> extends StatefulWidget {
  final String hintText;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final Widget Function(O object) buildItem;
  final String Function(O object) onChoice;
  final bool showLine;
  final double? height;
  final String? labelText;
  final int? maxLines;
  final bool isRequired;
  final O? initialValue;
  final AppDropdownController<O> controller;
  final FutureOr<bool> Function()? onTap;
  final void Function(String name)? onCreateNew;

  const AppDropdownTF({
    Key? key,
    required this.controller,
    required this.buildItem,
    required this.onChoice,
    this.hintText = '',
    this.hintStyle,
    this.style,
    this.showLine = true,
    this.height,
    this.labelText,
    this.maxLines,
    this.isRequired = false,
    this.initialValue,
    this.onTap,
    this.onCreateNew,
  }) : super(key: key);

  @override
  State<AppDropdownTF<O>> createState() => _AppDropdownTFState<O>();
}

class _AppDropdownTFState<O> extends State<AppDropdownTF<O>> {
  final key = GlobalKey();
  final controller = TextEditingController();
  final focusNode = FocusNode();
  bool enable = false;

  @override
  void initState() {
    super.initState();
    widget.controller
      .._clear = () {
        controller.clear();
      }
      .._reShow = () {
        if (widget.controller._details != null) {
          context.back();
          _onTapTF(widget.controller._details!);
        }
      };
    if (widget.initialValue != null) {
      controller.text = widget.onChoice(widget.initialValue as O);
      widget.controller._itemSelect = widget.initialValue as O;
    }
  }

  final border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Constant.radius),
    borderSide: BorderSide(
      width: 1.dm,
      color: AppColor.primary,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTapUp: _onTapTF,
      child: Container(
        height: widget.height ?? 40.dm,
        decoration: BoxDecoration(
          color: AppColor.textIcon,
          borderRadius: BorderRadius.circular(Constant.radius),
          boxShadow: enable == false
              ? []
              : [
                  BoxShadow(
                    color: AppColor.primary.withOpacity(0.2),
                    blurRadius: 5.dm,
                    offset: const Offset(0, 0),
                  ),
                ],
        ),
        child: TextField(
          key: key,
          controller: controller,
          focusNode: focusNode,
          style: widget.style ?? AppStyle.normal,
          decoration: InputDecoration(
            contentPadding: AppEdgeInsets.horizontal * 2,
            hintText: widget.hintText,
            enabled: enable,
            hintStyle: widget.hintStyle ??
                AppStyle.normal.copyWith(
                  color: AppColor.divider,
                ),
            enabledBorder: border.copyWith(
              borderSide: BorderSide(
                width: 1.dm,
                color: AppColor.primary,
              ), /**/
            ),
            border: border,
            suffixIcon: Icon(
              Icons.arrow_drop_down,
              size: 30.dm,
              color: enable ? AppColor.primary : null,
            ),
            label: widget.labelText != null
                ? Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
                    child: RichText(
                      maxLines: 1,
                      text: TextSpan(
                        style: AppStyle.normal.copyWith(
                          color: enable != false ? AppColor.primary : AppColor.divider,
                          height: widget.maxLines != null && (enable) ? 0.1 : 0,
                        ),
                        children: [
                          TextSpan(text: widget.labelText),
                          if (widget.isRequired)
                            TextSpan(
                              text: " *",
                              style: AppStyle.normal.copyWith(
                                color: AppColor.error,
                                height: widget.maxLines != null && (enable) ? 0.1 : 0,
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }

  void _onTapTF(TapUpDetails details) async {
    widget.controller._details = details;
    FocusScope.of(context).unfocus();

    final renderBox = key.currentContext?.findRenderObject() as RenderBox?;

    if (renderBox == null) return;

    final result = await widget.onTap?.call();

    if (result == false) return;

    final size = renderBox.size;
    final position = RelativeRect.fromLTRB(
      details.globalPosition.dx - details.localPosition.dx,
      details.globalPosition.dy + renderBox.size.height - details.localPosition.dy,
      details.globalPosition.dx,
      0,
    );

    setState(() {
      enable = true;
    });

    final isCreate = widget.onCreateNew != null && widget.controller.list.isEmpty;

    await showMenu(
      context: context,
      position: position,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Constant.radius / 2),
          topRight: Radius.circular(Constant.radius / 2),
          bottomLeft: Radius.circular(Constant.radius),
          bottomRight: Radius.circular(Constant.radius),
        ),
      ),
      constraints: BoxConstraints(
        minWidth: size.width,
        maxHeight: .3.h,
      ),
      items: (isCreate
          ? [
              PopupMenuItem(
                child: AppLanguage.chuaCoGiaTri.wText(),
              ),
            ]
          : widget.controller.list
              .asMap()
              .entries
              .map(
                (e) => PopupMenuItem(
                  onTap: () {
                    final value = widget.onChoice(e.value);
                    controller.text = value;
                    widget.controller._itemSelect = e.value;
                  },
                  child: widget.buildItem(e.value),
                ),
              )
              .toList())
        ..addAll(
          widget.onCreateNew != null
              ? [
                  PopupMenuItem(
                    child: Builder(builder: (context) {
                      final controller = TextEditingController();

                      return AppTextField(
                        controller: controller,
                        hintText: AppLanguage.taoMoi,
                        textInputAction: TextInputAction.go,
                        onSubmitted: (content) {
                          controller.clear();
                          widget.onCreateNew?.call(content);
                          widget.controller._reShow.call();
                        },
                      );
                    }),
                  )
                ]
              : <PopupMenuItem>[],
        ),
    );

    setState(() {
      enable = false;
    });
  }
}

class AppDropdownController<O> {
  late List<O> _list;

  List<O> get list => _list;

  set list(List<O> value) {
    _list = value;
  }

  O? _itemSelect;
  late void Function() _clear;
  late void Function() _reShow;
  TapUpDetails? _details;

  AppDropdownController({required List<O> list}) {
    this.list = list;
  }

  O? getItemSelect() => _itemSelect;

  void clear() {
    _itemSelect = null;
    _clear.call();
  }
}
