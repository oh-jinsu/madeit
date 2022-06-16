import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:madeit/application/effects/env.dart';
import 'package:madeit/application/effects/firebase.dart';
import 'package:madeit/application/effects/prefetch_rooms.dart';
import 'package:madeit/application/effects/provider.dart';
import 'package:madeit/application/effects/splash_waiter.dart';
import 'package:madeit/application/effects/ws.dart';
import 'package:madeit/application/events/app_started.dart';
import 'package:madeit/application/reducers/list_of_room.dart';
import 'package:madeit/composition/my_room_list/page.dart';
import 'package:madeit/composition/profile/page.dart';
import 'package:madeit/composition/room/page.dart';
import 'package:madeit/composition/room_exploration/page.dart';
import 'package:madeit/composition/room_notification_list/page.dart';
import 'package:madeit/composition/room_photolog_list/page.dart';
import 'package:madeit/composition/room_preview/page.dart';
import 'package:madeit/composition/splash/page.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/core/effect.dart';
import 'package:madeit/core/store.dart';

void main() => runApp(const Application());

final _globalKey = GlobalKey<NavigatorState>();

BuildContext get requireContext => _globalKey.currentContext!;

NavigatorState get currentState => _globalKey.currentState!;

Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
  if (settings.name == "/splash") {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondAnimation) => const SplashPage(),
    );
  }

  if (settings.name == "/home") {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondAnimation) =>
          const RoomExplorationPage(),
    );
  }

  if (settings.name == "/room/preview") {
    return MaterialPageRoute(builder: (context) => const RoomPreviewPage());
  }

  if (settings.name == "/room") {
    return MaterialPageRoute(builder: (context) => const RoomPage());
  }

  if (settings.name == "/room/photolog") {
    return MaterialPageRoute(
        builder: (context) => const RoomPhotologListPage());
  }

  if (settings.name == "/room/notification") {
    return MaterialPageRoute(
        builder: (context) => const RoomNotificationListPage());
  }

  if (settings.name == "/room/mine") {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondAnimation) =>
          const MyRoomListPage(),
    );
  }

  if (settings.name == "/profile") {
    return PageRouteBuilder(
      settings: settings,
      transitionDuration: Duration.zero,
      pageBuilder: (context, animation, secondAnimation) => const ProfilePage(),
    );
  }

  return null;
}

Widget _builder(BuildContext context, Widget? child) {
  return MediaQuery(
    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
    child: child!,
  );
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    initializeChannel();

    touchStore(listOfRoomStore);

    useEffect(envEffect);
    useEffect(firebaseEffect);
    useEffect(providerEffect);
    useEffect(wsEffect);
    useEffect(prefetchRoomsEffect);
    useEffect(splashWaiterEffect);

    dispatch(const AppStarted());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _globalKey,
      initialRoute: "/splash",
      onGenerateRoute: _onGenerateRoute,
      builder: _builder,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xff00c8a2),
          secondary: Color(0xff00c8a2),
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          error: Color(0xffc80025),
        ),
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: false,
          shape: Border(
            bottom: BorderSide(color: Colors.grey[200]!),
          ),
          titleTextStyle:
              const TextStyle(color: Colors.black, fontSize: 18.0, height: 1.3),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: const EdgeInsets.all(0.0),
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ).merge(
            ButtonStyle(
              elevation: MaterialStateProperty.resolveWith((states) => 0.0),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: Colors.grey[200],
          space: 0.0,
          thickness: 1.0,
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
