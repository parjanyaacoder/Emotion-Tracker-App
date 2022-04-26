import 'package:flutter/material.dart';
import 'package:flutter_supa_app/Screens/analyzed_screen.dart';
import 'package:flutter_supa_app/symbl.dart';
import 'package:glass_kit/glass_kit.dart';

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
    var authToken = '';
    var conversationId = '';
    var jobId = '';
    var tempMsgs;
    await SymblApi().getAccessToken().then((val)=>
  {
    authToken=val});
    await SymblApi().getConversationId(authToken, text).then((val)=>{conversationId=val['conversationId'],
    jobId=val['jobId']}
    );
    var status = 'in_progress';

   do
    {
     await SymblApi().getJobStatus(jobId, authToken).then((val)=>status = val);
    } while(status!='completed');
    await SymblApi().getSentiments(conversationId, authToken).then((val)=>{
       tempMsgs = val
    });
   return  tempMsgs;
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.yellow.shade100,
        appBar: AppBar(title: const Text('Emotion View',),
        centerTitle: true,
          elevation: 10,
        ),
        body: SingleChildScrollView(
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GlassContainer.clearGlass(
                  gradient:  LinearGradient(
                    colors: [Colors.orange.shade200,Colors.red.shade500],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderGradient: LinearGradient(
                    colors: [Colors.black26,Colors.grey.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderWidth: 2.0,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
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
                          color: Colors.white
                        ),
                      ),
                    )
                  ),
                ),
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton:  Container(
          margin: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width*0.25,height: MediaQuery.of(context).size.height*0.045,
          child: FloatingActionButton(
            onPressed: () async {
             await  analyzeText(widget.emotionText).then((val)=>sentimentMsgs = val);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>AnalyzedScreen(sentimentMsgs
              )));

            },
            isExtended: true,
            shape:  RoundedRectangleBorder(
              borderRadius:  BorderRadius.circular(5),

            ),
            elevation: 2.0,
            child: const
               Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Analyze',softWrap: true,style: TextStyle(fontSize: 15),),
            ),
          ),
        ),
      ),
    );
  }
}
