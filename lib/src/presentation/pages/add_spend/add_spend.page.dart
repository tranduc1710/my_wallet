import 'package:base_flutter/core/utils/utils.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/base/base.dart';
import 'add_spend.controller.dart';

class AddSpendPage extends StatefulWidget {
  final bool isAdd;

  const AddSpendPage({super.key, required this.isAdd});

  @override
  State<AddSpendPage> createState() => _AddSpendPageState();
}

class _AddSpendPageState extends State<AddSpendPage> {
  late final controller = AddSpendController(widget.isAdd);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLanguage.addSpend),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLanguage.remove,
                style: AppStyle.normal,
              ).wPadding(),
              StreamBuilder(
                stream: controller.isAdd,
                builder: (context, snapshot) {
                  return CupertinoSwitch(
                    value: snapshot.data!,
                    onChanged: (value) => controller.isAdd.value = value,
                  );
                },
              ),
              Text(
                AppLanguage.add,
                style: AppStyle.normal,
              ).wPadding(),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) => ListTile(
                title: Text("name $index"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
