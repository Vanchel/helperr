import 'package:helperr/data_layer/model/worker_info.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;
import 'package:helperr/data_layer/data_provider/firebase_server.dart'
    as fb_server;

class WokerProfileRepository {
  static Future<WorkerInfo> getWorkerInfo(int userId) async {
    final res = await Future.wait([
      server.fetchWorker(userId),
      server.fetchResumes(userId),
      fb_server.getAvatarUrl(userId),
      fb_server.getBackgroundUrl(userId),
    ]);

    return WorkerInfo(res[0], res[1], res[2], res[3]);

    // final worker = await server.fetchWorker(userId);
    // final resumes = await server.fetchResumes(userId);

    // final avatarUrl = await fb_server.getAvatarUrl(userId);
    // final bgUrl = await fb_server.getBackgroundUrl(userId);

    // final workerInfo = WorkerInfo(worker, resumes, avatarUrl, bgUrl);
    // return workerInfo;
  }
}
