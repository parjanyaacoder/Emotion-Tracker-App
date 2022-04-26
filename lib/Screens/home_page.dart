import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_supa_app/Components/emotion_grid_view.dart';
import 'package:flutter_supa_app/supabase_manager.dart';
import 'create_emotion_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
 static SupabaseManager supabaseManager = SupabaseManager();

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

 @override
 void initState() {
    super.initState();
    SupabaseManager supabaseManager = SupabaseManager();
    supabaseManager.getEmotionsData();
  }

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
        body: const EmotionGridView(),


        floatingActionButton:FloatingActionButton(
          key: const Key("fab_key"),heroTag: "hero",
          child:const Icon(Icons.add,size: 28,color: Colors.blueGrey),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CreateEmotionScreen()));
          },),
          floatingActionButtonAnimator:FloatingActionButtonAnimator.scaling,

      ),
    ),
    );

  }
}



