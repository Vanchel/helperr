part of 'favorite_cubit.dart';

class FavoriteState extends Equatable {
  const FavoriteState(this.isInFavorite, this.error);

  final bool isInFavorite;
  final dynamic error;

  @override
  List<Object> get props => [isInFavorite, error];
}
