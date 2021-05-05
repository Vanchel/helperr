import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/widgets/error_screen/error_indicator.dart';

import 'package:helperr/widgets/loading_screen.dart';

import '../cubit/loading_cubit.dart';

class LoadingPage<T> extends StatelessWidget {
  const LoadingPage({
    Key key,
    @required this.callback,
    @required this.builder,
  }) : super(key: key);

  final Future<T> Function() callback;
  final Widget Function(BuildContext context, T value) builder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoadingCubit(callback: callback),
      child: BlocBuilder<LoadingCubit<T>, LoadingState<T>>(
        builder: (context, state) {
          if (state is LoadFailure<T>) {
            return ErrorIndicator(onTryAgain: callback, error: state.error);
          } else if (state is LoadSuccess<T>) {
            return builder(context, state.value);
          } else {
            return const LoadingScreen();
          }
        },
      ),
    );
  }
}
