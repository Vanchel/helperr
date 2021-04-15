abstract class FavoriteRepository {
  Future<void> favoriteAdd(int id);

  Future<void> favoriteRemove(int id);
}
