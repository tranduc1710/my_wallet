import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show max, min, Random;
import 'dart:ui' as ui show FlutterView;

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/core/utils/hive/hive.dart';
import 'package:my_wallet/src/domain/entity/hive/locale.hive.dart';
import 'package:rxdart/rxdart.dart';

import '../../generated/l10n.dart';
import '../../src/domain/entity/_input_repo.dart';
import '../../src/domain/entity/response.dart';
import '../components/components.dart';
import '../utils/utils.dart';

export 'package:flutter/material.dart';

part 'extensions.dart';
part 'request/app.request.dart';
part 'request/remote.request.dart';
part 'screen_utils.dart';

S get AppLanguage => S.current;

ScreenUtil get screenUtil => ScreenUtil();

void kPrint(Object? object, [String? name]) {
  if (kDebugMode) {
    log(
      "$object",
      time: DateTime.now(),
      name: name ?? 'LOG',
    );
  }
}
