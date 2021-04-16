part of 'favorite_resumes_cubit.dart';

abstract class FavoriteResumesState extends Equatable {
  const FavoriteResumesState();

  @override
  List<Object> get props => [];
}

class ResumesFetchSuccessState extends FavoriteResumesState {
  const ResumesFetchSuccessState({
    this.itemList,
    this.nextPageUri,
  });

  final List<TruncatedResume> itemList;
  final String nextPageUri;

  @override
  String toString() {
    return 'Favorite resumes fetch success';
  }

  @override
  List<Object> get props => [itemList, nextPageUri];
}

class ResumesFetchFailureState extends FavoriteResumesState {
  const ResumesFetchFailureState({this.error});

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class ResumesFetchInProgressState extends FavoriteResumesState {
  const ResumesFetchInProgressState();
}
