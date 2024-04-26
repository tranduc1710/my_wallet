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
  final String? initialValue;
  final AppDropdownController<O> controller;
  final FutureOr<bool> Function()? onTap;

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
  }) : super(key: key);

  @override
  State<AppDropdownTF<O>> createState() => _AppDropdownTFState<O>();
}

class _AppDropdownTFState<O> extends State<AppDropdownTF<O>> {
  final key = GlobalKey();
  final controller = TextEditingController();
  bool enable = false;

  @override
  void initState() {
    super.initState();
    widget.controller._clear = () {
      controller.clear();
    };
    if (widget.initialValue != null) {
      controller.text = widget.initialValue.value;
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
                      text: TextSpan(
                        style: AppStyle.normal.copyWith(
                          color: enable != false ? AppColor.primary : AppColor.divider,
                          height: widget.maxLines != null && (enable) ? 0.1 : 0,
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
      items: widget.controller.list
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
          .toList(),
    );

    setState(() {
      enable = false;
    });
  }
}

class AppDropdownController<O> {
  List<O> list;
  O? _itemSelect;
  late void Function() _clear;

  AppDropdownController({required this.list});

  O? getItemSelect() => _itemSelect;

  void clear() {
    _itemSelect = null;
    _clear.call();
  }
}
