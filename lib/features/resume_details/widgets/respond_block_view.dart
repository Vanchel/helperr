import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helperr/data_layer/model/resume.dart';
import 'package:helperr/features/response/cubit/responded_cubit.dart';
import 'package:helperr/features/response/employer/view/employer_response_loading_page.dart';

class RespondBlockView extends StatelessWidget {
  const RespondBlockView({
    Key key,
    this.resume,
  }) : super(key: key);

  final Resume resume;

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
            child: Text('Пригласить'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmployerResponsePage(
                    onSave: () => context.read<RespondedCubit>().respond(),
                    resumeId: resume.id,
                    workerId: resume.userId,
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
