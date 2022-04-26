import 'package:flutter/material.dart';

class AnalyzedScreen extends StatefulWidget {

  var sentimentMsgs = [];

  AnalyzedScreen(this.sentimentMsgs, {Key? key}) : super(key: key);
  @override
  _AnalyzedScreenState createState() => _AnalyzedScreenState();
}

class _AnalyzedScreenState extends State<AnalyzedScreen> {
  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analysis'),
      ),
      body: ListView.builder(
         physics: const ScrollPhysics(),
         itemCount: widget.sentimentMsgs.length,
         itemBuilder: (context, index) {
         return Padding(
           padding: const EdgeInsets.all(16.0),
           child: Column(
             crossAxisAlignment:CrossAxisAlignment.start,
           children: [
             Row(
               children: [
                 Text(Map<String,dynamic>.from(widget.sentimentMsgs[index])['text']),
                 const Spacer(),
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
                   child: Text(Map<String,dynamic>.from(widget.sentimentMsgs[index])['sentiment']['polarity']['score'].toString()),
                 ),
               ],
             ),
             const SizedBox(
               height: 10,
             ),

             Text(Map<String,dynamic>.from(widget.sentimentMsgs[index])['sentiment']['suggested'].toString()),
        ],
      ),
         );
      }),
    );
  }
}
