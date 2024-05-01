// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `My Wallet`
  String get appName {
    return Intl.message(
      'My Wallet',
      name: 'appName',
      desc: '',
      args: [],
    );
  }

  /// `Đăng nhập`
  String get login {
    return Intl.message(
      'Đăng nhập',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get alert {
    return Intl.message(
      'Thông báo',
      name: 'alert',
      desc: '',
      args: [],
    );
  }

  /// `Đóng`
  String get close {
    return Intl.message(
      'Đóng',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Xác nhận`
  String get confirm {
    return Intl.message(
      'Xác nhận',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `Lỗi`
  String get error {
    return Intl.message(
      'Lỗi',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Notification`
  String get notification {
    return Intl.message(
      'Notification',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Network connection error`
  String get networkError {
    return Intl.message(
      'Network connection error',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `An error occurred`
  String get errorOccurred {
    return Intl.message(
      'An error occurred',
      name: 'errorOccurred',
      desc: '',
      args: [],
    );
  }

  /// `Login session expired`
  String get loginExpired {
    return Intl.message(
      'Login session expired',
      name: 'loginExpired',
      desc: '',
      args: [],
    );
  }

  /// `Upload failed`
  String get uploadFailed {
    return Intl.message(
      'Upload failed',
      name: 'uploadFailed',
      desc: '',
      args: [],
    );
  }

  /// `No data returned`
  String get noDataReturned {
    return Intl.message(
      'No data returned',
      name: 'noDataReturned',
      desc: '',
      args: [],
    );
  }

  /// `Error when processing data`
  String get errGettingData {
    return Intl.message(
      'Error when processing data',
      name: 'errGettingData',
      desc: '',
      args: [],
    );
  }

  /// `Connection timed out`
  String get connectionTimedOut {
    return Intl.message(
      'Connection timed out',
      name: 'connectionTimedOut',
      desc: '',
      args: [],
    );
  }

  /// `Trang chủ`
  String get home {
    return Intl.message(
      'Trang chủ',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Thêm chi tiêu`
  String get addSpend {
    return Intl.message(
      'Thêm chi tiêu',
      name: 'addSpend',
      desc: '',
      args: [],
    );
  }

  /// `Thêm`
  String get add {
    return Intl.message(
      'Thêm',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Trừ`
  String get remove {
    return Intl.message(
      'Trừ',
      name: 'remove',
      desc: '',
      args: [],
    );
  }

  /// `Tổng {value}đ`
  String total(int value) {
    final NumberFormat valueNumberFormat =
        NumberFormat.decimalPattern(Intl.getCurrentLocale());
    final String valueString = valueNumberFormat.format(value);

    return Intl.message(
      'Tổng $valueStringđ',
      name: 'total',
      desc: '',
      args: [valueString],
    );
  }

  /// `Loading data`
  String get loadingData {
    return Intl.message(
      'Loading data',
      name: 'loadingData',
      desc: '',
      args: [],
    );
  }

  /// `Số tiền`
  String get soTien {
    return Intl.message(
      'Số tiền',
      name: 'soTien',
      desc: '',
      args: [],
    );
  }

  /// `Chi tiêu`
  String get chiTieu {
    return Intl.message(
      'Chi tiêu',
      name: 'chiTieu',
      desc: '',
      args: [],
    );
  }

  /// `Cho vay`
  String get choVay {
    return Intl.message(
      'Cho vay',
      name: 'choVay',
      desc: '',
      args: [],
    );
  }

  /// `Là đi vay người khác`
  String get laDiVay {
    return Intl.message(
      'Là đi vay người khác',
      name: 'laDiVay',
      desc: '',
      args: [],
    );
  }

  /// `Nhận tiền`
  String get nhanTien {
    return Intl.message(
      'Nhận tiền',
      name: 'nhanTien',
      desc: '',
      args: [],
    );
  }

  /// `Ghi chú`
  String get ghiChu {
    return Intl.message(
      'Ghi chú',
      name: 'ghiChu',
      desc: '',
      args: [],
    );
  }

  /// `Loại chi tiêu`
  String get loaiChiTieu {
    return Intl.message(
      'Loại chi tiêu',
      name: 'loaiChiTieu',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có giá trị nào`
  String get chuaCoGiaTri {
    return Intl.message(
      'Chưa có giá trị nào',
      name: 'chuaCoGiaTri',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có ai`
  String get chuaCoAi {
    return Intl.message(
      'Chưa có ai',
      name: 'chuaCoAi',
      desc: '',
      args: [],
    );
  }

  /// `Tạo mới`
  String get taoMoi {
    return Intl.message(
      'Tạo mới',
      name: 'taoMoi',
      desc: '',
      args: [],
    );
  }

  /// `Ngày phát sinh`
  String get ngayPhatSinh {
    return Intl.message(
      'Ngày phát sinh',
      name: 'ngayPhatSinh',
      desc: '',
      args: [],
    );
  }

  /// `Giờ phát sinh`
  String get gioPhatSinh {
    return Intl.message(
      'Giờ phát sinh',
      name: 'gioPhatSinh',
      desc: '',
      args: [],
    );
  }

  /// `Bạn chưa nhập số tiền`
  String get chuaNhapSoTien {
    return Intl.message(
      'Bạn chưa nhập số tiền',
      name: 'chuaNhapSoTien',
      desc: '',
      args: [],
    );
  }

  /// `Nhập để tạo mới`
  String get nhapDeTaoMoi {
    return Intl.message(
      'Nhập để tạo mới',
      name: 'nhapDeTaoMoi',
      desc: '',
      args: [],
    );
  }

  /// `Người vay`
  String get nguoiVay {
    return Intl.message(
      'Người vay',
      name: 'nguoiVay',
      desc: '',
      args: [],
    );
  }

  /// `Người cho vay`
  String get nguoiChoVay {
    return Intl.message(
      'Người cho vay',
      name: 'nguoiChoVay',
      desc: '',
      args: [],
    );
  }

  /// `Ngày cho vay`
  String get ngayChoVay {
    return Intl.message(
      'Ngày cho vay',
      name: 'ngayChoVay',
      desc: '',
      args: [],
    );
  }

  /// `Giờ cho vay`
  String get gioChoVay {
    return Intl.message(
      'Giờ cho vay',
      name: 'gioChoVay',
      desc: '',
      args: [],
    );
  }

  /// `Ngày trả nợ`
  String get ngayTraNo {
    return Intl.message(
      'Ngày trả nợ',
      name: 'ngayTraNo',
      desc: '',
      args: [],
    );
  }

  /// `Giờ trả nợ`
  String get gioTraNo {
    return Intl.message(
      'Giờ trả nợ',
      name: 'gioTraNo',
      desc: '',
      args: [],
    );
  }

  /// `Lãi`
  String get lai {
    return Intl.message(
      'Lãi',
      name: 'lai',
      desc: '',
      args: [],
    );
  }

  /// `Lãi suất`
  String get laiSuat {
    return Intl.message(
      'Lãi suất',
      name: 'laiSuat',
      desc: '',
      args: [],
    );
  }

  /// `Không có`
  String get khongCo {
    return Intl.message(
      'Không có',
      name: 'khongCo',
      desc: '',
      args: [],
    );
  }

  /// `Theo ngày`
  String get theoNgay {
    return Intl.message(
      'Theo ngày',
      name: 'theoNgay',
      desc: '',
      args: [],
    );
  }

  /// `Phần trăm`
  String get phanTram {
    return Intl.message(
      'Phần trăm',
      name: 'phanTram',
      desc: '',
      args: [],
    );
  }

  /// `Tính theo`
  String get tinhTheo {
    return Intl.message(
      'Tính theo',
      name: 'tinhTheo',
      desc: '',
      args: [],
    );
  }

  /// `Ngày`
  String get ngay {
    return Intl.message(
      'Ngày',
      name: 'ngay',
      desc: '',
      args: [],
    );
  }

  /// `Nhập số`
  String get nhapSo {
    return Intl.message(
      'Nhập số',
      name: 'nhapSo',
      desc: '',
      args: [],
    );
  }

  /// `Số ngày`
  String get soNgay {
    return Intl.message(
      'Số ngày',
      name: 'soNgay',
      desc: '',
      args: [],
    );
  }

  /// `Tháng`
  String get thang {
    return Intl.message(
      'Tháng',
      name: 'thang',
      desc: '',
      args: [],
    );
  }

  /// `Năm`
  String get nam {
    return Intl.message(
      'Năm',
      name: 'nam',
      desc: '',
      args: [],
    );
  }

  /// `Không`
  String get khong {
    return Intl.message(
      'Không',
      name: 'khong',
      desc: '',
      args: [],
    );
  }

  /// `Theo`
  String get theo {
    return Intl.message(
      'Theo',
      name: 'theo',
      desc: '',
      args: [],
    );
  }

  /// `Chưa chọn người cho vay`
  String get chuaChonNguoiChoVay {
    return Intl.message(
      'Chưa chọn người cho vay',
      name: 'chuaChonNguoiChoVay',
      desc: '',
      args: [],
    );
  }

  /// `Ngày/giờ cho vay không hợp lệ`
  String get ngayGioChoVayKhongHopLe {
    return Intl.message(
      'Ngày/giờ cho vay không hợp lệ',
      name: 'ngayGioChoVayKhongHopLe',
      desc: '',
      args: [],
    );
  }

  /// `Nhận từ`
  String get nhanTu {
    return Intl.message(
      'Nhận từ',
      name: 'nhanTu',
      desc: '',
      args: [],
    );
  }

  /// `Ngày nhận`
  String get ngayNhan {
    return Intl.message(
      'Ngày nhận',
      name: 'ngayNhan',
      desc: '',
      args: [],
    );
  }

  /// `Giờ nhận`
  String get gioNhan {
    return Intl.message(
      'Giờ nhận',
      name: 'gioNhan',
      desc: '',
      args: [],
    );
  }

  /// `Thêm thành công`
  String get themThanhCong {
    return Intl.message(
      'Thêm thành công',
      name: 'themThanhCong',
      desc: '',
      args: [],
    );
  }

  /// `Về màn hình chính`
  String get veTrangChu {
    return Intl.message(
      'Về màn hình chính',
      name: 'veTrangChu',
      desc: '',
      args: [],
    );
  }

  /// `Vay người khác`
  String get vayNguoiKhac {
    return Intl.message(
      'Vay người khác',
      name: 'vayNguoiKhac',
      desc: '',
      args: [],
    );
  }

  /// `Cài đặt`
  String get caiDat {
    return Intl.message(
      'Cài đặt',
      name: 'caiDat',
      desc: '',
      args: [],
    );
  }

  /// `Thống kê`
  String get thongKe {
    return Intl.message(
      'Thống kê',
      name: 'thongKe',
      desc: '',
      args: [],
    );
  }

  /// `Đây là khoản`
  String get dayLaKhoan {
    return Intl.message(
      'Đây là khoản',
      name: 'dayLaKhoan',
      desc: '',
      args: [],
    );
  }

  /// `7 ngày qua`
  String get tuanGanDay {
    return Intl.message(
      '7 ngày qua',
      name: 'tuanGanDay',
      desc: '',
      args: [],
    );
  }

  /// `Tuần này`
  String get tuanNay {
    return Intl.message(
      'Tuần này',
      name: 'tuanNay',
      desc: '',
      args: [],
    );
  }

  /// `Tháng này`
  String get thangNay {
    return Intl.message(
      'Tháng này',
      name: 'thangNay',
      desc: '',
      args: [],
    );
  }

  /// `Tháng trước`
  String get thangTruoc {
    return Intl.message(
      'Tháng trước',
      name: 'thangTruoc',
      desc: '',
      args: [],
    );
  }

  /// `Quý này`
  String get quyNay {
    return Intl.message(
      'Quý này',
      name: 'quyNay',
      desc: '',
      args: [],
    );
  }

  /// `Năm này`
  String get namNay {
    return Intl.message(
      'Năm này',
      name: 'namNay',
      desc: '',
      args: [],
    );
  }

  /// `Chưa có giao dịch phát sinh`
  String get chuaCoGiaoDich {
    return Intl.message(
      'Chưa có giao dịch phát sinh',
      name: 'chuaCoGiaoDich',
      desc: '',
      args: [],
    );
  }

  /// `Lọc theo`
  String get locTheo {
    return Intl.message(
      'Lọc theo',
      name: 'locTheo',
      desc: '',
      args: [],
    );
  }

  /// `Thời gian trả`
  String get thoiGianTraNo {
    return Intl.message(
      'Thời gian trả',
      name: 'thoiGianTraNo',
      desc: '',
      args: [],
    );
  }

  /// `Ngày hoặc giờ không đúng định dạng`
  String get ngayGioKhongDung {
    return Intl.message(
      'Ngày hoặc giờ không đúng định dạng',
      name: 'ngayGioKhongDung',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
