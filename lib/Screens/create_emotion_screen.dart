import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_supa_app/Providers/emotion_class.dart';
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

  var userId = '';

  @override
  Widget build(BuildContext context) {

    wordCount = _contentEditingController.value.text.isEmpty ? 0 : (_contentEditingController.value.text.trim()).split(" ").length;

    return SafeArea(
      child:Scaffold(
        backgroundColor: Colors.yellow.shade100,
        appBar: AppBar(title:const Text('Create Emotion'),
        elevation: 10,
        centerTitle: true,
        ),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
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
                         contentPadding:  EdgeInsets.all(15),
                         labelStyle:  TextStyle(fontSize: 20,color: Colors.blueGrey),
                       labelText: 'Title',
                       enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                     ),
                     style: const TextStyle(),
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
                            padding: const EdgeInsets.all(4.0),
                            child: Text('Word count - $wordCount/200',style: const TextStyle(fontSize: 15,color: Colors.blueGrey),),
                          ),
                          enabledBorder: const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20)))
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: 50,
                      onChanged: (value){
                        value = _contentEditingController.value.text;
                      },
                      onSubmitted: (value){},
                    ),
                  ),
                  const SizedBox(height: 15,),
                  Hero(
                    tag: 'hero',
                    key: const Key("fab_key"),
                    child: ElevatedButton(
                      onPressed: () async {
                        if(_titleEditingController.value.text.isNotEmpty && _contentEditingController.value.text.isNotEmpty)
                        { await getUserId().then((value) => userId = value!);
                        await  Provider.of<EmotionListClass>(context,listen: false).createEmotion(userId, _titleEditingController.value.text, _contentEditingController.value.text);
                        Navigator.of(context).pop();
                        }
                      },
                      child: const Text('Save'),
                    ),
                  ),
                ]
              ),
            ),
          ),
        )
    );
  }
}

