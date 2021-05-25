part of 'card_actions_cubit.dart';

class CardActionsState extends Equatable {
  const CardActionsState({this.favorited = false, this.responded = false});

  final bool responded;
  final bool favorited;

  @override
  List<Object> get props => [responded, favorited];

  @override
  String toString() {
    return 'CardActionState(responded: $responded, favorited: $favorited)';
  }
}
