import 'package:stryker/pages/dashboard/interactors/dashboard_interactors.dart';
import 'package:stryker/stryker.dart';

class DashboardAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool isDesktop;
  const DashboardAppBar({super.key, this.isDesktop = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        "assets/images/logo.png",
        width: 100,
      ).paddingAll(10),
      centerTitle: !isDesktop,
      actions: isDesktop
          ? [
              "Create Task".button(context, onTap: () {
                DashboardInteractors.createTaskClick(context);
              })
            ]
          : [],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
