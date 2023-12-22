part of 'widgets.dart';

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
    FocusManager().primaryFocus?.unfocus();

    title ??= AppLanguage.alert;

    T? value;
    if (function != null) {
      value = await function!();
    }

    if (!context.mounted) return value;

    showDialog(
      context: context,
      builder: (context) => Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Line(),
                      ],
                    ),
                  ),
                Container(
                  constraints: BoxConstraints(maxHeight: .4.h),
                  padding: EdgeInsets.symmetric(horizontal: .04.w),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: content != null
                        ? Text(content)
                        : value is String
                            ? Text(value, style: AppStyle.normal.copyWith(fontSize: 12.sp))
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showClose)
                      AppButton(
                        text: AppLanguage.close,
                        color: AppColor.border,
                        onPressed:
                            (onSubmit != null && submit == null) ? onSubmit : () => Get.back(),
                      ),
                    if (submit != null)
                      Padding(
                        padding: EdgeInsets.only(left: showClose ? 15 : 0),
                        child: AppButton(
                          text: submit,
                          onPressed: () {
                            if (onSubmit != null) onSubmit();
                            context.back();
                          },
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );

    return value;
  }

  Future<T?> alertBottom<T>({
    Function(T? data)? onResult,
    String? title,
    String? content,
    Widget? child,
    String? submit,
    Function()? onSubmit,
    bool showClose = true,
  }) async =>
      await _lock.synchronized(() => _alertBottom<T>(
            onResult,
            title,
            content,
            child,
            submit,
            onSubmit,
            showClose,
          ));

  Future<T?> _alertBottom<T>(
    Function(T? data)? onResult,
    String? title,
    String? content,
    Widget? child,
    String? submit,
    Function()? onSubmit,
    bool showClose,
  ) async {
    FocusScope.of(context).requestFocus(FocusNode());

    title ??= language.alert;
    _loading(null);

    T? value;
    dynamic data;
    if (function != null) {
      value = await function!();
      if (onResult != null) {
        data = await onResult(value);
      }
    }

    Get.dialog(
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: .95.w,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: SColor.primary6,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 20),
                          const PLine(),
                        ],
                      ),
                    ),
                  const SizedBox(height: 5),
                  Container(
                    constraints: BoxConstraints(maxHeight: .4.h),
                    padding: EdgeInsets.symmetric(horizontal: .04.w),
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: content != null
                          ? Text(content)
                          : data is String
                              ? Text(data)
                              : child ?? (data is Widget ? data : const SizedBox()),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (showClose)
                        InkWell(
                          onTap: () => Get.back(),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            padding:
                                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: SColor.background,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border: Border.all(color: SColor.primary4)),
                            child: Text(
                              language.close,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.black, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ),
                      if (submit != null)
                        InkWell(
                          onTap: onSubmit ?? () => Get.back(),
                          child: Container(
                            margin: const EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
                            padding:
                                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                            decoration: BoxDecoration(
                                color: SColor.primary4,
                                borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10)),
                                border: Border.all(color: SColor.primary4)),
                            child: Text(
                              submit,
                              style: const TextStyle(
                                  fontSize: 15, color: Colors.white, fontWeight: FontWeight.w700),
                            ),
                          ),
                        )
                    ],
                  ),
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    return value;
  }
}
