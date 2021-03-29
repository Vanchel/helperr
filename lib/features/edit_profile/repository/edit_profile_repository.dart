import '../../../data_layer/model/worker.dart';
import '../../../data_layer/model/employer.dart';

import 'package:helperr/data_layer/data_provider/helperr_server.dart' as server;

class EditProfileRepository {
  static Future<void> saveWorkerProfile(Worker worker) async {
    await server.updateWorker(worker);
  }

  static Future<void> saveEmployerProfile(Employer employer) async {
    await server.updateEmployer(employer);
  }
}
