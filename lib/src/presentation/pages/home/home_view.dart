import 'dart:async';

import 'package:base_flutter/core/base/base.dart';
import 'package:base_flutter/core/utils/routers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/dialog/dialog_content.dart';
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

    return Scaffold(
      body: BlocConsumer<HomeBloc, _HomeState>(
        listener: (context, state) {
          if (state is _AlertState) {
            DialogContent(content: state.message).show(context);
          }
          if (state is _AddSpendState) {
            AppRouters.addSpend.push(context);
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

  Widget _buildBody(HomeBloc bloc) => Scaffold(
        appBar: AppBar(
          title: Text(AppLanguage.home),
        ),
        body: Column(
          children: [
            Text(
              AppLanguage.total(1020323),
              style: AppStyle.s16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        floatingActionButton: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FloatingActionButton(
              heroTag: 'add',
              onPressed: () => bloc.add(_PushView(_AddSpendState())),
              backgroundColor: AppColor.accent,
              child: Icon(
                Icons.add,
                size: 25.dm,
              ),
            ),
          ],
        ),
      );
}
