import 'package:flutter/material.dart';
import 'package:flutter_supa_app/Providers/emotionClass.dart';
import 'package:flutter_supa_app/Screens/signUp_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/homePage.dart';
import 'Screens/loginScreen.dart';

void main() {
  runApp(
      ChangeNotifierProvider(create: (context) => EmotionListClass() ,
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<bool> checkUser() async  {
    final prefs = await  SharedPreferences.getInstance();
    print(prefs.getString('userId'));
    if(prefs.getString('userId')!=null) {
      return true;
    }
    return false;
  }


  var authenticated = Future.value(false);
  bool authorized = false;

  @override
  initState()
  {
    super.initState();
    authenticated = Future.value(false);
    authorized = false;
    authenticated =  checkUser();
    authenticated.then((value) => authorized = value);
  }



  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authorized ? const HomePage() : const LoginScreen()
    );
  }
}

