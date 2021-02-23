import 'package:equatable/equatable.dart';
import 'package:helperr/data_layer/model/resume.dart';

import 'worker.dart';

class WorkerInfo extends Equatable {
  WorkerInfo(this.worker, this.resumes, this.avatarUrl, this.bgUrl);

  final Worker worker;
  final List<Resume> resumes;

  final String avatarUrl;
  final String bgUrl;

  WorkerInfo copyWith({
    Worker worker,
    List<Resume> resumes,
    String avatarUrl,
    String bgUrl,
  }) =>
      WorkerInfo(
        worker ?? this.worker,
        resumes ?? this.resumes,
        avatarUrl ?? this.avatarUrl,
        bgUrl ?? this.bgUrl,
      );

  @override
  List<Object> get props => [worker, resumes, avatarUrl, bgUrl];
}
