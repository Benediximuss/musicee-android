import 'package:flutter/material.dart';
import 'package:musicee_app/routes/routes.dart';
import 'package:musicee_app/screens/album_screen.dart';
import 'package:musicee_app/screens/all_tracks_screen.dart';
import 'package:musicee_app/screens/artist_screen.dart';
import 'package:musicee_app/screens/home_screen.dart';
import 'package:musicee_app/screens/sign_up_screen.dart';
import 'package:musicee_app/screens/sign_in_screen.dart';
import 'package:musicee_app/screens/song_detail_screen.dart';
import 'package:musicee_app/screens/track_comments_screen.dart';
import 'package:musicee_app/screens/update_track_screen.dart';
import 'package:musicee_app/screens/user_comments_screen.dart';
import 'package:musicee_app/screens/user_friends_screen.dart';
import 'package:musicee_app/screens/user_likes_screen.dart';
import 'package:musicee_app/screens/user_profile_screen.dart';
import 'package:musicee_app/screens/welcome_screen.dart';
import 'package:musicee_app/screens/add_track_screen.dart';

class AppRouter {
  const AppRouter._();

  static late final String initialRoute;

  static Route<dynamic> generateRoute(RouteSettings settings) {
    print("3131: Pushed: ${settings.name ?? 'Null settings'}");
    late Map<String, dynamic> arguments;

    if (settings.arguments != null) {
      arguments = settings.arguments as Map<String, dynamic>;
    }

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
        return MaterialPageRoute(
          builder: (_) => SongDetailScreen(
            trackID: arguments['trackID'],
          ),
          settings: const RouteSettings(name: Routes.songDetailsScreen),
        );
      case Routes.userProfileScreen:
        return MaterialPageRoute(
          builder: (_) => UserProfileScreen(
            showAppBar: arguments['showAppBar'],
            username: arguments['username'],
          ),
          settings: const RouteSettings(name: Routes.userProfileScreen),
        );
      case Routes.userFriendsScreen:
        return MaterialPageRoute(
          builder: (_) => UserFriendsScreen(
            username: arguments['username'],
            friendsList: arguments['friendsList'],
          ),
          settings: const RouteSettings(name: Routes.userFriendsScreen),
        );
      case Routes.userLikesScreen:
        return MaterialPageRoute(
          builder: (_) => UserLikesScreen(
            username: arguments['username'],
          ),
          settings: const RouteSettings(name: Routes.userLikesScreen),
        );
      case Routes.addTrackScreen:
        return MaterialPageRoute(
          builder: (_) => const AddTrackScreen(),
          settings: const RouteSettings(name: Routes.addTrackScreen),
        );
      case Routes.updateTrackScreen:
        return MaterialPageRoute(
          builder: (_) => UpdateTrackScreen(
            trackID: arguments['trackID'],
          ),
          settings: const RouteSettings(name: Routes.updateTrackScreen),
        );
      case Routes.artistScreen:
        return MaterialPageRoute(
          builder: (_) => ArtistScreen(
            artistName: arguments['artistName'],
          ),
          settings: const RouteSettings(name: Routes.artistScreen),
        );
      case Routes.albumScreen:
        return MaterialPageRoute(
          builder: (_) => AlbumScreen(
            albumName: arguments['albumName'],
            artistName: arguments['artistName'],
          ),
          settings: const RouteSettings(name: Routes.albumScreen),
        );
      case Routes.trackCommentsScreen:
        return MaterialPageRoute(
          builder: (_) => TrackCommentsScreen(
            trackDetails: arguments['trackDetails'],
          ),
          settings: const RouteSettings(name: Routes.trackCommentsScreen),
        );
      case Routes.userCommentsScreen:
        return MaterialPageRoute(
          builder: (_) => UserCommentsScreen(
            username: arguments['username'],
          ),
          settings: const RouteSettings(name: Routes.userCommentsScreen),
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
