import 'package:stryker/shared/router.dart';
import 'package:stryker/stryker.dart';

class DashboardInteractors {
  static void createTaskClick(BuildContext context) {
    context.pushNamed(ScreenName.createTask.routes);
  }
}
