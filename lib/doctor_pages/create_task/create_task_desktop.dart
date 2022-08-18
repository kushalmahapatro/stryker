import 'package:stryker/doctor_pages/create_task/components/create_task_appbar.dart';
import 'package:stryker/doctor_pages/create_task/interactors/create_task_interactors.dart';
import 'package:stryker/stryker.dart';

class CreateTaskDesktop extends StatefulWidget {
  const CreateTaskDesktop({Key? key}) : super(key: key);

  @override
  State<CreateTaskDesktop> createState() => _CreateTaskDesktopState();
}

class _CreateTaskDesktopState extends State<CreateTaskDesktop> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  final Stream<QuerySnapshot> _patientStream =
      FirebaseFirestore.instance.collection('patients').snapshots();

  String selectedPatient = '';

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CreateTaskAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Create a task',
                style:
                    context.displaySmall!.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: _patientStream,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text('Something went wrong');
                        }

                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Text("Loading");
                        }

                        if (snapshot.hasData) {
                          List<String> patients = snapshot.data!.docs
                              .map((DocumentSnapshot document) {
                            Map<String, dynamic> data =
                                document.data()! as Map<String, dynamic>;
                            return data['email'].toString();
                          }).toList();

                          return Autocomplete<String>(
                            fieldViewBuilder: (context, textEditingController,
                                    focusNode, onFieldSubmitted) =>
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
                              selectedPatient = selection;
                            },
                          );
                        }
                        return Container();
                      }),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 300,
                    child: TextField(
                      maxLines: 500,
                      controller: _descriptionController,
                      decoration: const InputDecoration(
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Spacer(),
                      'Save'.button(context, onTap: () {
                        CreateTaskInteractors.saveTask(
                          context,
                          _titleController.text,
                          _descriptionController.text,
                          selectedPatient,
                        );
                      })
                    ],
                  ),
                ],
              ).paddingSymmetric(horizontal: 20)
            ],
          ),
        ),
      ),
    );
  }
}
