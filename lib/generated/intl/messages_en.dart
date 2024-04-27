// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(value) => "Tổng ${value}đ";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "add": MessageLookupByLibrary.simpleMessage("Thêm"),
        "addSpend": MessageLookupByLibrary.simpleMessage("Thêm chi tiêu"),
        "alert": MessageLookupByLibrary.simpleMessage("Thông báo"),
        "appName": MessageLookupByLibrary.simpleMessage("My Wallet"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "close": MessageLookupByLibrary.simpleMessage("Đóng"),
        "confirm": MessageLookupByLibrary.simpleMessage("Xác nhận"),
        "connectionTimedOut":
            MessageLookupByLibrary.simpleMessage("Connection timed out"),
        "errGettingData":
            MessageLookupByLibrary.simpleMessage("Error when processing data"),
        "error": MessageLookupByLibrary.simpleMessage("Lỗi"),
        "errorOccurred":
            MessageLookupByLibrary.simpleMessage("An error occurred"),
        "home": MessageLookupByLibrary.simpleMessage("Trang chủ"),
        "login": MessageLookupByLibrary.simpleMessage("Đăng nhập"),
        "loginExpired":
            MessageLookupByLibrary.simpleMessage("Login session expired"),
        "networkError":
            MessageLookupByLibrary.simpleMessage("Network connection error"),
        "noDataReturned":
            MessageLookupByLibrary.simpleMessage("No data returned"),
        "notification": MessageLookupByLibrary.simpleMessage("Notification"),
        "ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "remove": MessageLookupByLibrary.simpleMessage("Trừ"),
        "total": m0,
        "uploadFailed": MessageLookupByLibrary.simpleMessage("Upload failed")
      };
}
