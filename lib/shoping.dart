import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';


class MyShop extends StatefulWidget {
  @override
  _MyShopState createState() => _MyShopState();
}

class _MyShopState extends State<MyShop> with SingleTickerProviderStateMixin {
  final List<String> initialPlayerResponses = [
    'What do you have for sale?',
    'Exit',
  ];
  bool showtext = false;

  void _screentime(){
    showtext = true;
    backgroundImage = 'assets/images/potionshop.jpg'; // Nova imagem de fundo
     Timer(const Duration(seconds: 2), () {
      setState(() {
        backgroundImage = 'assets/images/shopping.jpeg'; // Nova imagem de fundo
        showtext = false; // Exibe o texto após 1 segundo
      });
    });
  }

  final Map<String, List<String>> dialogOptions = {
    'What do you have for sale?': [
      'Quero a poção de cura',
      'Quero a poção de força',
      'Exit'
    ],
  };

  final Map<String, String> gameResponses = {
    'What do you have for sale?': 'Tenho poções de cura e de força, qual você quer?',
    'Quero a poção de cura': 'Aqui está a poção de cura!',
    'Quero a poção de força': 'Aqui está a poção de força!',
  };

  List<Map<String, dynamic>> conversation = [];
  List<String> currentPlayerResponses = [];
  final Random random = Random();
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;
  bool isPlayerTurn = true;
  String backgroundImage = 'assets/images/shopping.jpeg';
  bool dialoginit = true;

  @override
  void initState() {
    super.initState();
    currentPlayerResponses = List.from(initialPlayerResponses);

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _heightAnimation = Tween<double>(begin: 200, end: 400).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0)),
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
      String gameResponse = gameResponses[response] ?? 'I do not understand.';
      conversation.add({'text': gameResponse, 'isPlayer': false, 'key': UniqueKey()});

      currentPlayerResponses = dialogOptions[response] ?? initialPlayerResponses;

      if (response == 'Quero a poção de cura') {
        dialoginit = false;
        _screentime();
        //backgroundImage = 'assets/images/potionshop.jpg'; // Nova imagem de fundo
      }

      isPlayerTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Merchant'),
        ),
        backgroundColor: Colors.black,
        body: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black,
                Colors.grey,
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                children: [
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
                   dialoginit ?
                  Positioned(
                    left: 150,
                    top: 16,
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: SpeechBubble(
                        text: "Em uma parte do camimho, das estradas deserticas de West Imperion você avista uma barraca comerciante, sem dono? Logo por de traz do balcão um velhinho magro e com roupas velha de couro aparece e fala: - Bem vindo a minha loja!",
                        isPlayer: false,
                      ),
                    ),
                  ) : Container(),
                  
                ],
              ),
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: conversation.length,
                  itemBuilder: (context, index) {
                    final message = conversation[conversation.length - 1 - index];
                    return SpeechBubble(
                      key: message['key'],
                      text: message['text'],
                      isPlayer: message['isPlayer'],
                    );
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: currentPlayerResponses.map((response) {
                  return ElevatedButton(
                    onPressed: () {
                      if (response == 'Exit') {
                        Navigator.pop(context);
                      } else {
                        addResponse(response);
                      }
                    },
                    child: Text(response),
                  );
                }).toList(),
              ),
            ],
          ),
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
    return AnimatedOpacity(
      opacity: 1.0,
      duration: Duration(seconds: 1),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        constraints: const BoxConstraints(
          minWidth: 100,
          maxWidth: 200,
        ),
        decoration: BoxDecoration(
          color: isPlayer ? Colors.greenAccent : Colors.blueAccent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Expanded(
              child: Text(
                text,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
