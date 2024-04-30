part of 'add_spend_view.dart';

class AddSpendBloc extends Bloc<_AddSpendEvent, _AddSpendState> {
  /// tab chi tieu
  final tfNgayPhatSinh = TextEditingController(text: DateTime.now().withFormat());
  final tfThoiGianPhatSinh = TextEditingController(text: TimeOfDay.now().format(Constant.navigatorKey.currentContext!));

  final dropTienTeController = AppDropdownController(list: AppHive.boxTienTe.values.toList());
  late final AppDropdownController<LoaiChiTieuModel> dropController;

  /// tab cho vay
  late final AppDropdownController<LoaiChiTieuModel> dropNguoiVayController;
  final tfNgayChoVay = TextEditingController(text: DateTime.now().withFormat());
  final tfGioChoVay = TextEditingController(text: TimeOfDay.now().format(Constant.navigatorKey.currentContext!));
  final tfNgayTraNo = TextEditingController();
  final tfGioTraNo = TextEditingController();
  final rxLaiSuat = LaiSuat.khong.rx;
  final lstTimeLaiSuat = [
    (text: AppLanguage.nam, index: TypeLaiSuat.nam.index),
    (text: AppLanguage.thang, index: TypeLaiSuat.thang.index),
    (text: AppLanguage.ngay, index: TypeLaiSuat.ngay.index),
  ];
  late final AppDropdownController<({int index, String text})> dropHanLaiSuatController;
  final tfNgayHanLai = TextEditingController();
  final isDiVay = false.rx;

  /// tab nhan tien
  late final AppDropdownController<LoaiChiTieuModel> dropNhanTuController;
  final tfNgayNhan = TextEditingController(text: DateTime.now().withFormat());
  final tfGioNhan = TextEditingController(text: TimeOfDay.now().format(Constant.navigatorKey.currentContext!));

  /// dung chung
  final tfSoTien = TextEditingController();
  final focusSoTien = FocusNode();
  final tfGhiChu = TextEditingController();
  final indexTab = 0.rx;
  final isNhapSoTien = false.rx;

  AddSpendBloc() : super(_InitState()) {
    on<InitEvent>(_init);
    on<ThemLoaiChiTieuEvent>(_themLoaiChiTieu);
    on<ShowTimePickerEvent>(_showTimePicker);
    on<ChoiceTimePickerEvent>(_choiceTimePicker);
    on<AddSpendEvent>(_addSpend);
  }

  void _init(InitEvent event, Emitter<_AddSpendState> emit) {
    dropController = AppDropdownController(list: AppHive.boxLoaiChiTieu.values.toList());
    dropNguoiVayController = AppDropdownController(list: AppHive.boxNguoiVay.values.toList());
    dropNhanTuController = AppDropdownController(list: AppHive.boxNhanTu.values.toList());
    dropHanLaiSuatController = AppDropdownController(list: lstTimeLaiSuat);

    focusSoTien.addListener(() {
      isNhapSoTien.value = focusSoTien.hasFocus;
    });

    emit(_CompleteState());
  }

  FutureOr<void> _themLoaiChiTieu(ThemLoaiChiTieuEvent event, Emitter<_AddSpendState> emit) async {
    final item = LoaiChiTieuModel(
      loai: event.idTab.toString(),
      ten: event.name,
      id: DateTime.now().millisecondsSinceEpoch,
    );

    if (event.idTab == TypeTab.chiTieu.index) {
      AppHive.boxLoaiChiTieu.put(item.id.toString(), item);
      dropController.list = AppHive.boxLoaiChiTieu.values.toList();
    }
    if (event.idTab == TypeTab.choVay.index) {
      AppHive.boxNguoiVay.put(item.id.toString(), item);
      dropNguoiVayController.list = AppHive.boxNguoiVay.values.toList();
    }
    if (event.idTab == TypeTab.nhanTien.index) {
      AppHive.boxNhanTu.put(item.id.toString(), item);
      dropNhanTuController.list = AppHive.boxNhanTu.values.toList();
    }
  }

  FutureOr<void> _showTimePicker(ShowTimePickerEvent event, Emitter<_AddSpendState> emit) {
    emit(_ChoiceTimeState(event.type));
  }

  FutureOr<void> _choiceTimePicker(ChoiceTimePickerEvent event, Emitter<_AddSpendState> emit) {
    final day = event.day?.withFormat() ?? '';
    final time = event.time?.format(Constant.navigatorKey.currentContext!) ?? '';

    if (event.type == TypePicker.dayChiTieu) tfNgayPhatSinh.text = day;
    if (event.type == TypePicker.timeChiTieu) tfThoiGianPhatSinh.text = time;

    if (event.type == TypePicker.dayChoVay) tfNgayChoVay.text = day;
    if (event.type == TypePicker.timeChoVay) tfGioChoVay.text = time;

    if (event.type == TypePicker.dayTraNo) tfNgayTraNo.text = day;
    if (event.type == TypePicker.timeTraNo) tfGioTraNo.text = time;

    if (event.type == TypePicker.dayNhan) tfNgayNhan.text = day;
    if (event.type == TypePicker.timeNhan) tfGioNhan.text = time;
  }

