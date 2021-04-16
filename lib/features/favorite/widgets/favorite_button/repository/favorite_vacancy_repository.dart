import 'favorite_repository.dart';
import '../../../../../data_layer/data_provider/regular_api_client.dart';

class FavoriteVacancyRepository implements FavoriteRepository {
  @override
  Future<void> favoriteAdd(int id) async {
    await RegularApiClient.addFavoriteVacancy(id);
  }

  @override
  Future<void> favoriteRemove(int id) async {
    await RegularApiClient.deleteFavoriteVacancy(id);
  }
}
