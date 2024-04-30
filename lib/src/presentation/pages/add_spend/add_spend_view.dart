import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/core/base/base.dart';
import 'package:my_wallet/core/utils/hive/hive.dart';
import 'package:my_wallet/core/utils/hive/hive.enum.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/chi_tieu.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/cho_vay.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/ghi_chi_tieu.hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/nhan_tien.hive.dart';
import 'package:my_wallet/src/domain/entity/hive/loai_chi_tieu.hive.dart';
import 'package:my_wallet/src/presentation/pages/add_success/add_success_view.dart';

import '../../../../core/components/components.dart';
import '../../../../core/utils/utils.dart';

part 'add_spend_bloc.dart';
part 'add_spend_event.dart';
part 'add_spend_state.dart';

class AddSpendPage extends StatelessWidget {
  final bool isAdd;

  const AddSpendPage({super.key, required this.isAdd});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddSpendBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<AddSpendBloc>(context);

    return Scaffold(
      body: BlocConsumer<AddSpendBloc, _AddSpendState>(
        listener: (context, state) async {
          if (state is _AddSuccessState) {
            // AppRouters.addSuccess.pushReplacement(context);
            showDialog(
              context: context,
              builder: (context) => const AddSuccessPage(),
            );
          }
          if (state is _AlertState) {
            DialogContent(content: state.message).show(context);
          }
          if (state is _ChoiceTimeState) {
            DateTime? dateTime;
            TimeOfDay? timeOfDay;

            if (state.type.name.startsWith('day')) {
              dateTime = await showDatePicker(
                context: context,
                firstDate: DateTime(1900),
                lastDate: DateTime(3000),
              );
            } else if (state.type.name.startsWith('time')) {
              timeOfDay = await showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
                initialEntryMode: TimePickerEntryMode.inputOnly,
              );
            }

            bloc.add(ChoiceTimePickerEvent(timeOfDay, state.type, dateTime));
          }
        },
        buildWhen: (previous, current) => current is _ErrorState || current is _CompleteState,
        builder: (context, state) {
          if (state is _InitState) {
            return _loading();
          }
          if (state is _ErrorState) {
            return _error(state);
          }
          return Column(
            children: [
              Expanded(
                child: DefaultTabController(
                  length: 3,
                  initialIndex: 0,
                  child: StreamBuilder(
                      stream: bloc.indexTab,
                      initialData: bloc.indexTab.value,
                      builder: (context, snapshot) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLanguage.dayLaKhoan.colon.wText().wPadding(AppEdgeInsets.screen),
                            5.wSpaceHeight(),
                            Row(
                              children: [
                                buildItemTab(bloc, snapshot, AppLanguage.chiTieu, 0),
                                buildItemTab(bloc, snapshot, AppLanguage.choVay, 1),
                                buildItemTab(bloc, snapshot, AppLanguage.nhanTien, 2),
                              ],
                            ).wPadding(EdgeInsets.symmetric(horizontal: 12.5.dm)),
                            Expanded(
                              child: IndexedStack(
                                index: snapshot.data,
                                children: [
                                  _buildTabChiTieu(bloc),
                                  _buildTabChoVay(bloc),
                                  _buildTabNhanTien(bloc),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              // StreamBuilder(
              //     stream: bloc.isNhapSoTien,
              //     initialData: bloc.isNhapSoTien.value,
              //     builder: (context, snapshot) {
              //       var value = bloc.tfSoTien.text;
              //
              //       final lstSplit = value.split('.');
              //       final lst = <String>[];
              //       final soTien = lstSplit.first.replaceAll(',', '');
              //       final soDu = soTien.length % 3;
              //
              //       for (var i = soTien.length ~/ 3; i > 0; i--) {
              //         if (i * 3 - 3 + soDu < 0) continue;
              //
              //         lst.insert(0, soTien.substring(i * 3 - 3 + soDu, i * 3 + soDu));
              //       }
              //       if (soDu != 0) {
              //         lst.insert(0, soTien.substring(0, soDu));
              //       }
              //       value = "${lst.join(',')}${lstSplit.length > 1 ? ".${lstSplit.last}" : ''}";
              //
              //       return AnimatedOpacity(
              //         opacity: snapshot.data == true && lst.isNotEmpty ? 1 : 0,
              //         duration: Constant.timeAnimationShort * .5,
              //         child: Row(
              //           children: [
              //             if (lst.length <= 1) ...[
              //               Expanded(
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(10),
              //                     boxShadow: const [
              //                       BoxShadow(
              //                         color: Colors.black26,
              //                         blurRadius: 5,
              //                         offset: Offset(0, 3),
              //                       )
              //                     ],
              //                   ),
              //                   child: ("${lst.first}00").wText().wCenter().wPadding(),
              //                 ),
              //               ),
              //               3.wSpaceWidth(),
              //             ],
              //             if (lst.length <= 2) ...[
              //               Expanded(
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(10),
              //                     boxShadow: const [
              //                       BoxShadow(
              //                         color: Colors.black26,
              //                         blurRadius: 5,
              //                         offset: Offset(0, 3),
              //                       )
              //                     ],
              //                   ),
              //                   child: ("${lst.first},000,000").wText().wCenter().wPadding(),
              //                 ),
              //               ),
              //               3.wSpaceWidth(),
              //             ],
              //             if (lst.length <= 3) ...[
              //               Expanded(
              //                 child: Container(
              //                   decoration: BoxDecoration(
              //                     color: Colors.white,
              //                     borderRadius: BorderRadius.circular(10),
              //                     boxShadow: const [
              //                       BoxShadow(
              //                         color: Colors.black26,
              //                         blurRadius: 5,
              //                         offset: Offset(0, 3),
              //                       )
              //                     ],
              //                   ),
              //                   child: ("${lst.first},000,000,000").wText().wCenter().wPadding(),
              //                 ),
              //               ),
              //               3.wSpaceWidth(),
              //             ],
              //             if (lst.length <= 2) ...[
              //               Expanded(
              //                 child: Card(elevation: 5, child: ("${lst.first},000,000").wText().wCenter().wPadding()),
              //               ),
              //               3.wSpaceWidth(),
              //             ],
              //             if (lst.length <= 3) ...[
              //               Expanded(
              //                 child: Card(elevation: 5, child: ("${lst.first},000,000").wText().wCenter().wPadding()),
              //               ),
              //             ],
              //           ],
              //         ).wPadding(),
              //       );
              //     }),
            ],
          );
        },
      ),
      bottomNavigationBar: AppButton(
        text: AppLanguage.add,
        onPressed: () => bloc.add(AddSpendEvent()),
      ).wPadding(AppEdgeInsets.screen),
    ).wUnFocus();
  }

  Expanded buildItemTab(AddSpendBloc bloc, AsyncSnapshot<int> snapshot, String title, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.5.dm),
        padding: EdgeInsets.symmetric(vertical: 10.dm),
        decoration: BoxDecoration(
          color: snapshot.data == index ? AppColor.primary.withOpacity(.3) : AppColor.divider.withOpacity(.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: title
            .wText(
              style: AppStyle.normal.copyWith(
                color: snapshot.data == index ? AppColor.primary : AppColor.secondaryText.withOpacity(.5),
                fontWeight: FontWeight.bold,
              ),
            )
            .wCenter(),
      ).onTap(() => bloc.indexTab.value = index),
    );
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _error(_ErrorState state) => Center(
        child: state.content.wText(
          style: AppStyle.s16.copyWith(color: AppColor.error),
        ),
      );

  // todo: tab chi tieu
  Widget _buildTabChiTieu(AddSpendBloc bloc) => SingleChildScrollView(
        child: Column(
          children: [
            khungNhapTien(bloc),
            5.wSpaceHeight(),
            AppTextField(
              controller: bloc.tfGhiChu,
              labelText: AppLanguage.ghiChu,
              keyboardType: TextInputType.number,
            ).wPadding(AppEdgeInsets.vertical),
            5.wSpaceHeight(),
            AppDropdownTF(
              controller: bloc.dropController,
              hintText: AppLanguage.loaiChiTieu,
              buildItem: (object) => object.ten.wText(),
              onChoice: (object) => object.ten,
              style: AppStyle.normal,
              onCreateNew: (name) {
                bloc.add(ThemLoaiChiTieuEvent(name, TypeTab.chiTieu.index));
              },
            ).wPadding(AppEdgeInsets.vertical),
            5.wSpaceHeight(),
            Row(
              children: [
                Expanded(
                  child: textFieldNgay(
                    bloc: bloc,
                    controller: bloc.tfNgayPhatSinh,
                    label: AppLanguage.ngayPhatSinh,
                    type: TypePicker.dayChiTieu,
                  ),
                ),
                7.wSpaceWidth(),
                Expanded(
                  child: textFieldGio(
                    bloc: bloc,
                    controller: bloc.tfThoiGianPhatSinh,
                    label: AppLanguage.gioPhatSinh,
                    type: TypePicker.timeChiTieu,
                  ),
                ),
              ],
            ),
          ],
        ).wPadding(AppEdgeInsets.screen),
      );

  Row khungNhapTien(AddSpendBloc bloc) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: textFieldNhapTien(bloc).wPadding(AppEdgeInsets.vertical),
        ),
        5.wSpaceWidth(),
        Expanded(
          child: AppDropdownTF(
            controller: bloc.dropTienTeController,
            initialValue: bloc.dropTienTeController.list
                    .where(
                      (element) => element.code == AppHive.boxConstant.get(HiveBoxConstant.tienTeVuaDung.name),
                    )
                    .firstOrNull ??
                bloc.dropTienTeController.list.firstOrNull,
            buildItem: (object) => '${object.code} (${object.symbol}) - ${object.namePlural}'.wText(),
            onChoice: (object) {
              AppHive.boxConstant.put(HiveBoxConstant.tienTeVuaDung.name, object.code);
              return object.code;
            },
            style: AppStyle.normal,
          ).wPadding(AppEdgeInsets.vertical),
        ),
      ],
    );
  }

