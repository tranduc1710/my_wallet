import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/core/base/base.dart';
import 'package:my_wallet/core/utils/hive/hive.dart';
import 'package:my_wallet/core/utils/routers.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/ghi_chi_tieu.hive.dart';
import 'package:my_wallet/src/presentation/pages/add_spend/add_spend_view.dart';
import 'package:my_wallet/src/presentation/pages/thong_ke/thong_ke_view.dart';
import 'package:my_wallet/src/presentation/widget/header_date_sliver.dart';

import '../../../../core/components/components.dart';
import '../../../../core/utils/utils.dart';

part 'home_bloc.dart';
part 'home_event.dart';
part 'home_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => HomeBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<HomeBloc>(context);

    return StreamBuilder(
        stream: bloc.indexTab,
        initialData: bloc.indexTab.value,
        builder: (context, snapshot) {
          return DefaultTabController(
            length: 3,
            initialIndex: snapshot.data.value,
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    color: AppColor.primary,
                    width: double.infinity,
                    height: 1.dmTop,
                  ),
                  Expanded(
                    child: BlocConsumer<HomeBloc, _HomeState>(
                      listener: (context, state) {
                        if (state is _AlertState) {
                          DialogContent(content: state.message).show(context);
                        }
                        if (state is _AddSpendState) {
                          AppRouters.addSpend.push(context);
                        }
                      },
                      buildWhen: (previous, current) =>
                          current is _LoadingState || current is _ErrorState || current is _CompleteState,
                      builder: (context, state) {
                        if (state is _LoadingState || state is _InitState) {
                          return _loading();
                        }
                        if (state is _ErrorState) {
                          return _error(state);
                        }
                        return TabBarView(
                          children: [
                            _buildBody(bloc),
                            const AddSpendPage(isAdd: true),
                            const ThongKePage(),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
              bottomNavigationBar: TabBar(
                unselectedLabelStyle: AppStyle.s12,
                labelStyle: AppStyle.s13.copyWith(color: AppColor.primary),
                dividerColor: AppColor.divider,
                tabs: [
                  Tab(
                    icon: const Icon(Icons.list_alt),
                    text: AppLanguage.chiTieu,
                  ),
                  Tab(
                    icon: const Icon(Icons.add_circle_outline),
                    text: AppLanguage.addSpend,
                  ),
                  Tab(
                    icon: const Icon(Icons.analytics_outlined),
                    text: AppLanguage.thongKe,
                  ),
                ],
              ),
              // BottomNavigationBar(
              //   onTap: (value) => bloc.indexTab.value = value,
              //   elevation: 20,
              //   backgroundColor: AppColor.textIcon,
              //   enableFeedback: true,
              //   currentIndex: snapshot.data.value,
              //   selectedLabelStyle: AppStyle.s13.copyWith(color: AppColor.primary),
              //   unselectedLabelStyle: AppStyle.s12,
              //   items: [
              //     BottomNavigationBarItem(
              //       icon: const Icon(Icons.list_alt).wPadding(EdgeInsets.symmetric(vertical: 3.dm)),
              //       label: AppLanguage.chiTieu,
              //     ),
              //     BottomNavigationBarItem(
              //       icon: const Icon(Icons.add_circle_outline),
              //       label: AppLanguage.addSpend,
              //     ),
              //     BottomNavigationBarItem(
              //       icon: const Icon(Icons.analytics_outlined),
              //       label: AppLanguage.thongKe,
              //     ),
              //   ],
              // ),
            ).wUnFocus(),
          );
        });
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _error(_ErrorState state) => Center(
        child: state.content.wText(
          style: AppStyle.s16.copyWith(color: AppColor.error),
        ),
      );

  Widget _buildBody(HomeBloc bloc) {
    return StreamBuilder(
        stream: bloc.lstDate,
        initialData: bloc.lstDate.value,
        builder: (context, snapshot) {
          return CustomScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            slivers: List.generate(snapshot.data.getList.length, (index) {
              final list =
                  bloc.lstChiTieu.where((element) => element.ngay == snapshot.data.getList[index]).toList().reversed.toList();

              return SliverMainAxisGroup(slivers: [
                SliverPersistentHeader(
                  pinned: true,
                  floating: true,
                  delegate: HeaderDate(
                    max: 35.dm,
                    min: 35.dm,
                    child: Container(
                      width: double.infinity,
                      color: AppColor.lightPrimary,
                      child: snapshot.data.getList[index]
                          .wText(
                              style: AppStyle.normal.copyWith(
                            color: AppColor.darkPrimary,
                            fontWeight: FontWeight.w600,
                          ))
                          .wCenter(),
                    ),
                  ),
                ),
                SliverList.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) => _viewItem(list[index]),
                ),
              ]);
            }),
          );
        });
  }

  Widget _viewItem(GhiChiTieuModel item) {
    final loaiChiTieu = _getLoaiChiTieu(item);
    final isAdd =
        item.loaiChiTieu == TypeTab.nhanTien.index || (item.loaiChiTieu == TypeTab.choVay.index && item.choVay?.laDiVay == true);

    return Container(
      margin: AppEdgeInsets.item,
      padding: AppEdgeInsets.item,
      decoration: BoxDecoration(
        color: AppColor.textIcon,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [BoxShadow(color: AppColor.divider.withOpacity(.3), offset: const Offset(0, 2), blurRadius: 8)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 3.dm, horizontal: 5.dm),
                decoration: BoxDecoration(
                  color: loaiChiTieu.color,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: loaiChiTieu.title.wText(style: AppStyle.s12.copyWith(color: AppColor.textIcon, height: 1.3)),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3.dm, horizontal: 5.dm),
                decoration: BoxDecoration(
                  color: AppColor.divider.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: item.gio.value.wText(style: AppStyle.s12.copyWith(color: AppColor.secondaryText, height: 1.3)),
              ),
            ],
          ),
          5.wSpaceHeight(),
          Table(
            columnWidths: const {
              0: FlexColumnWidth(2),
              1: FlexColumnWidth(5),
            },
            children: [
              TableRow(children: [
                AppLanguage.soTien.colon.wText(style: AppStyle.normal.copyWith(color: AppColor.secondaryText)),
                "${isAdd ? "+" : "-"}${item.soTien ?? 0}${item.donVi}".wText(
                    style: AppStyle.normal.copyWith(
                  color: isAdd ? Colors.green : Colors.red,
                )),
              ]),
              if (item.ghiChu.value.isNotEmpty)
                TableRow(children: [
                  AppLanguage.ghiChu.colon.wText(style: AppStyle.normal.copyWith(color: AppColor.secondaryText)),
                  item.ghiChu.value.wText(),
                ]),
              if (item.loaiChiTieu == TypeTab.chiTieu.index && item.chiTieu?.loaiChiTieu != null) ...[
                TableRow(children: [
                  AppLanguage.loaiChiTieu.colon.wText(style: AppStyle.normal.copyWith(color: AppColor.secondaryText)),
                  AppHive.boxLoaiChiTieu.get(item.chiTieu!.loaiChiTieu!.value.toString())!.ten.value.wText(),
                ]),
              ],
              if (item.loaiChiTieu == TypeTab.choVay.index) ...[
                TableRow(children: [
                  (item.choVay!.laDiVay == true ? AppLanguage.nguoiChoVay : AppLanguage.nguoiVay)
                      .colon
                      .wText(style: AppStyle.normal.copyWith(color: AppColor.secondaryText)),
                  AppHive.boxNguoiVay.get(item.choVay!.nguoiVay!.value.toString())!.ten.value.wText(),
                ]),
                if ("${item.choVay!.ngayTraNo.value} ${item.choVay!.gioTraNo.value}".trim().isNotEmpty)
                  TableRow(children: [
                    AppLanguage.thoiGianTraNo.colon.wText(style: AppStyle.normal.copyWith(color: AppColor.secondaryText)),
                    "${item.choVay!.ngayTraNo.value} ${item.choVay!.gioTraNo.value}".trim().wText(),
                  ]),
                TableRow(children: [
                  AppLanguage.laiSuat.colon.wText(style: AppStyle.normal.copyWith(color: AppColor.secondaryText)),
                  _getLaiSuat(item).wText(),
                ]),
              ],
              if (item.loaiChiTieu == TypeTab.nhanTien.index) ...[
                TableRow(children: [
                  AppLanguage.nhanTu.colon.wText(style: AppStyle.normal.copyWith(color: AppColor.secondaryText)),
                  if (item.nhanTien!.nhanTu != null)
                    AppHive.boxNhanTu.get(item.nhanTien!.nhanTu!.value.toString())!.ten.value.wText(),
                  if (item.nhanTien!.nhanTu == null) ''.wText(),
                ]),
              ],
            ],
          ),
        ],
      ),
    );
  }

  ({Color color, String title}) _getLoaiChiTieu(GhiChiTieuModel item) {
    if (TypeTab.chiTieu.index == item.loaiChiTieu) {
      return (color: Colors.deepOrange, title: AppLanguage.chiTieu);
    }
    if (TypeTab.choVay.index == item.loaiChiTieu) {
      return (color: Colors.deepPurple, title: item.choVay!.laDiVay! ? AppLanguage.vayNguoiKhac : AppLanguage.choVay);
    }
    if (TypeTab.nhanTien.index == item.loaiChiTieu) {
      return (color: Colors.green, title: AppLanguage.nhanTien);
    }
    return (color: Colors.white, title: '');
  }

  String _getLaiSuat(GhiChiTieuModel item) {
    var laiSuat = '';

    if (item.choVay!.laiSuat == LaiSuat.khong.index) {
      return AppLanguage.khong;
    }

    if (item.choVay!.laiSuat == LaiSuat.ngay.index) {
      final day = DateTime.now().difference(DateFormat('dd/MM/yyyy').parse(item.ngay.value)).inDays;
      final soTien = double.tryParse(item.choVay!.tienLaiSuat.value.replaceAll(',', '')).value * day;

      return "${item.choVay!.tienLaiSuat.value}/${AppLanguage.ngay} x $day ${AppLanguage.ngay} = ${Utils.formatMoney(soTien)}${item.donVi}";
    }

    if (item.choVay!.laiSuat == LaiSuat.phanTram.index) {
      final dateCurrent = DateFormat('dd/MM/yyyy').parse(item.ngay.value);
      final day = DateTime.now().difference(dateCurrent).inDays;
      final tenLai = Constant.lstTimeLaiSuat.firstWhere((element) => element.index == item.choVay!.donViLaiPt);
      var donVi = '';
      var tien = double.tryParse(item.soTien.value.replaceAll(',', '')).value;

      if (tenLai.index == TypeLaiSuat.ngay.index) {
        donVi = "$day ${AppLanguage.ngay}";
        tien = tien / 100 * double.tryParse(item.choVay!.phanTramLai.value).value * day;
      } else if (tenLai.index == TypeLaiSuat.thang.index) {
        donVi = "${(day / 30).toStringAsFixed(1)} ${AppLanguage.thang}";
        tien = tien / 100 * double.tryParse(item.choVay!.phanTramLai.value).value * day / 30;
      } else if (tenLai.index == TypeLaiSuat.nam.index) {
        donVi = "${(day / 365).toStringAsFixed(1)} ${AppLanguage.nam}";
        tien = tien / 100 * double.tryParse(item.choVay!.phanTramLai.value).value * day / 365;
      }

      tien = tien.ceilToDouble();

      return "${item.choVay!.phanTramLai.value}%/${tenLai.text} x $donVi ($day ${AppLanguage.ngay}) = ${Utils.formatMoney(tien)}${item.donVi}";
    }

    return laiSuat;
  }
}
