import 'package:flutter/material.dart';
import 'package:flutter_supa_app/Providers/emotionClass.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/emotionView.dart';

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
String? userId;
  @override
  void initState() {
    super.initState();

   getUserId().then((value) => userId = value);
   Provider.of<EmotionListClass>(context,listen: false).getEmotionsList(userId).then((value) => emotionList = value);
   print(userId);
   print('Hi');
   print(emotionList);
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 1),
          () async => {  getUserId().then((value) => userId = value),
       emotionList = await  Provider.of<EmotionListClass>(context,listen: false).getEmotionsList(userId)
    }
      ),
      builder:(context, snapshot)
      {
        if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
          return  Column(
          children: [
            GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 7 / 11,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  maxCrossAxisExtent: 180,
                ),
                itemCount: emotionList.length,
                itemBuilder: (context, index) => InkWell(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 5),
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.blue.shade200, Colors.tealAccent.shade200],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Colors.grey)),
                        child: Column(
                          children:  [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('${emotionList[index].title}'),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('${emotionList[index].content}'),
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
                                    emotionList[index].content)));
                      },
                    ))
          ],
        );
        }
        return const Center(
            child: CircularProgressIndicator());
      },
    );
  }
}


