import 'package:flutter/material.dart';
import 'package:jogodacobrinha/globals/globals.dart';

void main() => runApp(MyStatus());

class MyStatus extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _MyStatusState createState() => _MyStatusState();
}

class MyDivider2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
 LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth, 
 // A largura será igual à largura máxima disponível
          height: 1,
          color: Colors.white,
        );
      },
    );
  }
}

class _MyStatusState extends State<MyStatus> with SingleTickerProviderStateMixin {
  
  bool acreshab = true;
  void acrescimo(int parametro){

    if (playerhabpoints <= 0){
      acreshab = false;
    }
    else if(playerhabpoints > 0 && parametro == 1){
      setState(() {
        playerhabpoints -= 1;
        playerAttack += 1;
      });
    }
    else if(playerhabpoints > 0 && parametro == 2){
      setState(() {
        playerhabpoints -= 1;
        //playerlifepoints += 1;
      });
    }
     else if(playerhabpoints > 0 && parametro == 3){
      setState(() {
        playerhabpoints -= 1;
        playerfireatk += 1;
      });
    }
     else if(playerhabpoints > 0 && parametro == 4){
      setState(() {
        playerhabpoints -= 1;
        playerwateratk += 1;
      });
    }
     else if(playerhabpoints > 0 && parametro == 5){
      setState(() {
        playerhabpoints -= 1;
        playerradioativeatk += 1;
      });
    }
    else if(playerhabpoints > 0 && parametro == 6){
      setState(() {
        playerhabpoints -= 1;
        playereletricatk += 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Status do Player',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Status do Player'),
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
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft, // Início do gradiente
                            end: Alignment.bottomRight, // Fim do gradiente
                            colors: [
                              Color.fromARGB(255, 0, 92, 3), // Primeira cor
                              Colors.black, // Primeira cor
                            ],
                            tileMode: TileMode.clamp,
                          ),
                      ),
                    child: Column(
                      children: [
                        const Text("Player name: "),
                        const SizedBox(height: 5),
                        Text("Player lv.: $playerlevel "),
                        const SizedBox(height: 5),
                        Text("Dificuldade / Dungeon lv.: $gscore "),
                        const SizedBox(height: 5),
                        MyDivider2(),
                        const SizedBox(height: 5),
                      ]
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        color: Colors.white,
                        gradient: const LinearGradient(
                            begin: Alignment.bottomLeft, // Início do gradiente
                            end: Alignment.bottomRight, // Fim do gradiente
                            colors: [
                              Color.fromARGB(255, 0, 92, 3), // Primeira cor
                              Colors.black, // Primeira cor
                            ],
                            tileMode: TileMode.clamp,
                          ),
                      ),
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Text("Pontos de habilidade: $playerhabpoints ", style: TextStyle(backgroundColor: Colors.black, color: Colors.deepPurpleAccent)),
                      Row(
                        children: [
                          Text("Ataque fisico: $playerAttack",), 
                          GestureDetector(
                            onTap: () {
                              acrescimo(1);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(2.0),
                              padding: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                begin: Alignment.bottomLeft, // Início do gradiente
                                end: Alignment.topRight, // Fim do gradiente
                                colors: [
                                  Colors.brown, // Primeira cor
                                  Colors.black, // Primeira cor
                                ],
                              ),
                              ),
                              child: const Text('+'),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(height: 5),
                          Text("Magia Fogo: $playerfireatk"), 
                          GestureDetector(
                            onTap: () {
                              acrescimo(3);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(2.0),
                              padding: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: LinearGradient(
                                begin: Alignment.bottomLeft, // Início do gradiente
                                end: Alignment.topRight, // Fim do gradiente
                                colors: [
                                  Colors.brown, // Primeira cor
                                  Colors.black, // Primeira cor
                                ],
                              ),
                              ),
                              child: const Text('+'),
                            ),
                          ),
                        ],
                      ),
                      ]
                      )
                      ),

                  TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Sair'),
                ),
        
             ] 
              ),
      ),
    )
    );
  }
}
