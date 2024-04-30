import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_wallet/core/base/base.dart';
import 'package:my_wallet/core/components/components.dart';
import 'package:my_wallet/core/utils/utils.dart';

import 'add_success_cubit.dart';

class AddSuccessPage extends StatelessWidget {
  const AddSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AddSuccessCubit(),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    final cubit = BlocProvider.of<AddSuccessCubit>(context);

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          .2.h.wSpaceHeight(),
          FutureBuilder(
              future: Future.delayed(Duration.zero),
              builder: (context, snapshot) {
                return AnimatedScale(
                  duration: Constant.timeAnimationShort,
                  scale: snapshot.connectionState == ConnectionState.done ? 1 : 0,
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/OK.svg',
                        width: 70.dm,
                      ),
                      20.wSpaceHeight(),
                      AppLanguage.themThanhCong.wText(
                        style: AppStyle.s20.copyWith(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              }),
          .2.h.wSpaceHeight(),
          AppButton(
            text: AppLanguage.veTrangChu,
            onPressed: context.back,
          ),
        ],
      ).wCenter(),
    );
  }
}
