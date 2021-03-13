import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'vacancy_filter_state.dart';

class VacancyFilterCubit extends Cubit<VacancyFilterState> {
  VacancyFilterCubit() : super(VacancyFilterInitial());
}
