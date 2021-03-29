import 'package:helperr/data_layer/model/employer_info.dart';
import 'package:helperr/data_layer/model/worker_info.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

class ProfileRepository {
  static Future<WorkerInfo> getWorkerInfo(int userId) async {
    final res = await Future.wait([
      server.fetchWorker(userId),
      server.fetchResumes(userId),
    ]);

    return WorkerInfo(res[0], res[1]);
  }

  static Future<EmployerInfo> getEmployerInfo(int userId) async {
    final res = await Future.wait([
      server.fetchEmployer(userId),
      server.fetchVacancies(userId),
    ]);

    return EmployerInfo(res[0], res[1]);
  }
}
