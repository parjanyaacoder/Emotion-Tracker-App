import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_supa_app/Components/emotionGridView.dart';
import 'package:flutter_supa_app/supabase_manager.dart';
import 'createEmotionScreen.dart';
import 'emotionView.dart';



class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
 static SupabaseManager supabaseManager = SupabaseManager();
  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.blue
      )
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
     value: const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.blue,

    ),
     child: SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Emotions Page',),centerTitle: true,),
        body:
            const SingleChildScrollView(
          child: EmotionGridView(),
            ),

        floatingActionButton:FloatingActionButton(
          key: const Key("fab_key"),heroTag: "hero",
          child:const Icon(Icons.add,size: 28,color: Colors.blueGrey),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateEmotionScreen()));
          },),
          floatingActionButtonAnimator:FloatingActionButtonAnimator.scaling,

      ),
    ),
    );

  }
}



