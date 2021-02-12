import 'package:bloc/bloc.dart';
import 'package:helperr/data_layer/model/resume.dart';

class PortfolioCubit extends Cubit<List<Portfolio>> {
  PortfolioCubit([portfolio = const []]) : super(portfolio);

  void addPortfolio(Portfolio portfolio) {
    emit(List.of(state)..add(portfolio));
  }

  void editPortfolio(Portfolio editedPortfolio, int index) {
    emit(List.of(state)..[index] = editedPortfolio);
  }

  void deletePortfolio(int portfolioIndex) {
    emit(List.of(state)..removeAt(portfolioIndex));
  }
}
