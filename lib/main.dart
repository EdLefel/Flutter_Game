import 'package:flutter/material.dart';
import 'package:jogodacobrinha/boardcity.dart';
import 'package:jogodacobrinha/boardsscreens/boardhouse.dart';
import 'package:jogodacobrinha/caverncboard.dart';
import 'package:jogodacobrinha/cutscenes/intro.dart';
import 'package:jogodacobrinha/screens/playhouse.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> with SingleTickerProviderStateMixin {
  //late AnimationController _controller;
  //late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
/*
    // Controlador da animação
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(); // Repete indefinidamente

    // Animação que move o background horizontalmente
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  */
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
          color: Colors.black,
          /*
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Transform.translate(
                //offset: Offset(_animation.value * MediaQuery.of(context).size.width, 0),
                child: child,
              );
            },
            */
            child: Image.asset(
              'assets/screens/SpaceBackground.png', // Insira sua imagem de background
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width, // Para criar o efeito de transição horizontal
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MenuButton(
                  imagePath: 'assets/screens/newgame.gif', // Caminho da imagem do botão "New Game"
                  label: 'New Game',
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Intro()), (Route<dynamic> route) => false); 
                  },
                ),
                SizedBox(height: 20),
                
                MenuButton(
                  imagePath: 'assets/screens/config.png', // Caminho da imagem do botão "Save Game"
                  label: 'Save Game',
                  onTap: () {
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => CityBoard()), (Route<dynamic> route) => false); 
                  },
                ),
                
                SizedBox(height: 20),
                MenuButton(
                  imagePath: 'assets/screens/credits.png', // Caminho da imagem do botão "Credits"
                  label: 'Credits',
                  onTap: () {
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyAppBoard()), (Route<dynamic> route) => false); 
                    // Ação para créditos
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String imagePath;
  final String label;
  final VoidCallback onTap;

  MenuButton({
    required this.imagePath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 70,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[300],
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
