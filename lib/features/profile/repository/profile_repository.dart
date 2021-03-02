import 'package:helperr/data_layer/model/employer_info.dart';
import 'package:helperr/data_layer/model/worker_info.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;
import 'package:helperr/data_layer/data_provider/firebase_server.dart'
    as fb_server;

class ProfileRepository {
  static Future<WorkerInfo> getWorkerInfo(int userId) async {
    final res = await Future.wait([
      server.fetchWorker(userId),
      server.fetchResumes(userId),
      fb_server.getAvatarUrl(userId),
      fb_server.getBackgroundUrl(userId),
    ]);

    return WorkerInfo(res[0], res[1], res[2], res[3]);
  }

  static Future<EmployerInfo> getEmployerInfo(int userId) async {
    final res = await Future.wait([
      server.fetchEmployer(userId),
      server.fetchVacancies(userId),
      fb_server.getAvatarUrl(userId),
      fb_server.getBackgroundUrl(userId),
    ]);

    return EmployerInfo(res[0], res[1], res[2], res[3]);
  }
}