  void _addSpend(AddSpendEvent event, Emitter<_AddSpendState> emit) async {
    if (!_isValidate(emit)) {
      return;
    }

    final id = DateTime.now().millisecondsSinceEpoch;

    final ghiChiTieu = GhiChiTieuModel(
      id: id,
      loaiChiTieu: indexTab.value,
      soTien: tfSoTien.text.trim(),
      codeTienTe: dropTienTeController.getItemSelect()?.code,
      donVi: dropTienTeController.getItemSelect()?.symbol,
      ghiChu: tfGhiChu.text.trim(),
      ngay: indexTab.value == TypeTab.chiTieu.index
          ? tfNgayPhatSinh.text.trim()
          : indexTab.value == TypeTab.choVay.index
              ? tfNgayChoVay.text.trim()
              : indexTab.value == TypeTab.nhanTien.index
                  ? tfNgayNhan.text.trim()
                  : null,
      gio: indexTab.value == TypeTab.chiTieu.index
          ? tfThoiGianPhatSinh.text.trim()
          : indexTab.value == TypeTab.choVay.index
              ? tfGioChoVay.text.trim()
              : indexTab.value == TypeTab.nhanTien.index
                  ? tfGioNhan.text.trim()
                  : null,
      chiTieu: indexTab.value != TypeTab.chiTieu.index
          ? null
          : ChiTieuModel(
              loaiChiTieu: dropController.getItemSelect()?.id,
              fullNgayGio: DateFormat('dd/MM/yyyy HH:mm').parse('${tfNgayPhatSinh.text.trim()} ${tfThoiGianPhatSinh.text.trim()}').millisecondsSinceEpoch,
            ),
      choVay: indexTab.value != TypeTab.choVay.index
          ? null
          : ChoVayModel(
              nguoiVay: dropNguoiVayController.getItemSelect()?.id,
              ngayTraNo: tfNgayTraNo.text.trim(),
              gioTraNo: tfGioTraNo.text.trim(),
              laiSuat: rxLaiSuat.value.index,
              tienLaiSuat: tfNgayHanLai.text.trim(),
              phanTramLai: tfNgayHanLai.text.trim(),
              donViLaiPt: dropHanLaiSuatController.getItemSelect()?.index,
              laDiVay: isDiVay.value,
            ),
      nhanTien: indexTab.value != TypeTab.nhanTien.index
          ? null
          : NhanTienModel(
              nhanTu: dropNhanTuController.getItemSelect()?.id,
            ),
    );

    kPrint(ghiChiTieu.toRawJson());

    AppHive.boxChiTieu.put(id.toString(), ghiChiTieu);

    emit(_AddSuccessState());
  }

  bool _isValidate(Emitter<_AddSpendState> emit) {
    if (tfSoTien.text.trim().isEmpty) {
      emit(_AlertState(AppLanguage.chuaNhapSoTien));
      return false;
    }

    /// chi tieu
    if (indexTab.value == 0) {
      try {
        DateFormat('dd/MM/yyyy HH:mm').parse('${tfNgayPhatSinh.text.trim()} ${tfThoiGianPhatSinh.text.trim()}');
      } catch (_) {
        emit(_AlertState(AppLanguage.ngayGioKhongDung));
        return false;
      }
    }

    /// cho vay
    if (indexTab.value == 1) {
      if (dropNguoiVayController.getItemSelect() == null) {
        emit(_AlertState(AppLanguage.chuaChonNguoiChoVay));
        return false;
      }
      try {
        DateFormat('dd/MM/yyyy HH:mm').parse('${tfNgayChoVay.text.trim()} ${tfGioChoVay.text.trim()}');

        if (tfNgayTraNo.text.trim().isNotEmpty) {
          DateFormat('dd/MM/yyyy').parse(tfNgayTraNo.text.trim());
        }
        if (tfGioTraNo.text.trim().isNotEmpty) {
          DateFormat('HH:mm').parse(tfGioTraNo.text.trim());
        }
      } catch (_) {
        emit(_AlertState(AppLanguage.ngayGioKhongDung));
        return false;
      }
    }

    /// Nhan tien
    if (indexTab.value == 2) {
      try {
        if (tfNgayNhan.text.trim().isNotEmpty) {
          DateFormat('dd/MM/yyyy').parse(tfNgayNhan.text.trim());
        }
        if (tfGioNhan.text.trim().isNotEmpty) {
          DateFormat('HH:mm').parse(tfGioNhan.text.trim());
        }
      } catch (_) {
        emit(_AlertState(AppLanguage.ngayGioKhongDung));
        return false;
      }
    }

    return true;
  }
}
