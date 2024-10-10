import 'package:flutter/material.dart';
//import 'package:jogodacobrinha/globals.dart';

class MyMap extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Castle Dungeon',
      theme: ThemeData.dark(),  // Tema escuro
      home: Scaffold(
        appBar: AppBar(
          title: const Text('World Map'),
        ),
        backgroundColor: Colors.black,  // Fundo preto
        body: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/maps/worldmappopulis.png', // Certifique-se de que o caminho para a imagem esteja correto
                  width: double.infinity,
                  height: 400,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  left: 200,
                  top: 250,
                  child: Container(
                    color: Colors.amber,
                    width: 10,
                    height: 10,
                    )
                    //text: hellotext,
                  //),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('back'),
                ),
              ],)
          ],
        ),
      ),
    );
  }
}