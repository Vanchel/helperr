part of 'response_listing_cubit.dart';

abstract class ResponseListingState extends Equatable {
  const ResponseListingState();

  @override
  List<Object> get props => [];
}

class ResponsesFetchSuccess extends ResponseListingState {
  const ResponsesFetchSuccess({
    this.itemList,
    this.nextPageUri,
  });

  final List<DetailedResponse> itemList;
  final String nextPageUri;

  @override
  String toString() {
    return 'Responses fetch success';
  }

  @override
  List<Object> get props => [itemList, nextPageUri];
}

class ResponsesFetchFailure extends ResponseListingState {
  const ResponsesFetchFailure({this.error});

  final dynamic error;

  @override
  List<Object> get props => [error];
}

class ResponsesFetchInProgress extends ResponseListingState {
  const ResponsesFetchInProgress();
}
