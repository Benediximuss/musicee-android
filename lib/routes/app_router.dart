import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/screens/all_tracks_screen.dart';
import 'package:musicee_app/screens/home_screen.dart';
import 'package:musicee_app/screens/sign_up_screen.dart';
import 'package:musicee_app/screens/sign_in_screen.dart';
import 'package:musicee_app/screens/song_detail_screen.dart';
import 'package:musicee_app/screens/welcome_screen.dart';

class AppRouter {
  const AppRouter._();

  static late final String initialRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("3131: Pushed: ${settings.name ?? 'Null settings'}");

    switch (settings.name) {
      case Routes.welcomeScreen:
        return MaterialPageRoute(
          builder: (_) => const WelcomeScreen(),
          settings: const RouteSettings(name: Routes.welcomeScreen),
        );
      case Routes.signupScreen:
        return MaterialPageRoute(
          builder: (_) => const SignUpScreen(),
          settings: const RouteSettings(name: Routes.signupScreen),
        );
      case Routes.signinScreen:
        return MaterialPageRoute(
          builder: (_) => const SignInScreen(),
          settings: const RouteSettings(name: Routes.signinScreen),
        );
      case Routes.homeScreen:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: const RouteSettings(name: Routes.homeScreen),
        );
      case Routes.allTracksScreen:
        return MaterialPageRoute(
          builder: (_) => const AllTracksScreen(),
          settings: const RouteSettings(name: Routes.allTracksScreen),
        );
      case Routes.songDetailsScreen:
        final Map<String, dynamic> arguments =
            settings.arguments as Map<String, dynamic>;

        return MaterialPageRoute(
          builder: (_) => SongDetailScreen(
            title: arguments['title'],
            artist: arguments['artist'],
            imagePath: arguments['imagePath'],
          ),
          settings: const RouteSettings(name: Routes.songDetailsScreen),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(),
            body: const Center(
              child: Text('Unknown route!'),
            ),
          ),
        );
    }
  }
}
