import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/shared/assets/stryker_assets.dart';
import 'package:stryker/stryker.dart';

class PatientTaskView extends StatelessWidget {
  const PatientTaskView(
      {super.key, required this.status, required this.onTaskClicked});

  final ValueChanged<PatientTasks> onTaskClicked;
  final int status;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context
            .read<PatientTaskBloc>()
            .add(PatientTaskAction(email: pref.get('email').toString()));
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: BlocBuilder<PatientTaskBloc, PatientTaskResult?>(
        builder: ((context, state) {
          if (state != null) {
            List<PatientTasks> tasks = [];
            if (status == 0) {
              tasks = state.pendingTasks ?? [];
            } else if (status == 1) {
              tasks = state.progressTasks ?? [];
            } else if (status == 2) {
              tasks = state.completedTasks ?? [];
            }
            if (tasks.isEmpty) {
              return const Center(child: Text('No tasks'));
            } else {
              return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (BuildContext ctx, int i) {
                    PatientTasks task = tasks[i];
                    if (task.status == status) {
                      String status = '';
                      String statusAsset = '';
                      Widget icon = Container();
                      var color = Colors.blue;

                      switch (task.status) {
                        case 0:
                          status = 'Pending';
                          statusAsset = StrykerAssets.pending;
                          color = Colors.blue;
                          break;

                        case 1:
                          status = 'In Progress';
                          statusAsset = StrykerAssets.progress;
                          color = Colors.yellow;
                          break;

                        case 2:
                          status = 'Completed';
                          statusAsset = StrykerAssets.completed;
                          color = Colors.green;
                          break;
                      }
                      icon = Image.asset(
                        statusAsset,
                        width: 12,
                        height: 12,
                      );
                      return GestureDetector(
                        onTap: () {
                          onTaskClicked(task);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: context.colors.onSurfaceVariant
                                        .withOpacity(0.2)),
                                color: color.withOpacity(0.22),
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
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        task.title,
                                        style: context.textTheme.titleLarge!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                      Image.asset(
                                        StrykerAssets.doctor,
                                        width: 22,
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    task.description,
                                    style: context.textTheme.titleMedium,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Status: ',
                                        style: context.textTheme.caption,
                                      ),
                                      icon,
                                      Text(
                                        ' $status',
                                        style: context.textTheme.caption!
                                            .copyWith(
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
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
                        ),
                      );
                    } else {
                      return Container();
                    }
                  });
            }
          } else {
            return Container();
          }
        }),
      ),
    );
  }
}
