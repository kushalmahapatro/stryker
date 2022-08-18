import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/stryker.dart';

class PatientTaskView extends StatelessWidget {
  const PatientTaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<PatientTaskBloc>().add(const PatientTaskAction());
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: BlocBuilder<PatientTaskBloc, PatientTaskResult?>(
        builder: ((context, state) {
          if (state != null) {
            return ListView.builder(
                itemCount: state.tasks?.length ?? 0,
                itemBuilder: (BuildContext ctx, int i) {
                  if ((state.tasks?.length ?? 0) == 0) {
                    return Container();
                  } else {
                    PatientTasks task = state.tasks![i];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: context.colors.onSurfaceVariant
                                    .withOpacity(0.2)),
                            color: context.colors.secondary.withOpacity(0.22),
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(15),
                              topRight: Radius.circular(15),
                              bottomLeft: Radius.circular(15),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: context.textTheme.titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                task.description,
                                style: context.textTheme.titleMedium,
                              )
                            ],
                          ).paddingAll(15),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              task.date,
                              style: context.textTheme.bodyLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              ' - ${task.time.toLowerCase()}',
                              style: context.textTheme.bodyLarge,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }
                });
          }

          return Container();
        }),
      ),
    );
  }
}
