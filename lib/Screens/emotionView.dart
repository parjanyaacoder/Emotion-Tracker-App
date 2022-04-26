import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_supa_app/Screens/analyzedScreen.dart';
import 'package:flutter_supa_app/symbl.dart';

class EmotionView extends StatefulWidget {
  const EmotionView({Key? key,@required this.emotionTitle, @required this.emotionText}) : super(key: key);
  final  emotionTitle;
 final  emotionText;

 @override
  _EmotionViewState createState() => _EmotionViewState();
}

class _EmotionViewState extends State<EmotionView> {

  var sentimentMsgs;

 Future<List> analyzeText(String text)
  async {
    var authToken;
    var conversationId;
    var jobId;
    var tempMsgs;
    await SymblApi().getAccessToken().then((val)=>
  {  print(val),
    authToken=val});
    print(authToken);
    await SymblApi().getConversationId(authToken, text).then((val)=>{conversationId=val['conversationId'],
    jobId=val['jobId']}
    );
    print(conversationId);
    var status = 'in_progress';

   do
    {
     await SymblApi().getJobStatus(jobId, authToken).then((val)=>status = val);
    } while(status!='completed');
    await SymblApi().getSentiments(conversationId, authToken).then((val)=>{
       tempMsgs = val
    });
    print('Senti');
   return  tempMsgs;
  }

  @override
  Widget build(BuildContext context) {

    // print(widget.emotionTitle);
    // print(widget.emotionText);

    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: Text(
                  '${widget.emotionTitle}',
                  style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 25),
                ),
              ),
              Container(
               decoration: const BoxDecoration(
                 borderRadius:  BorderRadius.all(Radius.circular(10)),
               ),
                height: MediaQuery.of(context).size.height*0.8,
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 15),
                  child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Text(
                   widget.emotionText,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:  Container(
          margin: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.045,
          child:  FloatingActionButton(
            child:  Padding(
              padding:  EdgeInsets.all(8.0),
              child:  Text('Analyze',softWrap: true,style: TextStyle(fontSize: 15),),
            ),

            onPressed: () async {
              print('start');
             await  analyzeText(widget.emotionText).then((val)=>sentimentMsgs = val);
             print('end');
             print(sentimentMsgs);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalyzedScreen(sentimentMsgs
              )));

            },
            isExtended: true,
            shape:  RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(5),

            ),
            elevation: 2.0,
          ),
        ),
      ),
    );
  }
}
