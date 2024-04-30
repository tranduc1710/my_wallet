import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_wallet/core/base/base.dart';

import 'splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SplashCubit(context),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<SplashCubit>(context);

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/icons/logo.png',
            width: 50.dm,
          ),
          10.wSpaceHeight(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 10.dm,
                height: 10.dm,
                child: CircularProgressIndicator(
                  strokeWidth: 2.dm,
                  strokeCap: StrokeCap.round,
                  strokeAlign: .5,
                ),
              ),
              7.wSpaceWidth(),
              AppLanguage.loadingData.wText(),
              10.wSpaceWidth(),
            ],
          ),
        ],
      ),
    );
  }
}
