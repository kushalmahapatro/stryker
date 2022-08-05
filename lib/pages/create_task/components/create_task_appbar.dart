import 'package:stryker/pages/create_task/interactors/create_task_interactors.dart';
import 'package:stryker/stryker.dart';

class CreateTaskAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool isDesktop;
  const CreateTaskAppBar({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          CreateTaskInteractors.backClick(context);
        },
        child: Icon(
          Icons.chevron_left,
          size: isDesktop ? 40 : 30,
        ),
      ),
      actions: isDesktop ? ["Create Task".button(context, onTap: () {})] : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
