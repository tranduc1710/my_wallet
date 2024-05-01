part of 'thong_ke_view.dart';

class ThongKeBloc extends Bloc<_ThongKeEvent, _ThongKeState> {
  final rxTong = "0".rx;
  final rxTongTru = "0".rx;
  final rxType = 0.rx;
  final rxLoaiTK = ThongKeTheo.tuanGanNhat.rx;

  ThongKeBloc() : super(_InitState()) {
    on<InitEvent>(_init);
    on<DoiLoaiTKEvent>(_doiLoaiTK);
  }

  void _init(InitEvent event, Emitter<_ThongKeState> emit) {
    _tinh7NgayGanNhat();
  }

  void _doiLoaiTK(DoiLoaiTKEvent event, Emitter<_ThongKeState> emit) {
    rxLoaiTK.value = event.loai;

    switch (event.loai) {
      case ThongKeTheo.tuanGanNhat:
        _tinh7NgayGanNhat();
        break;
      case ThongKeTheo.tuanNay:
        _tinhTongTuanNay();
        break;
      case ThongKeTheo.thangNay:
        _tinhTongThangNay();
        break;
      case ThongKeTheo.thangTruoc:
        _tinhTongThangTruoc();
        break;
      case ThongKeTheo.quyNay:
        _tinhTongQuyNay();
        break;
      case ThongKeTheo.namNay:
        _tinhTongNamNay();
        break;
    }
  }

  void _tinhTongNamNay() {
    var dateNow = DateTime.now();
    final lstThang = AppHive.boxChiTieu.values.where(
      (element) {
        var dateCurrent = DateFormat('dd/MM/yyyy').parse(element.ngay.value);
        return dateNow.year == dateCurrent.year;
      },
    ).toList();
    _locTongTheoTienTe(lstThang);
  }

  void _tinhTongQuyNay() {
    var dateNow = DateTime.now();
    final lstThang = AppHive.boxChiTieu.values.where(
      (element) {
        var dateCurrent = DateFormat('dd/MM/yyyy').parse(element.ngay.value);
        return dateNow.year == dateCurrent.year && dateNow.month - dateCurrent.month <= 3 && dateNow.month - dateCurrent.month >= 0;
      },
    ).toList();
    _locTongTheoTienTe(lstThang);
  }

  void _tinhTongThangTruoc() {
    var dateNow = DateTime.now();
    final lstThang = AppHive.boxChiTieu.values.where(
      (element) {
        var dateCurrent = DateFormat('dd/MM/yyyy').parse(element.ngay.value);
        if (dateNow.month == 1) {
          return dateNow.year - 1 == dateCurrent.year && 12 == dateCurrent.month;
        }
        return dateNow.year == dateCurrent.year && dateNow.month - 1 == dateCurrent.month;
      },
    ).toList();
    _locTongTheoTienTe(lstThang);
  }

  void _tinhTongThangNay() {
    var dateNow = DateTime.now();
    final lstThang = AppHive.boxChiTieu.values.where(
      (element) {
        var dateCurrent = DateFormat('dd/MM/yyyy').parse(element.ngay.value);
        return dateNow.year == dateCurrent.year && dateNow.month == dateCurrent.month;
      },
    ).toList();
    _locTongTheoTienTe(lstThang);
  }

  void _tinhTongTuanNay() {
    var dateNow = DateTime.now();
    final lstTuan = AppHive.boxChiTieu.values.where(
      (element) {
        var date = DateFormat('dd/MM/yyyy').parse(element.ngay.value);
        var day = dateNow.difference(date).inDays;
        day -= date.weekday;
        kPrint(day);
        return day >= -7 && day <= 0;
      },
    ).toList();
    _locTongTheoTienTe(lstTuan);
  }

  void _tinh7NgayGanNhat() {
    var dateNow = DateTime.now();
    final lstTuan = AppHive.boxChiTieu.values.where(
      (element) {
        final day = dateNow.difference(DateFormat('dd/MM/yyyy').parse(element.ngay.value)).inDays;
        return day <= 7 && day >= 0;
      },
    ).toList();
    _locTongTheoTienTe(lstTuan);
  }

  void _locTongTheoTienTe(List<GhiChiTieuModel> list) {
    if (list.isEmpty) {
      rxTong.value = "+0";
      rxTongTru.value = "-0";
      return;
    }

    final lstTienTe = <String>[];
    for (var element in list) {
      if (!lstTienTe.contains(element.codeTienTe)) {
        lstTienTe.add(element.codeTienTe.value);
      }
    }

    if (lstTienTe.length > 1) {
      final lstString = <String>[];
      final lstStringTru = <String>[];
      for (var tienTe in lstTienTe) {
        final lst = list.where((element) => element.codeTienTe == tienTe).toList();
        lstString.add(Utils.formatMoney(_tinhTong(lst)) + lst.first.donVi.value);
        lstStringTru.add(Utils.formatMoney(_tinhTongTru(lst)) + lst.first.donVi.value);
      }
      rxTong.value = lstString.join('\n');
      rxTongTru.value = lstStringTru.join('\n');
    } else {
      rxTong.value = Utils.formatMoney(_tinhTong(list)) + list.first.donVi.value;
      rxTongTru.value = '${Utils.formatMoney(_tinhTongTru(list))}${list.first.donVi.value}';
    }
  }

  double _tinhTong(List<GhiChiTieuModel> list) {
    var tong = 0.0;
    for (var element in list) {
      if (element.loaiChiTieu == TypeTab.nhanTien.index || (element.loaiChiTieu == TypeTab.choVay.index && element.choVay?.laDiVay == true)) {
        tong += double.tryParse(element.soTien.value.replaceAll(',', '')).value;
      }
    }
    return tong;
  }

  double _tinhTongTru(List<GhiChiTieuModel> list) {
    var tong = 0.0;
    for (var element in list) {
      if (element.loaiChiTieu == TypeTab.chiTieu.index || (element.loaiChiTieu == TypeTab.choVay.index && element.choVay?.laDiVay != true)) {
        tong -= double.tryParse(element.soTien.value.replaceAll(',', '')).value;
      }
    }
    return tong;
  }
}

enum ThongKeTheo {
  tuanGanNhat,
  tuanNay,
  thangNay,
  thangTruoc,
  quyNay,
  namNay,
}
