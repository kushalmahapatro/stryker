import 'dart:math';

import 'package:stryker/doctor_pages/dashboard/interactors/dashboard_interactors.dart';
import 'package:stryker/shared/assets/stryker_assets.dart';
import 'package:stryker/stryker.dart';

class DashboardAppBar extends StatelessWidget with PreferredSizeWidget {
  final bool isDesktop;
  final String email;
  const DashboardAppBar(
      {super.key, this.isDesktop = false, required this.email});

  @override
  Widget build(BuildContext context) {
    List<Widget> actions = [];
    if (isDesktop) {
      actions.add("Create Task".button(context, onTap: () {
        DashboardInteractors.createTaskClick(context, email);
      }));
    }

    return AppBar(
      title: StrykerAssets.logo.assetImage(width: 100).paddingAll(10),
      centerTitle: !isDesktop,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
