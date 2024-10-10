import 'package:jogodacobrinha/globals/globalsenemy.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/widgets.dart';

int gscore = 1;
int playerlevel = 1;
int gplayerValue = 1;
int polifenumber = 1;
int playerlife = 50;
int playerlifepoints = 50;
int playerhabpoints = 1;
int times = 900;
int playermap = 0;
bool playermission = false;
int playermissionvalue = 0;
int playerdmgnow = 5;
int enemy1life = 0;
int playergold = 0;
int playerxp = 10;
int playerxptonext = 100;
int playeritemexp = 0;
int playerAttack = 0 + playermeeleatk;
int playermeeleatk = 0;
int playerfireatk =0;
int playerwateratk = 0;
int playerradioativeatk = 0;
int playereletricatk = 0;
int playerDefense = 0;
int playerspeed = 500;
int numerodeinimigos = 0;
List<String> wordsgoodhello = ['', '', '', '', ''];
List<String> wordsbadhello = ['',];
List<Enemy> enemiesnow = [];
int moveIntervalPlayer = 500; // Intervalo de movimento dos inimigos em milissegundos
List<String> mapstittle = ['No Man`s Dungeon', 'Dungeon no Way', 'Mystery Dungeon'];
  List<String> playerpositionlist = [
    'assets/images/playerfront.png',
    'assets/images/playerback.png',
    'assets/images/playerright.png',
    'assets/images/playerleft.png',
  ];
  String currentDirection = 'centro';

Future<void> saveGameState() async {
  final prefs = await SharedPreferences.getInstance();
  
  prefs.setInt('gscore', gscore);
  prefs.setInt('playerlevel', playerlevel);
  prefs.setInt('gplayerValue', gplayerValue);
  prefs.setInt('polifenumber', polifenumber);
  prefs.setInt('playerlife', playerlife);
  prefs.setInt('playerlifepoints', playerlifepoints);
  prefs.setInt('playerhabpoints', playerhabpoints);
  prefs.setInt('times', times);
  prefs.setInt('playermap', playermap);
  prefs.setBool('playermission', playermission);
  prefs.setInt('playermissionvalue', playermissionvalue);
  prefs.setInt('playerdmgnow', playerdmgnow);
  prefs.setInt('enemy1life', enemy1life);
  prefs.setInt('playergold', playergold);
  prefs.setInt('playerxp', playerxp);
  prefs.setInt('playerxptonext', playerxptonext);
  prefs.setInt('playeritemexp', playeritemexp);
  prefs.setInt('playerAttack', playerAttack);
  prefs.setInt('playermeeleatk', playermeeleatk);
  prefs.setInt('playerfireatk', playerfireatk);
  prefs.setInt('playerwateratk', playerwateratk);
  prefs.setInt('playerradioativeatk', playerradioativeatk);
  prefs.setInt('playereletricatk', playereletricatk);
  prefs.setInt('playerDefense', playerDefense);
  prefs.setInt('playerspeed', playerspeed);
  prefs.setInt('numerodeinimigos', numerodeinimigos);
}

Future<void> loadGameState() async {
  final prefs = await SharedPreferences.getInstance();
  
  gscore = prefs.getInt('gscore') ?? 1;
  playerlevel = prefs.getInt('playerlevel') ?? 1;
  gplayerValue = prefs.getInt('gplayerValue') ?? 1;
  polifenumber = prefs.getInt('polifenumber') ?? 1;
  playerlife = prefs.getInt('playerlife') ?? 50;
  playerlifepoints = prefs.getInt('playerlifepoints') ?? 50;
  playerhabpoints = prefs.getInt('playerhabpoints') ?? 1;
  times = prefs.getInt('times') ?? 900;
  playermap = prefs.getInt('playermap') ?? 0;
  playermission = prefs.getBool('playermission') ?? false;
  playermissionvalue = prefs.getInt('playermissionvalue') ?? 0;
  playerdmgnow = prefs.getInt('playerdmgnow') ?? 5;
  enemy1life = prefs.getInt('enemy1life') ?? 0;
  playergold = prefs.getInt('playergold') ?? 0;
  playerxp = prefs.getInt('playerxp') ?? 10;
  playerxptonext = prefs.getInt('playerxptonext') ?? 100;
  playeritemexp = prefs.getInt('playeritemexp') ?? 0;
  playerAttack = prefs.getInt('playerAttack') ?? 0;
  playermeeleatk = prefs.getInt('playermeeleatk') ?? 0;
  playerfireatk = prefs.getInt('playerfireatk') ?? 0;
  playerwateratk = prefs.getInt('playerwateratk') ?? 0;
  playerradioativeatk = prefs.getInt('playerradioativeatk') ?? 0;
  playereletricatk = prefs.getInt('playereletricatk') ?? 0;
  playerDefense = prefs.getInt('playerDefense') ?? 0;
  playerspeed = prefs.getInt('playerspeed') ?? 500;
  numerodeinimigos = prefs.getInt('numerodeinimigos') ?? 0;
}

class Enemy {
  final String name;
  int health;
  final String weakness; // 'fire' ou 'water'
  final int experience;
  final String nomefoto;
  final int damageacresc;
  final int gold; 

  Enemy({
    required this.name,
    required this.health,
    required this.weakness,
    required this.experience, 
    required this.nomefoto,
    required this.damageacresc, 
    required this.gold,
  });
}

void lifeplayerDown(int x){
    playerlife -= x;
  print("Vida do jogador: $playerlife");
  if(playerlife <= 0){
    print("Você morreu!");
  }
}

