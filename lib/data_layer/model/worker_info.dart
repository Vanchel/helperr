import 'package:equatable/equatable.dart';

import 'worker.dart';
import 'resume.dart';

class WorkerInfo extends Equatable {
  WorkerInfo(this.worker, this.resumes);

  final Worker worker;
  final List<Resume> resumes;

  WorkerInfo copyWith({
    Worker worker,
    List<Resume> resumes,
  }) =>
      WorkerInfo(
        worker ?? this.worker,
        resumes ?? this.resumes,
      );

  @override
  List<Object> get props => [worker, resumes];

  @override
  String toString() => 'Worker info for id ${worker.userId}';
}
