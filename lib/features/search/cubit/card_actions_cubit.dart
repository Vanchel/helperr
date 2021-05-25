import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'card_actions_state.dart';

class CardActionsCubit extends Cubit<CardActionsState> {
  CardActionsCubit({@required bool responded, @required bool favorited})
      : super(CardActionsState(responded: responded, favorited: favorited));

  void respond() {
    final newState = CardActionsState(
      responded: true,
      favorited: state.favorited,
    );
    emit(newState);
  }

  void changeFavorited(bool isFavorited) {
    final newState = CardActionsState(
      responded: state.responded,
      favorited: isFavorited ?? false,
    );
    emit(newState);
  }
}
