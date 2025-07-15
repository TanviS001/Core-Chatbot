import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:flutter/material.dart';
import 'package:core/message_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:'Core',
      home: Home()
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  DialogFlowtter? dialogFlowtter;
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [];

  @override
  void initState() {
    DialogFlowtter.fromFile().then((instance)=>dialogFlowtter=instance);
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff161A30),
      appBar: AppBar(
        backgroundColor: Color(0xff31304D),
        title: Text(
          'Core',
          style: TextStyle(color: Color(0xffF0ECE5)),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(child: MessagesScreen(messages: messages)),
            Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 14.0),
                decoration: BoxDecoration(
                    color: Color(0xff31304D),
                    borderRadius: BorderRadius.circular(20)
                ),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type here...',
                          hintStyle: TextStyle(
                            color: Color(0xffB6BBC4)
                          )
                        ),
                        cursorColor: Color(0xffF0ECE5),
                        controller: _controller,
                        style: TextStyle(
                        color: Color(0xffF0ECE5)
                      ),
                      )
                  ),
                  IconButton(onPressed: (){
                    sendMessage(_controller.text);
                    _controller.clear();
                  }, icon: Icon(Icons.send_rounded, color: Color(0xffF0ECE5),))
                ],
              )
            )
          ],
        )
      ),
    );
  }

  sendMessage(String text) async{
    if(text.isEmpty){
      print('Message is empty');
    } else {
      setState(() {
        addMessage(Message(
          text: DialogText(
            text: [text]
          )),
            true
        );
      });

      if (dialogFlowtter == null) return;
      DetectIntentResponse response = await dialogFlowtter!.detectIntent(queryInput: QueryInput(text: TextInput(text: text)));

      if(response.message==null){
        return;
      }
      setState(() {
        addMessage(response.message!);
      });

    }
  }

  addMessage(Message message, [bool isUserMessage=false]){
    messages.add({
      'message': message.text!.text![0],
      'isUserMessage': isUserMessage,
    });
  }
}
