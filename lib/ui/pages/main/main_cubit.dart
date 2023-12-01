import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///Viết logic
part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(const MainState());

  void changeTab(int index) {
    emit(state.copyWith(
      selectedIndex: index,
    ));
  }

  void increase() {
    emit(state.copyWith(
      displayNumber: state.displayNumber +1,
    ));
  }
}
