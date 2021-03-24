part of 'resume_listing_cubit.dart';

abstract class ResumeListingState extends Equatable {
  const ResumeListingState();

  @override
  List<Object> get props => [];
}

class ResumesFetchSuccessState extends ResumeListingState {
  const ResumesFetchSuccessState({
    this.itemList,
    this.nextPageUri,
  });

  final List<TruncatedResume> itemList;
  final String nextPageUri;

  @override
  List<Object> get props => [itemList, nextPageUri];
}

class ResumesFetchFailureState extends ResumeListingState {
  const ResumesFetchFailureState({this.error});

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class ResumesFetchInProgressState extends ResumeListingState {
  const ResumesFetchInProgressState();
}
