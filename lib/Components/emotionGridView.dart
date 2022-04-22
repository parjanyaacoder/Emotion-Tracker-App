import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Screens/emotionView.dart';

class EmotionGridView extends StatefulWidget {
  const EmotionGridView({Key? key}) : super(key: key);

  @override
  _EmotionGridViewState createState() => _EmotionGridViewState();
}

class _EmotionGridViewState extends State<EmotionGridView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
        physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        childAspectRatio: 7/11,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20, maxCrossAxisExtent: 180,

      ),
          itemCount: 10,
          itemBuilder: (context,item)=>InkWell(
        child: Container(

          margin: const EdgeInsets.only(top: 10,left:10,right: 10,bottom: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
              Colors.blue.shade200,
              Colors.tealAccent.shade200
            ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey)
          ),
          child: Column(
            children: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Enthusiastic'),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Content'),
              )
            ],
          ),
        ),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EmotionView(emotionTitle: "Entusiastic",
                  emotionText: ''' Hey folks, I am a developer learning Flutter and React Native I have decided to build my first open source project using Flutter. The idea is to build a Emotions manager app in Flutter with using Supabase services for database and using Text Analysis services from Symbl.ai for finding out sentiments in the text using APIs.
  Pre-requisite
  - Flutter knowledge
  - Git knowledge.
  - Working Flutter environment and Android Studio setup with Version Control integration. Using Virtual Studio ?? Come along, you are more than ready for this journey'''
              )));
            },
      ))],
    );
  }
}


