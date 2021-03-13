import 'package:bloc/bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  selectPage(int tabIndex) => emit(tabIndex);
}
