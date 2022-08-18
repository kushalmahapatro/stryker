import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/features/patient_tasks/view/patient_task_view.dart';
import 'package:stryker/patient_pages/dashboard/components/details_widget.dart';
import 'package:stryker/patient_pages/dashboard/interactors/dashboard_interactor.dart';
import 'package:stryker/patient_pages/dashboard/presenter/patient_details_presenter.dart';
import 'package:stryker/stryker.dart';

class PatientDashboardPage extends StatefulWidget {
  const PatientDashboardPage({Key? key}) : super(key: key);

  @override
  State<PatientDashboardPage> createState() => _PatientDashboardPageState();
}

class _PatientDashboardPageState extends State<PatientDashboardPage> {
  @override
  void initState() {
    context
      ..read<PatientDetailsBloc>().add(const PatientDetailsAction())
      ..read<PatientTaskBloc>().add(const PatientTaskAction());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PatientDashboardAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailsWidget(),
          Text(
            'Tasks:',
            style: context.textTheme.headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ).paddingSymmetric(vertical: 15),
          const Expanded(child: PatientTaskView())
        ],
      ).paddingSymmetric(
        horizontal: 15,
        vertical: 10,
      ),
    );
  }
}

class PatientDashboardAppbar extends StatelessWidget with PreferredSizeWidget {
  const PatientDashboardAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(actions: [
      InkWell(
        onTap: () => DashboardInteractors.logoutClick(context),
        child: Text(
          'Logout',
          style: context.textTheme.titleMedium!
              .copyWith(color: context.colors.primary),
        ).paddingAll(10),
      )
    ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
