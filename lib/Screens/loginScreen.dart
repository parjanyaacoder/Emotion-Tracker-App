import 'package:flutter/material.dart';
import 'package:flutter_supa_app/Screens/homePage.dart';
import 'package:flutter_supa_app/supabase_manager.dart';
import 'emotionView.dart';

class LoginScreen extends StatelessWidget {
 const  LoginScreen({Key? key}) : super(key: key);
static SupabaseManager supabaseManager = SupabaseManager();
  @override
  Widget build(BuildContext context) {
    return
      SafeArea(
        child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(50),
          child: Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const <Widget>[
                    Icon(Icons.account_circle,color: Colors.white),
                    SizedBox(width: 10,),
                    Text("Sign in to Supabase",
                    style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              onPressed:  () async
              {
                await supabaseManager.signUpUser("padityashukla@gmail.com", "DEV26@Housing");
               Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
            ),
          ),
        ),
    ),
      );
  }
}