void levelsUps(int xp, int gold) {
  playergold += gold;
  gplayerValue += xp;
  print("$playergold e $gplayerValue e $playerlevel");
  if (playerlevel == 1 && gplayerValue >= 100) {
    playerlevel = 2;
    gplayerValue -= 100;
    playergold += 20;
    playerxptonext = 210;
    playerlifepoints += 20;

    playerhabpoints += habilidadeacrescent(playerlevel);
  }
  if (playerlevel == 2 && gplayerValue >= 210) {
    playerlevel = 3;
    gplayerValue -= 210;
    playergold += 10;
    playerlifepoints += 30;
    playerxptonext = 350;
    playerhabpoints += habilidadeacrescent(playerlevel);
  }
  if (playerlevel == 3 && gplayerValue >= 350) {
    playerlevel = 4;
    gplayerValue -= 350;
    playergold += 50;
    playerlifepoints += 30;
    playerxptonext = 500;
    playerhabpoints += habilidadeacrescent(playerlevel);
  }
  if (playerlevel == 4 && gplayerValue >= 500) {
    playerlevel = 5;
    gplayerValue -= 500;
    playergold += 50;
    playerlifepoints += 30;
    playerxptonext = 800;
    playerhabpoints += habilidadeacrescent(playerlevel);
    newenemieslevel(playerlevel);
  }
  if (playerlevel == 5 && gplayerValue >= 800) {
    playerlevel = 6;
    gplayerValue -= 800;
    playergold += 50;
    playerlifepoints += 30;
        playerxptonext = 900;
    playerhabpoints += habilidadeacrescent(playerlevel);
  }
  if (playerlevel == 6 && gplayerValue >= 900) {
    playerlevel = 7;
    gplayerValue -= 500;
    playergold += 50;
    playerlifepoints += 30;
        playerxptonext = 1250;
    playerhabpoints += habilidadeacrescent(playerlevel);
  }
  if (playerlevel == 7 && gplayerValue >= 1250) {
    playerlevel = 8;
    gplayerValue -= 1000;
    playergold += 50;
    playerlifepoints += 30;
        playerxptonext = 0;
    playerhabpoints += habilidadeacrescent(playerlevel);
  }
  if (playerlevel == 8 && gplayerValue >= 1500) {
    playerlevel = 9;
    gplayerValue -= 1500;
    playergold += 50;
    playerlifepoints += 30;
        playerxptonext = 0;
    playerhabpoints += habilidadeacrescent(playerlevel);
  }
  
}

int bonusacrescent(value){
  if(value == 1){
    return 1;
  }
  if(value == 2){
    return 3;
  }
  if(value == 3){
    return 3;
  }
  if(value == 4){
    return 5;
  }
  if(value == 5){
    return 7;
  }
  if(value == 6){
    return 8;
  }
  if(value == 7){
    return 9;
  }
  if(value == 8){
    return 10;
  }
  if(value == 9){
    return 12;
  }
  if(value == 10){
    return 15;
  }
  if(value == 11){
    return 16;
  }
  if(value == 12){
    return 17;
  }
  if(value == 13){
    return 18;
}
  if(value == 14){
    return 19;
  }
  if(value == 15){
    return 25;
  }
  if(value == 16){
    return 35;
  }
  if(value == 17){
    return 40;
  }
  if(value == 18){
    return 45;
  }
  if(value == 19){
    return 50;
  }
  if(value == 20){
    return 75;
  }
  if(value == 21){
    return 100;
  }
  if(value == 22){
    return 125;
  }
  if(value == 23){
    return 150;
  }
  if(value == 24){
    return 200;
  }
  if(value == 25){
    return 300;
  }
  if(value == 26){
    return 400;
  }
  if(value == 27){
    return 500;
  }
  if(value == 28){
    return 600;
  }
  if(value == 29){
    return 700;
  }
  if(value == 30){
    return 800;
  }
  else{
    return 1000;
  }
}

int habilidadeacrescent(value){
  if(value == 1){
    return 1;
  }
  if(value == 2){
    return 2;
  }
  if(value == 3){
    return 1;
  }
  if(value == 4){
    return 4;
  }
  if(value == 5){
    return 1;
  }
  if(value == 6){
    return 2;
  }
  if(value == 7){
    return 1;
  }
  if(value == 8){
    return 4;
  }
  if(value == 9){
    return 1;
  }
  if(value == 10){
    return 2;
  }
  if(value == 11){
    return 1;
  }
  if(value == 12){
    return 4;
  }
  if(value == 13){
    return 1;
}
  if(value == 14){
    return 1;
  }
  if(value == 15){
    return 3;
  }
  if(value == 16){
    return 1;
  }
  if(value == 17){
    return 2;
  }
  if(value == 18){
    return 1;
  }
  if(value == 19){
    return 1;
  }
  if(value == 20){
    return 1;
  }
  if(value == 21){
    return 1;
  }
  if(value == 22){
    return 1;
  }
  if(value == 23){
    return 5;
  }
  if(value == 24){
    return 5;
  }
  if(value == 25){
    return 5;
  }
  if(value == 26){
    return 5;
  }
  if(value == 27){
    return 5;
  }
  if(value == 28){
    return 5;
  }
  if(value == 29){
    return 10;
  }
  if(value == 30){
    return 5;
  }
  else{
    return 25;
  }
}

String mapname = mapstittle[1];
/*
void lifeplayerDown(int x){
  playerlife -= x;
  print("Vida do jogador: $playerlife");
  if(lifeplayer <= 0){
    print("Você morreu!");
    exit(0);
  }
}
*/