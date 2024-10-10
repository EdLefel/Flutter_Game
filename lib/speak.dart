import 'package:flutter/material.dart';
import 'package:jogodacobrinha/combats/battlescreen.dart';
import 'package:jogodacobrinha/globals/globals.dart';
import 'package:jogodacobrinha/globals/globalsenemy.dart';
import 'dart:math';

import 'package:jogodacobrinha/caverncboard.dart';
class MySpeak extends StatelessWidget {
  final String hellotext;
  final String enemyguarding;

  MySpeak({super.key})
      : hellotext = _randomhellos(),
        enemyguarding = _randomenemy();

  static String _randomhellos() {
    Random random = Random();
    int randomIndex = random.nextInt(wordsbadhello.length);
    return wordsbadhello[randomIndex];
  }

  static String _randomenemy() {
    Random random = Random();
    int randomIndex = random.nextInt(castleguardian.length);
    return castleguardian[randomIndex];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battle',
      theme: ThemeData.dark(),  // Tema escuro
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dungeon'),
        ),
        backgroundColor: Colors.black,  // Fundo preto
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/$enemyguarding', // Certifique-se de que o caminho para a imagem esteja correto
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 220,
                  top: 16,
                  child: SpeechBubble(
                    text: hellotext,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton( 
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BoardGame()), (Route<dynamic> route) => false); 
                  },
                  child: const Text('Fugir'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BattleScreen()), (Route<dynamic> route) => false); 
                  },
                  child: const Text('Lutar'),
                ),
              ],)
          ],
        ),
      ),
    );
  }
}

class SpeechBubble extends StatelessWidget {
  final String text;

  const SpeechBubble({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(8),
      constraints: const BoxConstraints(
        minWidth: 100,
        maxWidth: 150,
      ),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
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
    );
  }
}