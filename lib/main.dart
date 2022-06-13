import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:madeit/application/effects/env.dart';
import 'package:madeit/application/effects/prefetch_rooms.dart';
import 'package:madeit/application/effects/provider.dart';
import 'package:madeit/application/effects/splash_waiter.dart';
import 'package:madeit/application/effects/ws.dart';
import 'package:madeit/application/events/app_started.dart';
import 'package:madeit/application/reducers/list_of_room.dart';
import 'package:madeit/composition/home/page.dart';
import 'package:madeit/composition/splash/page.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/core/effect.dart';
import 'package:madeit/core/store.dart';

void main() => runApp(const Application());

final _globalKey = GlobalKey<NavigatorState>();

BuildContext get requireContext => _globalKey.currentContext!;

NavigatorState get currentState => _globalKey.currentState!;

class Application extends StatelessWidget {
  const Application({Key? key}) : super(key: key);

  static Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    if (settings.name == "/splash") {
      return PageRouteBuilder(
        settings: settings,
        transitionDuration: Duration.zero,
        pageBuilder: (context, animation, secondAnimation) =>
            const SplashPage(),
      );
    }

    if (settings.name == "/home") {
      return MaterialPageRoute(builder: (context) => const HomePage());
    }

    return null;
  }

  static Widget _builder(BuildContext context, Widget? child) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: child!,
    );
  }

  @override
  Widget build(BuildContext context) {
    useStore(listOfRoomStore);

    useEffect(envEffect);
    useEffect(providerEffect);
    useEffect(wsEffect);
    useEffect(prefetchRoomsEffect);
    useEffect(splashWaiterEffect);

    dispatch(const AppStarted());

    return MaterialApp(
      navigatorKey: _globalKey,
      initialRoute: "/splash",
      onGenerateRoute: _onGenerateRoute,
      builder: _builder,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ko'),
        Locale('en'),
      ],
    );
  }
}
