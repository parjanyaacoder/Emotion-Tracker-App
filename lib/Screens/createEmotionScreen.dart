import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_supa_app/Providers/emotionClass.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateEmotionScreen extends StatefulWidget {
  const CreateEmotionScreen({Key? key}) : super(key: key);

  @override
  _CreateEmotionScreenState createState() => _CreateEmotionScreenState();
}

class _CreateEmotionScreenState extends State<CreateEmotionScreen> {

  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _contentEditingController = TextEditingController();
  var wordCount = 0;

  Future<String?> getUserId() async {
    final prefs = await  SharedPreferences.getInstance();
    return prefs.getString('userId') ?? '';
  }

  var userId;

  @override
  Widget build(BuildContext context) {

    wordCount = _contentEditingController.value.text.isEmpty ? 0 : ("${_contentEditingController.value.text.trim()}").split(" ").length;

    return SafeArea(
      child:Scaffold(

        appBar: AppBar(title:Text('Create Emotion'),
        elevation: 10,
        centerTitle: true,
        actions: [
          TextButton(onPressed: () async {
            if(_titleEditingController.value.text.isNotEmpty && _contentEditingController.value.text.isNotEmpty)
           { await getUserId().then((value) => userId = value);
          await  Provider.of<EmotionListClass>(context,listen: false).createEmotion(userId, _titleEditingController.value.text, _contentEditingController.value.text);
            Navigator.of(context).pop();
          }
            }, child :const Text('Save',style: TextStyle(color: Colors.white),))
        ],
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Container(
                child: Column(

                  children: [
                   Container(
                     margin: const EdgeInsets.only(top:20,bottom: 20),
                     child: TextField(
                    keyboardType: TextInputType.multiline,
                       maxLength: 200,
                       maxLines: 3,

                       decoration: const InputDecoration(
                           alignLabelWithHint: true,
                           contentPadding: const EdgeInsets.all(15),
                           labelStyle:  TextStyle(fontSize: 20,color: Colors.blueGrey),
                         labelText: 'Title',
                         enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                       ),
                       style: TextStyle(),
                       controller: _titleEditingController,
                       onChanged: (value){
                         value = _titleEditingController.value.text;
                       },
                       onSubmitted: (value){
                       },
                     ),
                   ),

                    Container(
                      margin: const EdgeInsets.only(top:20,bottom: 20),
                      height: MediaQuery.of(context).size.height*0.6,
                      child: TextField(

                        controller: _contentEditingController,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                        decoration:  InputDecoration(
                          labelText: 'Emotion',
                            contentPadding: const EdgeInsets.all(15),
                            alignLabelWithHint: true,
                            labelStyle: const TextStyle(fontSize: 20,color: Colors.blueGrey),
                            counter: Padding(
                              padding: EdgeInsets.all(4.0),
                              child: Text('Word count - ${wordCount}/200',style: TextStyle(fontSize: 15,color: Colors.blueGrey),),
                            ),
                            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                        ),
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(),
                        maxLines: 50,
                        onChanged: (value){
                          value = _contentEditingController.value.text;
                        },
                        onSubmitted: (value){},
                      ),
                    ),
                    SizedBox(height: 15,),
                    Hero(
                      tag: 'hero',
                      key: const Key("fab_key"),
                      child: ElevatedButton(

                        onPressed: (){},
                        child: const Text('Analyze'),
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ),
        )
    );
  }
}
