import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repository/profile_images_repository.dart';
import '../../../../data_layer/model/employer.dart';

part 'employer_image_state.dart';

class EmployerImageCubit extends Cubit<ImageState> {
  EmployerImageCubit() : super(ImageInitial());

  Future<void> _wrapper(Future<void> Function() callback) async {
    emit(ImageChangeInProgress());
    try {
      await callback();
      emit(ImageUpdateSuccess());
    } catch (_) {
      emit(ImageUpdateFailure());
    }
  }

  Future<void> updateAvatar(Employer employer, String filePath) async {
    await _wrapper(
      () => ProfileImagesRepository.updateEmployerAvatar(employer, filePath),
    );
  }

  Future<void> updateBackground(Employer employer, String filePath) async {
    await _wrapper(
      () => ProfileImagesRepository.updateEmployerBgImage(employer, filePath),
    );
  }

  Future<void> deleteAvatar(Employer employer) async {
    await _wrapper(
      () => ProfileImagesRepository.deleteEmployerAvatar(employer),
    );
  }

  Future<void> deleteBackground(Employer employer) async {
    await _wrapper(
      () => ProfileImagesRepository.deleteEmployerBgImage(employer),
    );
  }
}
