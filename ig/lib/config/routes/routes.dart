import 'package:ig/core/screens/error_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:ig/core/screens/home_screen.dart';
import 'package:ig/core/screens/profile_screen.dart';
import 'package:ig/features/auth/presentation/screens/create_account_screen.dart';
import 'package:ig/features/posts/presentation/screens/comments_screen.dart';
import 'package:ig/features/posts/presentation/screens/create_post_screen.dart';

class Routes {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case CreateAccountScreen.routeName:
      return _cupertinoRoute(const CreateAccountScreen(),);
      case HomeScreen.routeName:
      return _cupertinoRoute(const HomeScreen(),);
      case CreatePostScreen.routeName:
      return _cupertinoRoute(const CreatePostScreen(),);
      case CommentsScreen.routeName:
        final postId = settings.arguments as String;
        return _cupertinoRoute(
          CommentsScreen(postId: postId),
        );
       case ProfileScreen.routeName:
        final userId = settings.arguments as String;
        return _cupertinoRoute(
          ProfileScreen(
            userId: userId,
          ),
        );
      default:
        return _cupertinoRoute(
          ErrorScreen(
            error: 'Wrong Route provided ${settings.name}',
          ),
        );
    }
  }

  static Route _cupertinoRoute(Widget view) => CupertinoPageRoute(
        builder: (_) => view,
      );

  Routes._();
}