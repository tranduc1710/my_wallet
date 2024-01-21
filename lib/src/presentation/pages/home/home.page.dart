import 'package:base_flutter/core/utils/utils.dart';
import 'package:base_flutter/src/presentation/pages/home/home.controller.dart';

import '../../../../core/base/base.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLanguage.home),
      ),
      body: Column(
        children: [
          Text(
            AppLanguage.total(1020323),
            style: AppStyle.s16.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: controller.onRemove,
            backgroundColor: AppColor.remove,
            child: Icon(
              Icons.remove,
              size: 25.dm,
            ),
          ).wPadding(AppEdgeInsets.bottom),
          FloatingActionButton(
            onPressed: controller.onAdd,
            backgroundColor: AppColor.add,
            child: Icon(
              Icons.add,
              size: 25.dm,
            ),
          ),
        ],
      ),
    );
  }
}
