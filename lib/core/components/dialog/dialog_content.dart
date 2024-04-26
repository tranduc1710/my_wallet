part of '../components.dart';

class DialogContent<T> extends StatelessWidget {
  final String? title;
  final String? content;
  final Widget? child;
  final String? submitText;
  final String? cancelText;
  final bool? showClose;
  final EdgeInsets? insetPadding;

  /// Mặc định sẽ hiện text title
  /// [showHeaderTitle] = true => Hiện phần header của dialog
  final bool showHeaderTitle;

  /// [isConfirmDialog] = true
  /// Thay thế cụm button "Cancel" "Submit"
  /// Thành một đường line và button "Ok"
  final bool isConfirmDialog;

  final void Function()? onSubmit;
  final void Function()? onClose;

  const DialogContent({
    Key? key,
    this.title,
    this.content,
    this.child,
    this.submitText,
    this.cancelText,
    this.onSubmit,
    this.showClose = true,
    this.onClose,
    this.showHeaderTitle = false,
    this.isConfirmDialog = false,
    this.insetPadding,
  }) : super(key: key);

  Future<T?> show(BuildContext context) async {
    final T? result = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        elevation: 0,
        contentPadding: EdgeInsets.zero,
        insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: showHeaderTitle == true ? 16.dm : 44.dm),
        titlePadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: this,
      ),
    );
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (showHeaderTitle) ...[
          Container(
            padding: EdgeInsets.symmetric(vertical: 16.dm),
            width: double.infinity,
            decoration: BoxDecoration(
                color: AppColor.primary,
                borderRadius:
                    BorderRadius.only(topLeft: Radius.circular(Constant.radius), topRight: Radius.circular(Constant.radius))),
            child: (title ?? AppLanguage.notification)
                .wText(style: AppStyle.s16.copyWith(fontWeight: FontWeight.w700, color: AppColor.textIcon))
                .wCenter(),
          ),
        ] else ...[
          (title ?? AppLanguage.notification)
              .wText(style: AppStyle.normal.copyWith(fontWeight: FontWeight.w700, color: AppColor.primary))
              .wPadding(EdgeInsets.fromLTRB(20.dm, 12.dm, 20.dm, 0)),
        ],
        16.wSpaceHeight(),
        child ??
            SizedBox(
              width: showHeaderTitle ? 1.w : null,
              child: content.value
                  .wText(textAlign: showHeaderTitle ? null : TextAlign.center)
                  .wPadding(EdgeInsets.symmetric(horizontal: 20.dm)),
            ),
        16.wSpaceHeight(),
        if (isConfirmDialog) ...[
          const Line(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AppButton(
                minWidth: 90.dm,
                onPressed: onClose ?? () => context.back(),
                text: AppLanguage.ok,
                color: AppColor.primary,
                textStyle: AppStyle.normal.copyWith(
                  fontWeight: FontWeight.w500,
                  height: 1,
                  color: AppColor.textIcon,
                ),
                height: 32.dm,
              ),
            ],
          ).wPadding(EdgeInsets.only(top: 10.dm, right: 16.dm))
        ] else ...[
          Row(
            children: [
              if (showClose == true) ...[
                Expanded(
                  child: AppButton(
                    onPressed: onClose ?? () => context.back(),
                    text: cancelText ?? AppLanguage.cancel,
                    color: AppColor.divider,
                    textStyle: AppStyle.normal.copyWith(fontWeight: FontWeight.w500, height: 1),
                    height: 32.dm,
                  ),
                ),
              ],
              if (showClose == true && submitText != null) ...[
                12.wSpaceWidth(),
              ],
              if (submitText != null) ...[
                Expanded(
                  child: AppButton(
                    text: submitText,
                    color: AppColor.primary,
                    textStyle: AppStyle.normal.copyWith(fontWeight: FontWeight.w500, color: AppColor.textIcon, height: 1),
                    height: 32.dm,
                    onPressed: onSubmit,
                  ),
                ),
              ]
            ],
          ).wPadding(EdgeInsets.symmetric(horizontal: 20.dm))
        ],
      ],
    ).wPadding(EdgeInsets.only(bottom: isConfirmDialog == true ? 10.dm : 20.dm));
  }
}
