import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/profile_images_repository.dart';
import '../../../../data_layer/model/worker.dart';

part 'worker_image_state.dart';

class WorkerImageCubit extends Cubit<ImageState> {
  WorkerImageCubit() : super(ImageInitial());

  Future<void> _wrapper(Future<void> Function() callback) async {
    emit(ImageChangeInProgress());
    try {
      await callback();
      emit(ImageUpdateSuccess());
    } catch (_) {
      emit(ImageUpdateFailure());
    }
  }

  Future<void> updateAvatar(Worker worker, String filePath) async {
    await _wrapper(
      () => ProfileImagesRepository.updateWorkerAvatar(worker, filePath),
    );
  }

  Future<void> updateBackground(Worker worker, String filePath) async {
    await _wrapper(
      () => ProfileImagesRepository.updateWorkerBgImage(worker, filePath),
    );
  }

  Future<void> deleteAvatar(Worker worker) async {
    await _wrapper(
      () => ProfileImagesRepository.deleteWorkerAvatar(worker),
    );
  }

  Future<void> deleteBackground(Worker worker) async {
    await _wrapper(
      () => ProfileImagesRepository.deleteWorkerBgImage(worker),
    );
  }
}
