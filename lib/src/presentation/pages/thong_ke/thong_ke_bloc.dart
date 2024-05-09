part of 'thong_ke_view.dart';

class ThongKeBloc extends Bloc<_ThongKeEvent, _ThongKeState> {
  final rxTong = "0".rx;
  final rxTongTru = "0".rx;
  final rxHienTai = "0".rx;
  final rxType = 0.rx;
  final rxLoaiTK = ThongKeTheo.tuanGanNhat.rx;
  final rxChart = <PieChartSectionData>[
    PieChartSectionData(
      color: Colors.green,
      value: 30,
      title: 0.toString(),
      titleStyle: AppStyle.normal.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: Colors.red,
      value: 30,
      title: 0.toString(),
      titleStyle: AppStyle.normal.copyWith(color: Colors.white),
    ),
    PieChartSectionData(
      color: AppColor.secondaryText,
      value: 40,
      title: 0.toString(),
      titleStyle: AppStyle.normal.copyWith(color: Colors.red),
    ),
  ].rx;

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
      rxHienTai.value = "0";
      return;
    }

    final lstTienTe = <String>[];
    for (var element in list) {
      if (!lstTienTe.contains(element.codeTienTe)) {
        lstTienTe.add(element.codeTienTe.value);
      }
    }

    if (lstTienTe.length > 1) {
      final lstString = <String, double>{};
      final lstStringTru = <String, double>{};
      final mapTong = <String, double>{};

      for (var tienTe in lstTienTe) {
        final lst = list.where((element) => element.codeTienTe == tienTe).toList();
        final tong = _tinhTong(lst);
        final tru = _tinhTongTru(lst);

        mapTong[lst.first.donVi.value] = tong + tru;
        lstString[lst.first.donVi.value] = tong;
        lstStringTru[lst.first.donVi.value] = tru;
      }
      rxTong.value = lstString.entries.map((map) => Utils.formatMoney(map.value, false) + map.key).join('\n');
      rxTongTru.value = lstStringTru.entries.map((map) => Utils.formatMoney(map.value, false) + map.key).join('\n');
      rxHienTai.value = mapTong.entries.map((map) => Utils.formatMoney(map.value) + map.key).join('\n');
      rxChart.value.clear();
      rxChart.refresh();

      for (var i = 0; i < lstTienTe.length; i++) {
        final tru = lstStringTru.entries.elementAt(i);
        final tong = lstString.entries.elementAt(i);
        final hienTai = tong.value + tru.value;

        final double ptConLai = tru.value == 0 ? 100 : (hienTai / tru.value * 100);

        rxChart.value.add(PieChartSectionData(
          color: Colors.red,
          value: ptConLai / lstTienTe.length,
          title: '-${Utils.formatMoney(tru.value, false) + tru.key}',
          titleStyle: AppStyle.normal.copyWith(color: Colors.black),
        ));
        rxChart.value.add(PieChartSectionData(
          color: Colors.green,
          value: (100 - ptConLai).abs() / lstTienTe.length,
          title: '+${Utils.formatMoney(tong.value, false) + tong.key}',
          titleStyle: AppStyle.normal.copyWith(color: Colors.black),
        ));
      }

      rxChart.refresh();
    } else {
      final tong = _tinhTong(list);
      final tru = _tinhTongTru(list);
      final hienTai = tong + tru;

      rxTong.value = Utils.formatMoney(_tinhTong(list), false) + list.first.donVi.value;
      rxTongTru.value = '${Utils.formatMoney(_tinhTongTru(list), false)}${list.first.donVi.value}';
      rxHienTai.value = Utils.formatMoney(hienTai) + list.first.donVi.value;

      final double ptConLai = tru == 0 ? 100 : (hienTai / tru * 100);

      rxChart.value = [
        PieChartSectionData(
          color: Colors.red,
          value: ptConLai,
          title: '-${rxTongTru.value}',
          titleStyle: AppStyle.normal.copyWith(color: Colors.black),
        ),
        PieChartSectionData(
          color: Colors.green,
          value: (100 - ptConLai).abs(),
          title: '+${rxTong.value}',
          titleStyle: AppStyle.normal.copyWith(color: Colors.black),
        ),
      ];
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
