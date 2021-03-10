import 'package:bloc/bloc.dart';

import '../../../../../data_layer/model/work_type.dart';

class WorkTypeCubit extends Cubit<Set<WorkType>> {
  WorkTypeCubit(Set<WorkType> initialValue) : super(initialValue);

  void addValue(WorkType value) => emit(Set.of(state)..add(value));

  void deleteValue(WorkType value) => emit(Set.of(state)..remove(value));
}
