import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/vacancy.dart';
import 'package:helperr/features/response/cubit/responded_cubit.dart';
import 'package:helperr/features/response/worker/view/worker_response_loading_page.dart';

class RespondBlockView extends StatelessWidget {
  const RespondBlockView({
    Key key,
    this.vacancy,
    this.onResponded,
  }) : super(key: key);

  final Vacancy vacancy;
  final VoidCallback onResponded;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<RespondedCubit, bool>(
      builder: (context, state) {
        if (state) {
          return Text(
            'Обмен откликами уже был начат.',
            style: textTheme.caption,
          );
        } else {
          return ElevatedButton(
            child: Text('Откликнуться'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => WorkerResponsePage(
                    onSave: () {
                      context.read<RespondedCubit>().respond();
                      if (onResponded != null) {
                        onResponded.call();
                      }
                    },
                    vacancyId: vacancy.id,
                    employerId: vacancy.userId,
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
