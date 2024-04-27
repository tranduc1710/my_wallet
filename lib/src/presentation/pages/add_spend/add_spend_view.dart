import 'package:my_wallet/core/base/base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  Widget _buildBody(AddSpendBloc bloc) => Container();
}
