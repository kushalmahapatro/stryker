import 'package:stryker/features/patient_tasks/interactor/task_details_interactor.dart';
import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/shared/assets/stryker_assets.dart';
import 'package:stryker/stryker.dart';

Widget taskDetailsView(
    {required BuildContext context, required PatientTasks task}) {
  return Material(
    color: context.colors.background,
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              task.title,
              style: context.textTheme.titleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              task.description,
              style: context.textTheme.titleMedium,
            ),
          ],
        ),
      )),
      Container(
        color: context.colors.onSurfaceVariant.withOpacity(0.2),
        height: 1,
      ),
      const SizedBox(
        height: 10,
      ),
      SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Assigned on",
                        style: context.textTheme.caption!
                            .copyWith(fontWeight: FontWeight.bold)),
                    Text('${task.date} - ${task.time.toLowerCase()}',
                        style: context.textTheme.bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                  ],
                ),
                Image.asset(
                  StrykerAssets.doctor,
                  width: 30,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (task.status == 0)
                  " Mark as In-Progress ".button(context, radius: 10,
                      onTap: () {
                    TaskDetailsInteractor.onChangeStatus(
                        id: task.id, status: 1, context: context);
                  }),
                if (task.status != 2)
                  " Mark as Completed ".button(context, radius: 10, onTap: () {
                    TaskDetailsInteractor.onChangeStatus(
                        id: task.id, status: 2, context: context);
                  })
              ],
            ),
          ],
        ),
      )
    ]).paddingAll(15),
  );
}
