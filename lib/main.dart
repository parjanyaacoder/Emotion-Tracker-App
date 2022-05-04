import 'package:flutter/material.dart';
import 'package:flutter_supa_app/Providers/emotion_class.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/home_page.dart';
import 'Screens/login_screen.dart';

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
   await  prefs.setString('userId', '36f953f0-291b-4e8c-af24-739bb8129ea2');
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
      theme: ThemeData(
        primaryColor: Colors.yellow.shade600,
        accentColor: Colors.orange.shade700,
        bottomAppBarColor: Colors.orange.shade700,
        primarySwatch: Colors.orange,
      ),
      debugShowCheckedModeBanner: false,
      home:
     // authorized ?
       const HomePage()
      // : const LoginScreen()
    );
  }
}

