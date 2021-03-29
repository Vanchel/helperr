import '../../../data_layer/model/worker.dart';
import '../../../data_layer/model/employer.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;
import 'package:helperr/data_layer/data_provider/firebase_server.dart'
    as fb_server;

class ProfileImagesRepository {
  static Future<void> updateWorkerAvatar(Worker worker, String filePath) async {
    final newPhotoUrl =
        await fb_server.updateProfileAvatarImage(worker.userId, filePath);

    await server.updateWorker(worker.copyWith(
      photoUrl: newPhotoUrl,
    ));
  }

  static Future<void> updateWorkerBgImage(
      Worker worker, String filePath) async {
    final newProfileBg =
        await fb_server.updateProfileBackgroundImage(worker.userId, filePath);

    await server.updateWorker(worker.copyWith(
      profileBackground: newProfileBg,
    ));
  }

  static Future<void> updateEmployerAvatar(
      Employer employer, String filePath) async {
    final newPhotoUrl =
        await fb_server.updateProfileAvatarImage(employer.userId, filePath);

    await server.updateEmployer(employer.copyWith(
      photoUrl: newPhotoUrl,
    ));
  }

  static Future<void> updateEmployerBgImage(
      Employer employer, String filePath) async {
    final newProfileBg =
        await fb_server.updateProfileBackgroundImage(employer.userId, filePath);

    await server.updateEmployer(employer.copyWith(
      profileBackground: newProfileBg,
    ));
  }

  static Future<void> deleteWorkerAvatar(Worker worker) async {
    await fb_server.deleteProfileAvatarImage(worker.userId);
    await server.updateWorker(worker.copyWith(photoUrl: ''));
  }

  static Future<void> deleteWorkerBgImage(Worker worker) async {
    await fb_server.deleteProfileBackgroundImage(worker.userId);
    await server.updateWorker(worker.copyWith(profileBackground: ''));
  }

  static Future<void> deleteEmployerAvatar(Employer employer) async {
    await fb_server.deleteProfileAvatarImage(employer.userId);
    await server.updateEmployer(employer.copyWith(photoUrl: ''));
  }

  static Future<void> deleteEmployerBgImage(Employer employer) async {
    await fb_server.deleteProfileBackgroundImage(employer.userId);
    await server.updateEmployer(employer.copyWith(profileBackground: ''));
  }
}
