import 'package:stryker/pages/create_task/create_task_desktop.dart';
import 'package:stryker/pages/create_task/create_task_mobile.dart';
import 'package:stryker/stryker.dart';

class CreateTaskPage extends StatelessWidget {
  const CreateTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.isMobile) {
        return const CreateTaskMobile();
      } else {
        return const CreateTaskDesktop();
      }
    });
  }
}
