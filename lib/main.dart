import 'package:dynamic_color/dynamic_color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:stryker/firebase_options.dart';
import 'package:stryker/shared/patient_router.dart';
import 'package:stryker/shared/router.dart';
import 'package:stryker/stryker.dart';

void main() async {
  // turn off the # in the URLs on the web
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.setUrlPathStrategy(UrlPathStrategy.path);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final settings = ValueNotifier(ThemeSettings(
      darkColorScheme: darkColorScheme,
      lightColorScheme: lightColorScheme,
      themeMode: ThemeMode.light,
    ));
    GoRouter router =
        const String.fromEnvironment('TYPE', defaultValue: "doctor") == "doctor"
            ? doctorRouter
            : patientRouter;

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) => ThemeProvider(
          lightDynamic: settings.value.lightColorScheme,
          darkDynamic: settings.value.darkColorScheme,
          settings: settings,
          child: NotificationListener<ThemeSettingChange>(
            onNotification: (notification) {
              settings.value = notification.settings;
              return true;
            },
            child: ValueListenableBuilder<ThemeSettings>(
              valueListenable: settings,
              builder: (context, value, _) {
                final theme = ThemeProvider.of(context);
                return MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: theme.light(),
                  darkTheme: theme.dark(),
                  themeMode: theme.themeMode(),
                  routeInformationParser: router.routeInformationParser,
                  routerDelegate: router.routerDelegate,
                );
              },
            ),
          )),
    );
  }
}
