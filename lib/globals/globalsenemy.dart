
import 'package:flutter/material.dart';
import 'package:jogodacobrinha/globals/globals.dart';

List<String> castleguardian = ['castleknight.jpeg', 'castleguardiancursed.jpeg',];
List<String> dungeonimg = ['casttle1.png', 'casttle2.png','mushroom.gif',];
List<String> beatlemove = ['beatlefront.gif', 'beatleback.gif', 'beatleright.gif', 'beatleleft.gif']; 
String beatlemovenow = 'beatlefront.gif';  
List<String> mantysmoves = ['MantisFront.gif', 'MantisBack.gif', 'MantisRight.gif', 'MantisLeft.gif']; 
String mantysmovesnow = 'MantisFront.gif';  


List<Enemy> enemiesList = [
  Enemy(name: 'Guerreiro de Masmorra', health: 1, weakness: 'fire', experience: 150, nomefoto: "guerreiro", damageacresc: 1, gold: 10),
  Enemy(name: 'Guerreiro de Masmorra Armado', health: 15, weakness: 'fire', experience: 200, nomefoto: "guerreiro2", damageacresc: 3, gold: 10),
  Enemy(name: 'Meleca Viva', health: 1, weakness: 'fire', experience: 200, nomefoto: "greenslime", damageacresc: 1, gold: 10),
  Enemy(name: 'Radioativ Bones', health: 1, weakness: 'earth', experience: 310, nomefoto: "caveiro1", damageacresc: 3, gold: 20),
  Enemy(name: 'Bad Robot', health: 1, weakness: 'water', experience: 310, nomefoto: "badrobot", damageacresc: 3, gold: 20),
  Enemy(name: 'Radioativ Bones Equiped', health: 1, weakness: 'earth', experience: 150, nomefoto: "caveiro2", damageacresc: 5, gold: 25),
  Enemy(name: 'Bat', health: 1, weakness: 'earth', experience: 200, nomefoto: "bat", damageacresc: 3, gold: 20),
  Enemy(name: 'Moss Monster', health: 1, weakness: 'water', experience: 200, nomefoto: "bushMonster", damageacresc: 3, gold: 20),
  Enemy(name: 'Mushroom Bad', health: 20, weakness: 'earth', experience: 230, nomefoto: "mushroom", damageacresc: 5, gold: 25),
  Enemy(name: 'Radioactiv Golem', health: 22, weakness: 'earth', experience: 250, nomefoto: "golemradio", damageacresc: 5, gold: 25),
  Enemy(name: 'Radioativ Golem Master', health: 30, weakness: 'earth', experience: 300, nomefoto: "golemradio2", damageacresc: 5, gold: 25),
  // Adicione mais inimigos conforme necessário
];

List<Enemy> enemieslist5level = [
  Enemy(name: 'Radioativ Bones', health: 15, weakness: 'earth', experience: 110, nomefoto: "caveiro1", damageacresc: 3, gold: 20),
  Enemy(name: 'Bad Robot', health: 15, weakness: 'water', experience: 110, nomefoto: "badrobot", damageacresc: 3, gold: 20),
  Enemy(name: 'Radioativ Bones Equiped', health: 20, weakness: 'earth', experience: 150, nomefoto: "caveiro2", damageacresc: 5, gold: 25),
];
List<Enemy> enemieslist5leveltwo = [
  Enemy(name: 'Bat', health: 15, weakness: 'earth', experience: 110, nomefoto: "bat", damageacresc: 3, gold: 20),
  Enemy(name: 'Moss Monster', health: 15, weakness: 'water', experience: 110, nomefoto: "bushMonster", damageacresc: 3, gold: 20),
  Enemy(name: 'Mushroom Bad', health: 20, weakness: 'earth', experience: 150, nomefoto: "mushroom", damageacresc: 5, gold: 25),
  Enemy(name: 'Radioactiv Golem', health: 20, weakness: 'earth', experience: 150, nomefoto: "golemradio", damageacresc: 5, gold: 25),
  Enemy(name: 'Radioativ Golem Master', health: 30, weakness: 'earth', experience: 150, nomefoto: "golemradio2", damageacresc: 5, gold: 25),

];


void newenemieslevel(playerlevel){
  if(playerlevel == 5){
    enemiesList += enemieslist5level;
    enemiesList += enemieslist5leveltwo;
    print(enemiesList.length);
  }
}

  void movePlayerImg(String direction){}

  void gameOver(){
    
  }

  
// ignore: must_be_immutable
class EnemyBeatle extends StatelessWidget {
  String imgmove;
  int time;
  int value;

  EnemyBeatle({
    super.key,
    required this.time, 
    required this.value,
    required this.imgmove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/enemys/$imgmove'),
        fit: BoxFit.fill,
      ),
    ),
  ); 
  }
}
// ignore: must_be_immutable
class EnemyMantys extends StatelessWidget {
  String imgmove;
  int time;
  int value;

  EnemyMantys({
    super.key,
    required this.time, 
    required this.value,
    required this.imgmove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
    width: 60.0,
    height: 60.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/enemys/$imgmove'),
        fit: BoxFit.fill,
      ),
    ),
  ); 
  }
}