import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jogodacobrinha/boardsscreens/boardhouse.dart';
import 'package:jogodacobrinha/globals/texts.dart';
import 'dart:math';

void main() => runApp(Intro());

class Intro extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<Intro> with SingleTickerProviderStateMixin {
  final List<String> initialPlayerResponses = [
    'Continue...',  ];
  bool showtext = false;

  bool isjokenpo = false;
  String jokenpoimguser = "";
  String jokenpoimgapp = "";
  int userWins = 0;
  int appWins = 0;
  bool winlose = false;
  String textnow = intro;
  List<Map<String, dynamic>> conversation = [];
  List<String> currentPlayerResponses = [];
  final Random random = Random();
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;
  bool isPlayerTurn = true;
  String backgroundImage = 'assets/images/earth.gif';
  bool dialoginit = true;

  @override
  void initState() {
    super.initState();
    currentPlayerResponses = List.from(initialPlayerResponses);

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _heightAnimation = Tween<double>(begin: 200, end: 350).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.5, 1.0)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addResponse(String response) async {
    if (!isPlayerTurn) return;

    setState(() {
      isPlayerTurn = false;
      if (conversation.length >= 6) {
        conversation.removeAt(0);
      }
      conversation.add({'text': response, 'isPlayer': true, 'key': UniqueKey()});
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      if (conversation.length >= 6) {
        conversation.removeAt(0);
      }
      if (response == 'Continue...') {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeBoard()), (Route<dynamic> route) => false); 
      }

      isPlayerTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Introduction',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Introduction'),
        ),
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SizedBox(height: 5,),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (context, child) {
                      return SizedBox(
                        width: double.infinity,
                        height: _heightAnimation.value,
                        child: Image.asset(
                          backgroundImage,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
                  dialoginit
                      ? Container(
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: SpeechBubble(
                              text: textnow,
                              isPlayer: false,
                            ),
                          ),
                        )
                      : Container(),
                      Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: currentPlayerResponses.map((response) {
                        return TextButton(
                          onPressed: () {
                            if (response == 'Skip') {
                              Navigator.pop(context);
                            } else {
                              addResponse(response);
                            }
                          },
                          child: MyTextCustom(response, 14, Colors.black, FontWeight.normal, true, Colors.white),
                        );
                      }).toList(),
                    ),                        
            ])
        ),
      ),
    );
  }
}

class SpeechBubble extends StatelessWidget {
  final String text;
  final bool isPlayer;

  const SpeechBubble({super.key, required this.text, required this.isPlayer});

  @override
  Widget build(BuildContext context) {
    var screentext = MediaQuery.sizeOf(context).width;
    return AnimatedOpacity(
      opacity: 0.8,
      duration: const Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        constraints: BoxConstraints(
          minWidth: 100,
          maxWidth: screentext,
        ),
        decoration: BoxDecoration(
          color: isPlayer ? Colors.greenAccent : Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: MyTextCustom(intro, 16, Colors.white, FontWeight.normal, false, Colors.white),
              ),
          ],
        ),
      ),
    );
  }
}