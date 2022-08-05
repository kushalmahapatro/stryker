import 'package:stryker/pages/create_task/create_task_page.dart';
import 'package:stryker/stryker.dart';

enum ScreenName {
  dashboard,
  createTask,
}

extension ScreenNameExtension on ScreenName {
  String get routes => name.toLowerCase();
}

final appRouter = GoRouter(
  routes: [
    /// Dashboard
    GoRoute(
      name: ScreenName.dashboard.routes,
      path: '/',
      builder: (context, state) => const DashboardPage(),
    ),

    GoRoute(
      name: ScreenName.createTask.routes,
      path: '/create/task',
      builder: (context, state) => const CreateTaskPage(),
    ),

    // GoRoute(
    //     name: "route",
    //     path: '/route',
    //     builder: (context, state) {
    //       final pl =
    //           (state.extra as Map<String, dynamic>)['pickupLocation'] as LatLng;
    //       final dl = (state.extra as Map<String, dynamic>)['dropoffLocation']
    //           as LatLng;
    //       final pa =
    //           (state.extra as Map<String, dynamic>)['pickupAddress'].toString();
    //       final da = (state.extra as Map<String, dynamic>)['dropoffAddress']
    //           .toString();
    //       return MultiBlocProvider(
    //         providers: [
    //           BlocProvider.value(value: PreviewMapBloc(context)),
    //           BlocProvider.value(value: BottomBloc(context)),
    //           BlocProvider.value(value: TripBloc(context)),
    //         ],
    //         child: RoutePreviewScreen(
    //             pickupLocation: pl,
    //             dropoffLocation: dl,
    //             pickupAddress: pa,
    //             dropoffAddress: da),
    //       );
    //     })
  ],
);
