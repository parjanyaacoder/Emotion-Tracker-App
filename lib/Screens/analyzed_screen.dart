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
      backgroundColor: Colors.yellow.shade100,
      appBar: AppBar(
        elevation: 10,
        title: const Text('Analysis'),
        centerTitle: true,
      ),
      body: ListView.builder(
         physics: const ScrollPhysics(),
         itemCount: widget.sentimentMsgs.length,
         itemBuilder: (context, index) {
         return Padding(
           padding: const EdgeInsets.all(16.0),
           child: Container(
             decoration: const BoxDecoration(
               borderRadius: BorderRadius.all(Radius.circular(20)),
             ),
             child: Column(
               crossAxisAlignment:CrossAxisAlignment.start,
             children: [
               Row(
                 children: [
                   Text(Map<String,dynamic>.from(widget.sentimentMsgs[index])['text'],style: const TextStyle(
                     fontSize: 16,
                     overflow: TextOverflow.fade
                   ),),
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
               Text(Map<String,dynamic>.from(widget.sentimentMsgs[index])['sentiment']['suggested'].toString(),style: TextStyle(
                  color: Map<String,dynamic>.from(widget.sentimentMsgs[index])['sentiment']['suggested'].toString() == 'positive' ? Colors.green : Colors.red,
                  fontSize: 16,
               ),),
        ],
      ),
           ),
         );
      }),
    );
  }
}