  AppTextField textFieldNhapTien(AddSpendBloc bloc) {
    return AppTextField(
      controller: bloc.tfSoTien,
      focusNode: bloc.focusSoTien,
      labelText: AppLanguage.soTien,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]|\\.')),
      ],
      onChanged: (content) {
        onChangeFormatMoney(bloc.tfSoTien, content);
        bloc.isNhapSoTien.refresh();
      },
    );
  }

  void onChangeFormatMoney(TextEditingController controller, String value) {
    if (value.trim().isEmpty) return;

    final lstSplit = value.split('.');
    final lst = [];
    final soTien = lstSplit.first.replaceAll(',', '');
    final soDu = soTien.length % 3;

    for (var i = soTien.length ~/ 3; i > 0; i--) {
      if (i * 3 - 3 + soDu < 0) continue;

      lst.insert(0, soTien.substring(i * 3 - 3 + soDu, i * 3 + soDu));
    }
    if (soDu != 0) {
      lst.insert(0, soTien.substring(0, soDu));
    }
    value = "${lst.join(',')}${lstSplit.length > 1 ? ".${lstSplit.last}" : ''}";

    if (controller.text != value) {
      controller.text = value;
    }
  }

  // todo: tab cho vay
  Widget _buildTabChoVay(AddSpendBloc bloc) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            khungNhapTien(bloc),
            5.wSpaceHeight(),
            AppTextField(
              controller: bloc.tfGhiChu,
              labelText: AppLanguage.ghiChu,
              keyboardType: TextInputType.number,
            ).wPadding(AppEdgeInsets.vertical),
            5.wSpaceHeight(),
            AppDropdownTF(
              controller: bloc.dropNguoiVayController,
              hintText: AppLanguage.nguoiVay,
              buildItem: (object) => object.ten.wText(),
              onChoice: (object) => object.ten,
              style: AppStyle.normal,
              onCreateNew: (name) {
                bloc.add(ThemLoaiChiTieuEvent(name, TypeTab.choVay.index));
              },
            ).wPadding(AppEdgeInsets.vertical),
            5.wSpaceHeight(),
            Row(
              children: [
                Expanded(
                  child: textFieldNgay(
                    bloc: bloc,
                    controller: bloc.tfNgayChoVay,
                    label: AppLanguage.ngayChoVay,
                    type: TypePicker.dayChoVay,
                  ),
                ),
                7.wSpaceWidth(),
                Expanded(
                  child: textFieldGio(
                    bloc: bloc,
                    controller: bloc.tfGioChoVay,
                    label: AppLanguage.gioChoVay,
                    type: TypePicker.timeChoVay,
                  ),
                ),
              ],
            ),
            5.wSpaceHeight(),
            Row(
              children: [
                Expanded(
                  child: textFieldNgay(
                    bloc: bloc,
                    controller: bloc.tfNgayTraNo,
                    label: AppLanguage.ngayTraNo,
                    type: TypePicker.dayTraNo,
                  ),
                ),
                7.wSpaceWidth(),
                Expanded(
                  child: textFieldGio(
                    bloc: bloc,
                    controller: bloc.tfGioTraNo,
                    label: AppLanguage.gioTraNo,
                    type: TypePicker.timeTraNo,
                  ),
                ),
              ],
            ),
            5.wSpaceHeight(),
            AppLanguage.laiSuat.wText(),
            5.wSpaceHeight(),
            StreamBuilder(
                stream: bloc.rxLaiSuat,
                initialData: bloc.rxLaiSuat.value,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: LaiSuat.khong,
                                  groupValue: snapshot.data,
                                  onChanged: (value) => bloc.rxLaiSuat.value = value!,
                                ),
                                5.wSpaceWidth(),
                                AppLanguage.khong.wText(),
                              ],
                            ).onTap(() {
                              bloc.rxLaiSuat.value = LaiSuat.khong;
                              bloc.tfNgayHanLai.clear();
                            }),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: LaiSuat.ngay,
                                  groupValue: snapshot.data,
                                  onChanged: (value) => bloc.rxLaiSuat.value = value!,
                                ),
                                5.wSpaceWidth(),
                                AppLanguage.ngay.wText(),
                              ],
                            ).onTap(() {
                              bloc.rxLaiSuat.value = LaiSuat.ngay;
                              bloc.tfNgayHanLai.clear();
                            }),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                Radio(
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  value: LaiSuat.phanTram,
                                  groupValue: snapshot.data,
                                  onChanged: (value) => bloc.rxLaiSuat.value = value!,
                                ),
                                5.wSpaceWidth(),
                                AppLanguage.phanTram.wText(),
                              ],
                            ).onTap(() {
                              bloc.rxLaiSuat.value = LaiSuat.phanTram;
                              bloc.tfNgayHanLai.clear();
                            }),
                          ),
                        ],
                      ),
                      if (snapshot.data == LaiSuat.ngay) 7.wSpaceHeight(),
                      if (snapshot.data != LaiSuat.khong)
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: AppTextField(
                                controller: bloc.tfNgayHanLai,
                                labelText: snapshot.data == LaiSuat.phanTram ? AppLanguage.nhapSo : AppLanguage.soTien,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                ],
                                onChanged: (content) => snapshot.data != LaiSuat.ngay ? null : onChangeFormatMoney(bloc.tfNgayHanLai, content),
                              ),
                            ),
                            5.wSpaceWidth(),
                            if (snapshot.data == LaiSuat.phanTram) ...[
                              AppLanguage.theo.wText(),
                              5.wSpaceWidth(),
                              Expanded(
                                child: AppDropdownTF(
                                  controller: bloc.dropHanLaiSuatController,
                                  initialValue: bloc.dropHanLaiSuatController.list.firstOrNull,
                                  buildItem: (object) => object.text.wText(),
                                  onChoice: (object) {
                                    return object.text;
                                  },
                                  style: AppStyle.normal,
                                ).wPadding(AppEdgeInsets.vertical),
                              ),
                            ],
                          ],
                        ),
                    ],
                  );
                }),
            5.wSpaceHeight(),
            StreamBuilder(
                stream: bloc.isDiVay,
                initialData: bloc.isDiVay.value,
                builder: (context, snapshot) {
                  return Row(
                    children: [
                      Checkbox(
                        value: snapshot.data,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onChanged: (value) => bloc.isDiVay.value = value!,
                      ),
                      5.wSpaceWidth(),
                      AppLanguage.laDiVay.wText(),
                    ],
                  );
                }),
          ],
        ).wPadding(AppEdgeInsets.screen),
      );

  Widget textFieldNgay({
    required AddSpendBloc bloc,
    required TextEditingController controller,
    required String label,
    required TypePicker type,
  }) {
    return AppTextField(
      controller: controller,
      labelText: label,
      keyboardType: TextInputType.datetime,
      showClear: false,
      suffix: Icon(
        Icons.calendar_month,
        size: 20.dm,
      ).onTap(() => bloc.add(ShowTimePickerEvent(type))),
    ).wPadding(AppEdgeInsets.vertical);
  }

  Widget textFieldGio({
    required AddSpendBloc bloc,
    required TextEditingController controller,
    required String label,
    required TypePicker type,
  }) {
    return AppTextField(
      controller: controller,
      labelText: label,
      keyboardType: TextInputType.datetime,
      showClear: false,
      suffix: Icon(
        Icons.alarm,
        size: 20.dm,
      ).onTap(() => bloc.add(ShowTimePickerEvent(type))),
    ).wPadding(AppEdgeInsets.vertical);
  }

  // todo: tab nhan tien
  Widget _buildTabNhanTien(AddSpendBloc bloc) => SingleChildScrollView(
        child: Column(
          children: [
            khungNhapTien(bloc),
            5.wSpaceHeight(),
            AppTextField(
              controller: bloc.tfGhiChu,
              labelText: AppLanguage.ghiChu,
              keyboardType: TextInputType.number,
            ).wPadding(AppEdgeInsets.vertical),
            5.wSpaceHeight(),
            AppDropdownTF(
              controller: bloc.dropNhanTuController,
              hintText: AppLanguage.nhanTu,
              buildItem: (object) => object.ten.wText(),
              onChoice: (object) => object.ten,
              style: AppStyle.normal,
              onCreateNew: (name) {
                bloc.add(ThemLoaiChiTieuEvent(name, TypeTab.nhanTien.index));
              },
            ).wPadding(AppEdgeInsets.vertical),
            5.wSpaceHeight(),
            Row(
              children: [
                Expanded(
                  child: textFieldNgay(
                    bloc: bloc,
                    controller: bloc.tfNgayNhan,
                    label: AppLanguage.ngayNhan,
                    type: TypePicker.dayNhan,
                  ),
                ),
                7.wSpaceWidth(),
                Expanded(
                  child: textFieldGio(
                    bloc: bloc,
                    controller: bloc.tfGioNhan,
                    label: AppLanguage.gioNhan,
                    type: TypePicker.timeNhan,
                  ),
                ),
              ],
            ),
          ],
        ).wPadding(AppEdgeInsets.screen),
      );
}

enum TypeTab { chiTieu, choVay, nhanTien }

enum TypePicker { timeChiTieu, dayChiTieu, dayChoVay, timeChoVay, dayTraNo, timeTraNo, dayNhan, timeNhan }

enum LaiSuat { khong, phanTram, ngay }

enum TypeLaiSuat { ngay, thang, nam }
