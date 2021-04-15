import '../../../data_layer/model/worker.dart';
import '../../../data_layer/model/employer.dart';

import 'package:helperr/data_layer/data_provider/regular_api_client.dart';

class EditProfileRepository {
  static Future<void> saveWorkerProfile(Worker worker) async {
    await RegularApiClient.updateWorker(worker);
  }

  static Future<void> saveEmployerProfile(Employer employer) async {
    await RegularApiClient.updateEmployer(employer);
  }
}
