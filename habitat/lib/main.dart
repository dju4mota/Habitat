import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthCheck.dart';
import 'package:habitat/src/backend/AuthService.dart';
// import 'package:habitat/src/routes/routes.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:habitat/src/view/AnswerView.dart';
import 'package:habitat/src/view/HomeView.dart';
import 'package:habitat/src/view/LoginPage.dart';
import 'package:habitat/src/view/PostingView.dart';
import 'package:habitat/src/view/ProfileView.dart';
import 'package:habitat/src/view/QuestionList.dart';
import 'package:habitat/src/view/QuestionView.dart';
import 'package:habitat/src/view/RegisterView.dart';
import 'package:habitat/src/view/SearchView.dart';
import 'package:habitat/src/view/StartView.dart';
import 'package:habitat/src/view/SubjectsAllView.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Util.azulClaroFundo,
        primaryColor: Util.azulEscuroBotao,
        fontFamily: 'League Gothic Condensed',
      ),
      // routerDelegate: routes.routerDelegate,
      // routeInformationParser: routes.routeInformationParser,
      // routeInformationProvider: routes.routeInformationProvider,
      initialRoute: '/',
      routes: {
        '/': (context) => AuthCheck(),
        '/login': (context) => LoginPage(),
        '/start': (context) => StartView(),
        '/register': (context) => RegisterView(),
        '/home': (context) => HomeView(),
        '/posting': (context) => PostingView(),
        // '/postingPlace': (context) => PostingPlaceView(),
        '/questionList': (context) => QuestionList(),
        '/profile': (context) => ProfileView(),
        // '/postingList': (context) => PostingListView(),
        '/subjectsall': (context) => SubjectsAllView(),
        '/questionView': (context) => QuestionView(),
        '/answerView': (context) => AnswerView(),
        '/searchView': (context) => SearchView(),
      },
      // home: AuthCheck(),
    );
  }
}
