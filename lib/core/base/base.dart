import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' show max, min, Random;
import 'dart:ui' as ui show FlutterView;

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';

import '../../generated/l10n.dart';
import '../components/components.dart';
import '../utils/utils.dart';

export 'package:flutter/material.dart';

part 'extensions.dart';
part 'request.dart';
part 'screen_utils.dart';

BuildContext get context => Constant.navigatorKey.currentContext!;

S get AppLanguage => S.of(context);

ScreenUtil get screenUtil => ScreenUtil();

void kPrint(Object? object) {
  if (kDebugMode) {
    log(
      "$object",
      time: DateTime.now(),
      name: 'LOG',
    );
  }
}
