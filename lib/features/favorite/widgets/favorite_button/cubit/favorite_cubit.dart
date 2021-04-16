import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../repository/favorite_repository.dart';

part 'favorite_state.dart';

class FavoriteCubit extends Cubit<FavoriteState> {
  FavoriteCubit({
    this.id,
    this.repository,
    bool isInFavorite,
  }) : super(FavoriteState(isInFavorite, null));

  final int id;
  final FavoriteRepository repository;

  Future<void> changeState() async {
    try {
      if (state.isInFavorite) {
        await repository.favoriteRemove(id);
        emit(const FavoriteState(false, null));
      } else {
        await repository.favoriteAdd(id);
        emit(const FavoriteState(true, null));
      }
    } catch (e) {
      emit(FavoriteState(state.isInFavorite, e));
    }
  }
}
