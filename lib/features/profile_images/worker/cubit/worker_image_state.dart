part of 'worker_image_cubit.dart';

abstract class ImageState extends Equatable {
  const ImageState();

  @override
  List<Object> get props => [];
}

class ImageInitial extends ImageState {}

class ImageChangeInProgress extends ImageState {}

class ImageUpdateSuccess extends ImageState {}

class ImageUpdateFailure extends ImageState {}

class ImageDeleteSuccess extends ImageState {}

class ImageDeleteFailure extends ImageState {}
