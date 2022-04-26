import 'package:flutter/cupertino.dart';
import 'package:flutter_supa_app/supabase_manager.dart';

class Emotion
{
 @required final  String id;
 @required final String title;
 @required final String content;
 @required final bool isAnalyzed;

  Emotion(this.id, this.title, this.content, this.isAnalyzed);
}



class EmotionListClass extends ChangeNotifier
{
  List<Emotion>  emotionList = [];

   var response;

     getData() async {
      SupabaseManager supabaseManager = SupabaseManager();
      response =await supabaseManager.getEmotionsData();
      // print(response);
      notifyListeners();
    }

    getEmotionsList(String? userId)  async {
    emotionList.clear();
    var tempList = [];
     await getData();
       // print(response);
       // print("HERE");
       if(response!=null) {
         tempList = response.toList();
       } else {
         tempList = [];
       }
     // print("Gett");
     // print(tempList);
      tempList.forEach((element)=>{
      if(element['user_id'] == userId)
      emotionList.add(Emotion(element['emotion_id'], element['emotion_title'], element['emotion_text'], element['isAnalyzed'])
      )}
      );
      print(emotionList);
       return emotionList;
   }





}