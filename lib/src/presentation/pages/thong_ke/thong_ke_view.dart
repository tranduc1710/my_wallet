import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_wallet/core/base/base.dart';
import 'package:my_wallet/core/utils/hive/hive.dart';
import 'package:my_wallet/src/domain/entity/chi_tieu/ghi_chi_tieu.hive.dart';
import 'package:my_wallet/src/presentation/pages/add_spend/add_spend_view.dart';

import '../../../../core/components/components.dart';
import '../../../../core/utils/utils.dart';

part 'thong_ke_bloc.dart';
part 'thong_ke_event.dart';
part 'thong_ke_state.dart';

class ThongKePage extends StatelessWidget {
  const ThongKePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ThongKeBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final bloc = BlocProvider.of<ThongKeBloc>(context);

    return Scaffold(
      body: BlocConsumer<ThongKeBloc, _ThongKeState>(
        listener: (context, state) {
          if (state is _AlertState) {
            DialogContent(content: state.message).show(context);
          }
        },
        buildWhen: (previous, current) => current is _ErrorState || current is _CompleteState,
        builder: (context, state) {
          if (state is _ErrorState) {
            return _error(state);
          }
          return _buildBody(bloc);
        },
      ),
    ).wUnFocus();
  }

  Widget _error(_ErrorState state) => Center(
        child: state.content.wText(
          style: AppStyle.s16.copyWith(color: AppColor.error),
        ),
      );

  Widget _buildBody(ThongKeBloc bloc) => StreamBuilder(
      stream: bloc.rxLoaiTK,
      initialData: bloc.rxLoaiTK.value,
      builder: (context, snapshotTK) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: .7.w,
              width: .7.w,
              child: StreamBuilder(
                  stream: bloc.rxChart,
                  initialData: bloc.rxChart.value,
                  builder: (context, snapshot) {
                    return PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                        ),
                        borderData: FlBorderData(show: false),
                        sectionsSpace: 2,
                        centerSpaceRadius: 40,
                        sections: snapshot.data,
                      ),
                    );
                  }),
            ).wCenter(),
            Container(
              color: AppColor.divider,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLanguage.soTienHienTai.colon.wText(style: AppStyle.s16.copyWith(color: AppColor.textIcon, fontWeight: FontWeight.bold,)),
                  Expanded(child: bloc.rxSoTienHT.value.wText(style: AppStyle.s16.copyWith(color: AppColor.primary, fontWeight: FontWeight.bold,))),
                ],
              ).wPadding(AppEdgeInsets.screen),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                AppLanguage.locTheo.colon.wText(),
                5.wSpaceWidth(),
                DropdownButton(
                  value: snapshotTK.data,
                  items: [
                    DropdownMenuItem(value: ThongKeTheo.tuanGanNhat, child: AppLanguage.tuanGanDay.wText()),
                    DropdownMenuItem(value: ThongKeTheo.tuanNay, child: AppLanguage.tuanNay.wText()),
                    DropdownMenuItem(value: ThongKeTheo.thangNay, child: AppLanguage.thangNay.wText()),
                    DropdownMenuItem(value: ThongKeTheo.thangTruoc, child: AppLanguage.thangTruoc.wText()),
                    DropdownMenuItem(value: ThongKeTheo.quyNay, child: AppLanguage.quyNay.wText()),
                    DropdownMenuItem(value: ThongKeTheo.namNay, child: AppLanguage.namNay.wText()),
                  ],
                  onChanged: (value) => bloc.add(DoiLoaiTKEvent(value!)),
                ),
              ],
            ).wPadding(AppEdgeInsets.screen),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: AppLanguage.nhanTien.colon.wText()),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder(
                              stream: bloc.rxTong,
                              initialData: bloc.rxTong.value,
                              builder: (context, snapshot) {
                                return snapshot.data.value.wText(
                                    style: AppStyle.s16.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                ));
                              }),
                        ),
                      ],
                    ),
                    10.wSpaceHeight(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: AppLanguage.chiTieu.colon.wText()),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder(
                              stream: bloc.rxTongTru,
                              initialData: bloc.rxTongTru.value,
                              builder: (context, snapshot) {
                                return snapshot.data.value.wText(
                                    style: AppStyle.s16.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                ));
                              }),
                        ),
                      ],
                    ),
                    10.wSpaceHeight(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(flex: 1, child: AppLanguage.tong.colon.wText()),
                        Expanded(
                          flex: 3,
                          child: StreamBuilder(
                              stream: bloc.rxHienTai,
                              initialData: bloc.rxHienTai.value,
                              builder: (context, snapshot) {
                                return snapshot.data.value.wText(
                                    style: AppStyle.s16.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.secondaryText,
                                ));
                              }),
                        ),
                      ],
                    ),
                  ],
                ).wPadding(AppEdgeInsets.screen),
              ),
            ),
          ],
        );
      });
}
