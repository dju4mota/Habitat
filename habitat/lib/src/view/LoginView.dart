import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:habitat/src/backend/AuthService.dart';
import 'package:provider/provider.dart';

// import 'dashboard_screen.dart';

const users = {
  'dribbble@gmail.com': '12345',
  'hunter@gmail.com': 'hunter',
};

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Duration get loginTime => Duration(milliseconds: 2250);
  bool isLogin = true;

  login(email, password) async {
    try {
      await context.read()<AuthService>().login(email, password);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');
    return login(data.name, data.password);
    //   Future.delayed(loginTime).then((_) {
    //   if (!users.containsKey(data.name)) {
    //     return 'User not exists';
    //   }
    //   if (users[data.name] != data.password) {
    //     return 'Password does not match';
    //   }
    //   return null;
    // });
  }

  registar(email, password) async {
    try {
      await context.read<AuthService>().register(email, password);
    } on AuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      if (!users.containsKey(name)) {
        return 'User not exists';
      }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
        onPressed: () {
          login("", "");
        },
        child: Text("APERTA"),
      ),
    );
    // }

    //     FlutterLogin(
    //   title: 'Habitat',
    //   theme: LoginTheme(
    //     primaryColor: const Color.fromARGB(255, 44, 116, 139),
    //     titleStyle: const TextStyle(
    //       color: Colors.greenAccent,
    //       fontFamily: 'Quicksand',
    //       letterSpacing: 4,
    //     ),
    //   ),
    //
    //   // logo: AssetImage('assets/images/ecorp-lightblue.png'),
    //   onLogin: _authUser,
    //   onSignup: _signupUser,
    //   onSubmitAnimationCompleted: () {
    //     Navigator.of(context).pushReplacement(
    //       MaterialPageRoute(
    //         builder: (context) => HomeView(),
    //       ),
    //     );
    //   },
    //   onRecoverPassword: _recoverPassword,
    // );
  }
}
