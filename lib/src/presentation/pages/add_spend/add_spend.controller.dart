import 'package:base_flutter/core/base/base.dart';

class AddSpendController {
  final isAdd = false.rx;

  AddSpendController(bool isAdd) {
    this.isAdd.value = isAdd;
  }
}
