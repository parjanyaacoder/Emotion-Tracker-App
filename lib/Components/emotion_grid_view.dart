import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_supa_app/Providers/emotion_class.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/emotion_view.dart';

class EmotionGridView extends StatefulWidget {
  const EmotionGridView({Key? key}) : super(key: key);

  @override
  _EmotionGridViewState createState() => _EmotionGridViewState();
}

class _EmotionGridViewState extends State<EmotionGridView> {

var emotionList = [];

  Future<String?> getUserId() async {
    final prefs = await  SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  deleteEmotion(String emotionId)
  {
    Provider.of<EmotionListClass>(context,listen: false).deleteEmotion(emotionId);
  }

String? userId;
  @override
  void initState() {
    super.initState();

   getUserId().then((value) => userId = value);
   Provider.of<EmotionListClass>(context,listen: false).getEmotionsList(userId).then((value) => emotionList = value);
  }




  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(

      onRefresh: () async => {
          setState(() {
        }),
      },
      child: SingleChildScrollView(
        physics:const BouncingScrollPhysics(parent:AlwaysScrollableScrollPhysics()),
          child:FutureBuilder(
        future: Future.delayed(const Duration(seconds: 1),
            () async => {  getUserId().then((value) => userId = value),
         emotionList = await  Provider.of<EmotionListClass>(context,listen: false).getEmotionsList(userId)
      }
        ),
        builder:(context, snapshot)
        {
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
            if(emotionList.isEmpty) {
              return  SizedBox(
                 width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center (child:Text('The list is Empty. Tap the + icon to create an emotion',
                    style: TextStyle(color: Colors.grey.shade600,fontSize: 15),
                    )),
                  ));
            }
            return  GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 7 / 11,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: 180,
                ),
                itemCount: emotionList.length,
                itemBuilder: (context, index) => InkWell(
                      child: GlassContainer(
                        height: MediaQuery.of(context).size.height*0.35,
                        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.orange.shade200,Colors.red.shade500],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            borderColor: Colors.grey,
                        borderWidth: 2.0,
                        width:  MediaQuery.of(context).size.height*0.25,

                        child: Column(
                          children:  [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${emotionList[index].title}',style: TextStyle(color: Colors.white),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('${emotionList[index].content}',style: TextStyle(color: Colors.white),),
                            )
                          ],
                        ),
                      ),
                      onTap: () {

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EmotionView(
                                    emotionTitle: emotionList[index].title,
                                    emotionText:
                                    emotionList[index].content,
                                    emotionId:emotionList[index].id,
                                    userId: userId,
                                    analyzed: emotionList[index].isAnalyzed,
                                )));
                      },
                  onLongPress: (){
                        deleteEmotion(emotionList[index].id);
                  },
                    ));
          }
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Center (child:
               CircularProgressIndicator()
              )
              ));
        },
      )),
    );
  }
}


