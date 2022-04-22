import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmotionView extends StatefulWidget {
  const EmotionView({Key? key,@required this.emotionTitle, @required this.emotionText}) : super(key: key);
  final  emotionTitle;
 final  emotionText;

 @override
  _EmotionViewState createState() => _EmotionViewState();
}

class _EmotionViewState extends State<EmotionView> {



  @override
  Widget build(BuildContext context) {

    print(widget.emotionTitle);
    print(widget.emotionText);

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

            onPressed: (){},
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
