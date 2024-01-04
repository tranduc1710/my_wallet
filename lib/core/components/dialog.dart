part of 'components.dart';

class AppDialog {
  final Future Function()? function;

  AppDialog([this.function]);

  Future<T?> alert<T>({
    String? title,
    String? content,
    Widget? child,
    String? submit,
    Function()? onSubmit,
    bool showClose = true,
  }) async {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();

    title ??= AppLanguage.alert;

    T? data;
    String? value;
    if (function != null) {
      data = await function!();
      if (data is String) {
        value = data;
      }
    }

    if (!context.mounted) return data;

    showDialog(
      context: context,
      builder: (context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constant.radius),
        ),
        child: Container(
          constraints: BoxConstraints(
            maxWidth: .75.w,
          ),
          decoration: BoxDecoration(
            color: AppColor.background,
            borderRadius: BorderRadius.circular(Constant.radius),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: AppStyle.s16.copyWith(fontWeight: FontWeight.bold),
                    ).wPadding(AppEdgeInsets.bottom * 2),
                    const Line(),
                  ],
                ).wPadding(AppEdgeInsets.popup),
              Container(
                constraints: BoxConstraints(maxHeight: .4.h),
                padding: EdgeInsets.symmetric(horizontal: .04.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    value ?? content.value,
                    style: AppStyle.normal.copyWith(
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ).wPadding(AppEdgeInsets.bottom),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showClose)
                    AppButton(
                      text: AppLanguage.close,
                      color: AppColor.border,
                      onPressed: (onSubmit != null && submit == null) ? onSubmit : context.back,
                    ),
                  if (submit != null)
                    AppButton(
                      text: submit,
                      onPressed: () {
                        if (onSubmit != null) onSubmit();
                        context.back();
                      },
                    ).wPadding(EdgeInsets.only(left: showClose ? 15.dm : 0)),
                ],
              ).wPadding(AppEdgeInsets.bottom),
            ],
          ),
        ),
      ).wCenter(),
    );

    return data;
  }
}
