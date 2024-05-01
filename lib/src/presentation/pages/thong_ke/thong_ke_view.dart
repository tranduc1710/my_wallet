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

  Widget _buildBody(ThongKeBloc bloc) => SingleChildScrollView(
        child: StreamBuilder(
            stream: bloc.rxLoaiTK,
            initialData: bloc.rxLoaiTK.value,
            builder: (context, snapshotTK) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                  ),
                  StreamBuilder(
                      stream: bloc.rxTong,
                      initialData: bloc.rxTong.value,
                      builder: (context, snapshot) {
                        return snapshot.data.value.wText(
                            style: AppStyle.s20.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ));
                      }),
                  StreamBuilder(
                      stream: bloc.rxTongTru,
                      initialData: bloc.rxTongTru.value,
                      builder: (context, snapshot) {
                        return snapshot.data.value.wText(
                            style: AppStyle.s20.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ));
                      }),
                ],
              ).wPadding(AppEdgeInsets.screen);
            }),
      );
}
