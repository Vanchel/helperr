import 'package:helperr/data_layer/model/employer_info.dart';
import 'package:helperr/data_layer/model/worker_info.dart';

import 'package:helperr/data_layer/data_provider/regular_api_client.dart';

class ProfileRepository {
  static Future<WorkerInfo> getWorkerInfo(int userId) async {
    final res = await Future.wait([
      RegularApiClient.fetchWorker(userId),
      RegularApiClient.fetchResumes(userId),
    ]);

    return WorkerInfo(res[0], res[1]);
  }

  static Future<EmployerInfo> getEmployerInfo(int userId) async {
    final res = await Future.wait([
      RegularApiClient.fetchEmployer(userId),
      RegularApiClient.fetchVacancies(userId),
    ]);

    return EmployerInfo(res[0], res[1]);
  }
}
