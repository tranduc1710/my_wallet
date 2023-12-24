import 'package:base_flutter/base/base.dart';
import 'package:base_flutter/presentation/pages/demo/demo_controller.dart';
import 'package:flutter/material.dart';

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
      body: Text(widget.title).wCenter().onTap(controller.nextPage),
    );
  }
}
