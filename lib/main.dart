import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:madeit/application/effects/env.dart';
import 'package:madeit/application/effects/provider.dart';
import 'package:madeit/application/effects/ws.dart';
import 'package:madeit/application/events/app_started.dart';
import 'package:madeit/composition/splash/page.dart';
import 'package:madeit/core/channel.dart';
import 'package:madeit/core/effect.dart';

void main() => runApp(const Application());

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
    useEffect(envEffect);
    useEffect(providerEffect);
    useEffect(wsEffect);

    dispatch(const AppStarted());

    return const MaterialApp(
      initialRoute: "/splash",
      onGenerateRoute: _onGenerateRoute,
      builder: _builder,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('ko'),
        Locale('en'),
      ],
    );
  }
}
