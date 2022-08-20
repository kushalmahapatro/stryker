import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/features/patient_tasks/view/patient_task_view.dart';
import 'package:stryker/patient_pages/dashboard/components/details_widget.dart';
import 'package:stryker/patient_pages/dashboard/interactors/dashboard_interactor.dart';
import 'package:stryker/patient_pages/dashboard/presenter/patient_details_presenter.dart';
import 'package:stryker/stryker.dart';

class PatientDashboardPage extends StatefulWidget {
  const PatientDashboardPage({super.key, this.isPatient = true});

  final bool isPatient;

  @override
  State<PatientDashboardPage> createState() => _PatientDashboardPageState();
}

class _PatientDashboardPageState extends State<PatientDashboardPage>
    with TickerProviderStateMixin {
  late TabController controller;
  @override
  void initState() {
    controller = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PatientDetailsBloc>().add(PatientDetailsAction(
            name: pref.getString('name') ?? '',
            email: pref.getString('email') ?? '',
            profileImage: pref.getString('profileImage') ?? '',
          ));
      Future.delayed(const Duration(milliseconds: 500), () {
        context
            .read<PatientTaskBloc>()
            .add(PatientTaskAction(email: pref.get('email').toString()));
      });
    });

    behaviorSubject.listen((value) {
      if (value.isNotEmpty &&
          value.containsKey('data') &&
          value['data'].toString().isNotEmpty) {
        context.read<PatientTaskBloc>().add(PatientTaskAction(
            email: pref.get('email').toString(),
            id: value['type'] == 1 ? value['data'].toString() : ''));

        context.read<PatientTaskBloc>().stream.listen((event) {
          if (event != null && event.task != null) {
            DashboardInteractors.onTaskClick(context, event.task!);
          }
        });

        behaviorSubject.add({'data': '', 'type': -1});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isPatient ? const PatientDashboardAppbar() : null,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DetailsWidget(),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Tasks:',
            style: context.textTheme.headline5!
                .copyWith(fontWeight: FontWeight.bold),
          ),

          TabBar(
            controller: controller,
            tabs: const [
              Tab(
                text: 'Pending',
              ),
              Tab(
                text: 'In Progress',
              ),
              Tab(
                text: 'Completed',
              )
            ],
          ),
          Container(
            color: context.colors.onSurfaceVariant.withOpacity(0.2),
            height: 1,
          ),
          const SizedBox(
            height: 10,
          ),

          /// Tasks View
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller,
              children: [
                PatientTaskView(
                  status: 0,
                  onTaskClicked: ((task) {
                    DashboardInteractors.onTaskClick(context, task);
                  }),
                ),
                PatientTaskView(
                  status: 1,
                  onTaskClicked: ((task) {
                    DashboardInteractors.onTaskClick(context, task);
                  }),
                ),
                PatientTaskView(
                  status: 2,
                  onTaskClicked: ((task) {
                    DashboardInteractors.onTaskClick(context, task);
                  }),
                )
              ],
            ),
          )
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
