import 'package:base_flutter/core/base/base.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/components/components.dart';
import '../../../../core/utils/utils.dart';
import 'demo.controller.dart';

///class này chỉ có giao diện và giao tiếp với controller
class DemoView extends StatefulWidget {
  final String title;

  const DemoView({super.key, required this.title});

  @override
  State<DemoView> createState() => _DemoViewState();
}

class _DemoViewState extends State<DemoView> {
  final controller = DemoController();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(widget.title).onTap(controller.nextPage),
          const Text("").onTap(controller.nextPage).shimmer(controller.rxLoading),
          AppTextField(
            controller: controller.tfEmail,
          ),
          AppTextField(
            controller: controller.tfPassword,
          ),
          AppButton(
            onPressed: controller.login,
            text: "Login",
          ),
        ],
      ).wPadding(AppEdgeInsets.screen),
    );
  }
}
