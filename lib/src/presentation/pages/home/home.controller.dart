import 'package:base_flutter/config/routers/_routers.dart';

import '../../../../core/base/base.dart';

class HomeController {
  void onAdd() {
    AddSpendRoute().push(context);
  }

  void onRemove() {
    RemoveSpendRoute().push(context);
  }
}
