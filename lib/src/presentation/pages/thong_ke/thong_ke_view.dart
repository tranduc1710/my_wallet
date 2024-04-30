import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallet/core/base/base.dart';

import '../../../../core/components/components.dart';
import '../../../../core/utils/utils.dart';

part 'thong_ke_bloc.dart';
part 'thong_ke_event.dart';
part 'thong_ke_state.dart';

class ThongKePage extends StatelessWidget {
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
        buildWhen: (previous, current) => current is _LoadingState || current is _ErrorState || current is _CompleteState,
        builder: (context, state) {
          if (state is _LoadingState || state is _InitState) {
            return _loading();
          }
          if (state is _ErrorState) {
            return _error(state);
          }
          return _buildBody(bloc);
        },
      ),
    ).wUnFocus();
  }

  Widget _loading() => const Center(child: CircularProgressIndicator());

  Widget _error(_ErrorState state) => Center(
        child: state.content.wText(
          style: AppStyle.s16.copyWith(color: AppColor.error),
        ),
      );

  Widget _buildBody(ThongKeBloc bloc) => Container();
}
