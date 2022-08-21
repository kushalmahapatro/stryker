import 'package:fl_chart/fl_chart.dart';
import 'package:stryker/doctor_pages/dashboard/components/dashboard_appbar.dart';
import 'package:stryker/features/patient_tasks/presenter/patient_task_presenter.dart';
import 'package:stryker/patient_pages/dashboard/presenter/patient_details_presenter.dart';
import 'package:stryker/stryker.dart';

final Stream<QuerySnapshot> patientStream =
    FirebaseFirestore.instance.collection('patients').snapshots();

final Stream<QuerySnapshot> tasksStream =
    FirebaseFirestore.instance.collection('tasks').snapshots();

class DashboardDesktop extends StatefulWidget {
  const DashboardDesktop({Key? key}) : super(key: key);

  @override
  State<DashboardDesktop> createState() => _DashboardDesktopState();
}

class _DashboardDesktopState extends State<DashboardDesktop> {
  String selectedEmail = '';
  @override
  void initState() {
    tasksStream.listen((event) {
      if (event.docChanges.length != event.docs.length) {
        for (var element in event.docChanges) {
          var status = (element.doc.data() as Map)['status'];
          String email = (element.doc.data() as Map)['patient'].toString();
          String title = (element.doc.data() as Map)['title'].toString();
          if (status == 1) {
            '$email marked $title as In Progress'.showSnackBar(context);
          } else if (status == 2) {
            '$email marked $title as Completed'.showSnackBar(context);
          }
        }

        context.read<PatientTaskBloc>().add(PatientTaskAction(
              email: selectedEmail,
            ));
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(
        isDesktop: true,
        email: selectedEmail,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome Doctor',
              style:
                  context.displaySmall!.copyWith(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    flex: 7,
                    child: StreamBuilder(
                      stream: tasksStream,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return Container();
                        }
                        List<String> status = snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return data['status'].toString();
                        }).toList();

                        int total = status.length;
                        if (total > 0) {
                          int pending = status
                              .map((element) => element == "0" ? 1 : 0)
                              .reduce((value, element) => value + element);
                          int progress = status
                              .map((element) => element == "1" ? 1 : 0)
                              .reduce((value, element) => value + element);
                          int completed = status
                              .map((element) => element == "2" ? 1 : 0)
                              .reduce((value, element) => value + element);

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Tasks Details:",
                                style: context.titleLarge!
                                    .copyWith(fontWeight: FontWeight.bold),
                              ).paddingSymmetric(horizontal: 20),
                              const SizedBox(
                                height: 10,
                              ),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.start,
                                runSpacing: 15,
                                spacing: 15,
                                children: [
                                  Text(
                                    "Total created: $total",
                                    style: context.titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Pending: $pending",
                                    style: context.titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "In Progress: $progress",
                                    style: context.titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "Completed: $completed",
                                    style: context.titleMedium!
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ).paddingSymmetric(horizontal: 20),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: PieChart(
                                  PieChartData(
                                      pieTouchData: PieTouchData(
                                        enabled: true,
                                      ),
                                      sections: [
                                        PieChartSectionData(
                                            titleStyle: context.titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            title: "Pending",
                                            showTitle: true,
                                            color: Colors.blue,
                                            value: double.parse(
                                                pending.toString())),
                                        PieChartSectionData(
                                            titleStyle: context.titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            title: "In Progress",
                                            showTitle: true,
                                            color: Colors.yellow,
                                            value: double.parse(
                                                progress.toString())),
                                        PieChartSectionData(
                                            titleStyle: context.titleMedium!
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.bold),
                                            title: "Completed",
                                            showTitle: true,
                                            color: Colors.green,
                                            value: double.parse(
                                                completed.toString())),
                                      ]),
                                  swapAnimationDuration: const Duration(
                                      milliseconds: 150), // Optional
                                  swapAnimationCurve: Curves.linear, // Optional
                                ).paddingAll(50),
                              ),
                            ],
                          );
                        } else {
                          return Center(child: Text("No data"));
                        }
                      },
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Column(
                      children: [
                        StreamBuilder<QuerySnapshot>(
                            stream: patientStream,
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasData) {
                                List<String> patients = snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  Map<String, dynamic> data =
                                      document.data()! as Map<String, dynamic>;
                                  return data['email'].toString();
                                }).toList();

                                return Autocomplete<String>(
                                  fieldViewBuilder: (context,
                                          textEditingController,
                                          focusNode,
                                          onFieldSubmitted) =>
                                      TextField(
                                    controller: textEditingController,
                                    focusNode: focusNode,
                                    onEditingComplete: onFieldSubmitted,
                                    decoration: const InputDecoration(
                                      hintText: 'Search for a patient',
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                  optionsBuilder:
                                      (TextEditingValue textEditingValue) {
                                    if (textEditingValue.text == '') {
                                      return const Iterable<String>.empty();
                                    }
                                    return patients.where((String option) {
                                      return option.toLowerCase().contains(
                                          textEditingValue.text.toLowerCase());
                                    });
                                  },
                                  onSelected: (String selection) {
                                    Map data = {};
                                    for (var e in snapshot.data!.docs) {
                                      if ((e.data() as Map)['email']
                                              .toString() ==
                                          selection.trim()) {
                                        data = (e.data() as Map);
                                      }
                                    }

                                    context
                                        .read<PatientDetailsBloc>()
                                        .add(PatientDetailsAction(
                                          name: data['name'] ?? '',
                                          email: data['email'] ?? '',
                                          profileImage:
                                              data['profileImage'] ?? '',
                                        ));

                                    context
                                        .read<PatientTaskBloc>()
                                        .add(PatientTaskAction(
                                          email: data['email'] ?? '',
                                        ));

                                    selectedEmail = selection;

                                    setState(() {});
                                  },
                                );
                              }
                              return Container();
                            }),
                        const Expanded(
                          child: PatientDashboardPage(
                            isPatient: false,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
