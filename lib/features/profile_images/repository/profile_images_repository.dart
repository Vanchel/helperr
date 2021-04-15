import '../../../data_layer/model/worker.dart';
import '../../../data_layer/model/employer.dart';

import 'package:helperr/data_layer/data_provider/regular_api_client.dart';
import 'package:helperr/data_layer/data_provider/firebase_api_client.dart'
    as fb_server;

class ProfileImagesRepository {
  static Future<void> updateWorkerAvatar(Worker worker, String filePath) async {
    final newPhotoUrl =
        await fb_server.updateProfileAvatarImage(worker.userId, filePath);

    await RegularApiClient.updateWorker(worker.copyWith(
      photoUrl: newPhotoUrl,
    ));
  }

  static Future<void> updateWorkerBgImage(
      Worker worker, String filePath) async {
    final newProfileBg =
        await fb_server.updateProfileBackgroundImage(worker.userId, filePath);

    await RegularApiClient.updateWorker(worker.copyWith(
      profileBackground: newProfileBg,
    ));
  }

  static Future<void> updateEmployerAvatar(
      Employer employer, String filePath) async {
    final newPhotoUrl =
        await fb_server.updateProfileAvatarImage(employer.userId, filePath);

    await RegularApiClient.updateEmployer(employer.copyWith(
      photoUrl: newPhotoUrl,
    ));
  }

  static Future<void> updateEmployerBgImage(
      Employer employer, String filePath) async {
    final newProfileBg =
        await fb_server.updateProfileBackgroundImage(employer.userId, filePath);

    await RegularApiClient.updateEmployer(employer.copyWith(
      profileBackground: newProfileBg,
    ));
  }

  static Future<void> deleteWorkerAvatar(Worker worker) async {
    await RegularApiClient.updateWorker(worker.copyWith(photoUrl: ''));
    await fb_server.deleteProfileAvatarImage(worker.userId);
  }

  static Future<void> deleteWorkerBgImage(Worker worker) async {
    await RegularApiClient.updateWorker(worker.copyWith(profileBackground: ''));
    await fb_server.deleteProfileBackgroundImage(worker.userId);
  }

  static Future<void> deleteEmployerAvatar(Employer employer) async {
    await RegularApiClient.updateEmployer(employer.copyWith(photoUrl: ''));
    await fb_server.deleteProfileAvatarImage(employer.userId);
  }

  static Future<void> deleteEmployerBgImage(Employer employer) async {
    await RegularApiClient.updateEmployer(
        employer.copyWith(profileBackground: ''));
    await fb_server.deleteProfileBackgroundImage(employer.userId);
  }
}
