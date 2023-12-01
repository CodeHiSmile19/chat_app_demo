///Khai báo biến
part of 'main_cubit.dart';

class MainState extends Equatable {
  final int selectedIndex;
  final int displayNumber;

  const MainState({
    this.selectedIndex = 0,
    this.displayNumber = 0,
  });

  MainState copyWith({
    int? selectedIndex,
    int? displayNumber,
  }) {
    return MainState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      displayNumber: displayNumber ?? this.displayNumber,
    );
  }

  @override
  List<Object?> get props => [
    selectedIndex,
    displayNumber,
  ];
}
