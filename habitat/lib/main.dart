import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:habitat/src/routes/routes.dart';
import 'package:habitat/src/utils/utils.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Conexão com o Firebase
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
      initialRoute: Routes.initialRoute,
      routes: Routes.list,
      navigatorKey: Routes.navigatorKey,
    );
  }
}
