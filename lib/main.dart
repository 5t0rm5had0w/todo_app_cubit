import 'package:overlay_support/overlay_support.dart';

import 'exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtils.initInstance();
  await initLocator();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final alice = Alice(showNotification: _checkDebug(), navigatorKey: navigatorKey);

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => locator<TodoCubit>()),
        BlocProvider(create: (context) => locator<WeatherCubit>()),
      ],
      child: OverlaySupport.global(
        child: MaterialApp(
          navigatorKey: MyApp.navigatorKey,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: false,
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}

bool _checkDebug() {
  return true;
}
