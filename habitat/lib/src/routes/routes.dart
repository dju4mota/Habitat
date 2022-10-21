import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/view/AnswerView.dart';
import 'package:habitat/src/view/HomeView.dart';
import 'package:habitat/src/view/LoginPage.dart';
import 'package:habitat/src/view/PostingView.dart';
import 'package:habitat/src/view/ProfileView.dart';
import 'package:habitat/src/view/QuestionList.dart';
import 'package:habitat/src/view/QuestionView.dart';
import 'package:habitat/src/view/RegisterView.dart';
import 'package:habitat/src/view/StartView.dart';
import 'package:habitat/src/view/SubjectsAllView.dart';

import '../backend/AuthCheck.dart';
import '../view/SearchView.dart';

class Routes {
  static Map<String, Widget Function(BuildContext)> list = <String, WidgetBuilder>{
    '/': (_) => AuthCheck(),
    '/login': (_) => LoginPage(),
    '/start': (_) => StartView(),
    '/register': (_) => RegisterView(),
    '/home': (_) => HomeView(),
    '/posting': (_) => PostingView(),
    '/questionList': (_) => QuestionList(),
    '/profile': (_) => ProfileView(),
    '/subjectsall': (_) => SubjectsAllView(),
    '/questionView': (_) => QuestionView(),
    '/answerView': (_) => AnswerView(),
    '/searchView': (_) => SearchView(),
  };
  static String initialRoute = '/';
  static GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();
}

final authService = AuthService();

final routes = GoRouter(
  // ?
  refreshListenable: authService,
  redirect: (state) {
    final isAutheticated = authService.usuario != null;
    final isLoginRoute = state.subloc == '/';
    print("redirect");
    if (!isAutheticated) {
      return isLoginRoute ? null : '/';
    }

    if (isLoginRoute) return '/home';

    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const StartView(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => RegisterView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => HomeView(),
    ),
    GoRoute(
      path: '/home/posting',
      builder: (context, state) => PostingView(),
    ),
    GoRoute(
      path: '/home/profile',
      builder: (context, state) => ProfileView(),
    ),
    GoRoute(
      path: '/home/subjectsAll',
      builder: (context, state) => SubjectsAllView(),
    ),
    GoRoute(
      path: '/home/subjectsAll/questionsList',
      builder: (context, state) => QuestionList(),
    ),
    GoRoute(
      path: '/home/subjectsAll/questionsList/question',
      builder: (context, state) => QuestionView(),
    ),
    GoRoute(
      path: '/home/subjectsAll/questionsList/question/answer',
      builder: (context, state) => AnswerView(),
    ),
  ],
);
