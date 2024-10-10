import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:jogodacobrinha/luckitens/luckwheel.dart';
import 'package:jogodacobrinha/caverncboard.dart';

void main() => runApp(MyText());

class MyText extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyTextState createState() => _MyTextState();
}

class _MyTextState extends State<MyText> with SingleTickerProviderStateMixin {
  final List<String> initialPlayerResponses = [
    'Aproxime-se...',
    'Saia',
  ];
  bool showtext = false;
  String textone = "Ao passar por uma clareira, você escuta uma voz te chamar: \n -Ei você, venha aqui, tenho presentes...";
  String texttwo = "Ganhe de mim no jokenpo e receba sua recompensa.";
  bool isjokenpo = false;
  String jokenpoimguser = "";
  String jokenpoimgapp = "";
  int userWins = 0;
  int appWins = 0;
  bool winlose = false;

  void _screentwo() {
    setState(() {
      textone = texttwo;
      backgroundImage = 'assets/images/gifttest.jpg';
      isjokenpo = true;
    });
  }

  void _opcaoSelecionada(String escolhaUsuario) {
    var opcoes = ["pedra", "papel", "tesoura"];
    var numero = Random().nextInt(3);
    var escolhaApp = opcoes[numero];

    // Exibição da imagem escolhida pelo App
    switch (escolhaApp) {
      case "pedra":
        jokenpoimgapp = 'jo.jpg';
        break;
      case "papel":
        jokenpoimgapp = 'ken.jpg';
        break;
      case "tesoura":
        jokenpoimgapp = 'po.jpg';
        break;
    }

    // Exibição da imagem escolhida pelo Usuário
    switch (escolhaUsuario) {
      case "pedra":
        jokenpoimguser = 'jo.jpg';
        break;
      case "papel":
        jokenpoimguser = 'ken.jpg';
        break;
      case "tesoura":
        jokenpoimguser = 'po.jpg';
        break;
    }

    // Validação do ganhador
    if (
      (escolhaUsuario == "pedra" && escolhaApp == "tesoura") ||
      (escolhaUsuario == "tesoura" && escolhaApp == "papel") ||
      (escolhaUsuario == "papel" && escolhaApp == "pedra")
    ) {
      setState(() {
        userWins++;
        if  ((userWins >= 2) & (userWins > appWins)) {
          _showWinDialog("Você ganhou!");
          winlose = true;
        }
      });
    } else if (
      (escolhaUsuario == "tesoura" && escolhaApp == "pedra") ||
      (escolhaUsuario == "papel" && escolhaApp == "tesoura") ||
      (escolhaUsuario == "pedra" && escolhaApp == "papel")
    ) {
      setState(() {
        appWins++;
        if ((appWins >= 2) & (appWins > userWins)) {
          _showWinDialog("Você perdeu!");
        }
      });
    } else {
      setState(() {
        print('EMPATOU');
      });
    }
  }

  void _showWinDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
              if (winlose == true) {
                Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  LuckyWheelApp()),);
              }
              else{
                setState(() {
                  isjokenpo = false;
                  userWins = 0;
                  appWins = 0;
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  const BoardGame()),);
                });
              }
              },
            ),
          ],
        );
      },
    );
  }

  List<Map<String, dynamic>> conversation = [];
  List<String> currentPlayerResponses = [];
  final Random random = Random();
  late AnimationController _controller;
  late Animation<double> _heightAnimation;
  late Animation<double> _opacityAnimation;
  bool isPlayerTurn = true;
  String backgroundImage = 'assets/images/clareira.png';
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
      if (response == 'Aproxime-se...') {
        _screentwo();
      }

      isPlayerTurn = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Joken',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Joken'),
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
                  dialoginit
                      ? Positioned(
                          left: 150,
                          top: 16,
                          child: FadeTransition(
                            opacity: _opacityAnimation,
                            child: SpeechBubble(
                              text: textone,
                              isPlayer: false,
                            ),
                          ),
                        )
                      : Container(),
              
                ],
              ),
              isjokenpo
                  ? Expanded(
                      child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           Text(
                            '$userWins/3', style: const TextStyle(fontSize: 18),
                          ),
                          Container(
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/$jokenpoimguser'), // Certifique-se de que a imagem exista
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            width: 80,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/$jokenpoimgapp'), // Certifique-se de que a imagem exista
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Text(
                            '$appWins/3', style: const TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 252, 248, 8),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  _opcaoSelecionada("pedra");
                                },
                                child: Container(
                                  width: 90,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/jo.jpg'), // Certifique-se de que a imagem exista
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _opcaoSelecionada("papel");
                                },
                                child: Container(
                                  width: 90,
                                  height: 200,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/ken.jpg'), // Certifique-se de que a imagem exista
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  _opcaoSelecionada("tesoura");
                                },
                                child: Container(
                                  width: 90,
                                  height: 240,
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/po.jpg'), // Certifique-se de que a imagem exista
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ))
                    ]))
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: currentPlayerResponses.map((response) {
                        return ElevatedButton(
                          onPressed: () {
                            if (response == 'Go away') {
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
      duration: const Duration(seconds: 1),
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