part of 'navigation_cubit.dart';

@immutable
class NavigationState extends Equatable {
  const NavigationState({this.index = 0});

  final int index;

  @override
  List<Object> get props => [index];
}
