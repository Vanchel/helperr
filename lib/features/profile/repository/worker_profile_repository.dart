import 'package:helperr/data_layer/model/worker_info.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

class WokerProfileRepository {
  static Future<WorkerInfo> getWorkerInfo(int userId) async {
    final worker = await server.fetchWorker(userId);
    final resumes = await server.fetchResumes(userId);

    final workerInfo = WorkerInfo(worker, resumes);
    return workerInfo;
  }
}
