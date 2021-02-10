import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/resume.dart';

import 'worker.dart';

class WorkerInfo extends Equatable {
  WorkerInfo(this.worker, this.resumes);

  final Worker worker;
  final List<Resume> resumes;

  WorkerInfo copyWith({Worker worker, List<Resume> resumes}) =>
      WorkerInfo(worker ?? this.worker, resumes ?? this.resumes);

  @override
  List<Object> get props => [worker, resumes];
}
