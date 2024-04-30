import 'package:bloc/bloc.dart';

import 'add_success_state.dart';

class AddSuccessCubit extends Cubit<AddSuccessState> {
  AddSuccessCubit() : super(AddSuccessState().init());
}
