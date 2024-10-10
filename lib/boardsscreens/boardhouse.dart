import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jogodacobrinha/caverncboard.dart';
import 'package:jogodacobrinha/globals/globalboards.dart';
import 'package:jogodacobrinha/globals/globals.dart';
import 'package:jogodacobrinha/globals/globalsenemy.dart';
import 'package:jogodacobrinha/globals/texts.dart';
import 'package:jogodacobrinha/items.dart';
import 'package:jogodacobrinha/menugamemaps/statusplayer.dart';
import 'package:jogodacobrinha/menuinventorio.dart';
import 'package:jogodacobrinha/screens/joystick.dart';
import 'dart:math';
import 'package:jogodacobrinha/globals/globals.dart' as glob;
import 'package:jogodacobrinha/worldmap.dart';

class HomeBoard extends StatelessWidget {
  const HomeBoard({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Board of the game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const BoardGame(),
    );
  }
}

class BoardGame extends StatefulWidget {
  const BoardGame({Key? key});

  @override
  _BoardGameState createState() => _BoardGameState();
}

class _BoardGameState extends State<BoardGame> {
  static const int boardSize = 8;
  static const int totalBoardSize = 16; // Tamanho total do tabuleiro

  int playerX = totalBoardSize ~/ 2;
  int playerY = totalBoardSize ~/ 2;
  List<Map<String, dynamic>> cementimgs = [];
  List<Map<String, dynamic>> enemies = [];
  Map<String, Offset> bonuses = {};
  Set<Offset> obstacles = {};
  Set<Offset> obstaclesType2 = {};
  Set<Offset> obstaclesType3 = {};
  Set<Offset> obstaclesType4 = {};
  Set<Offset> obstaclesType5 = {};
  Set<Offset> obstaclesType6 = {};
  Set<Offset> obstaclesType7 = {};
  Set<Offset> obstaclesType8 = {};
  Set<Offset> obstaclesType9 = {};
  Set<Offset> obstaclesType10 = {};
  Set<Offset> obstaclesType11 = {};
  Set<Offset> obstaclesType12 = {};
  Set<Offset> obstaclesType13 = {};
  Set<Offset> obstaclesType14 = {};
  Set<Offset> obstaclesType15 = {};
  Set<Offset> obstaclesType16 = {};
  Set<Offset> obstaclesType17 = {};
  Set<Offset> obstaclesType18 = {};
  Set<Offset> obstaclesType19 = {};
  // NO OBSTACLE FOR THE PLAYER
  Set<Offset> obstaclesType20 = {};
  Set<Offset> obstaclesType21 = {};
  Set<Offset> obstaclesType22 = {};
  Set<Offset> obstaclesType23 = {};
  Set<Offset> obstaclesType24 = {};
  Set<Offset> quests = {};
  Set<Offset> teleports = {};
  Set<Offset> moveenemys = {};
  bool gameover = false;
  List<Map<String, dynamic>> followingEnemies = []; // Lista de inimigos que seguem o jogador
  //late Timer enemyMovementTimer; // Timer para movimentar os inimigos  
  List<List<String>> groundMatrix = [];
  List<String> playerpositionlist = [
    'assets/images/playerfront.png',
    'assets/images/playerback.png',
    'assets/images/playerright.png',
    'assets/images/playerleft.png',
  ];
  List<List<String>> matrizcomplet =  boardHome;
  String playerboardposition = 'assets/images/playerfront.png';
  Timer? playerMovementTimer; // Timer para movimento contínuo do jogador
  String? currentDirection; // Armazena a direção atual para o movimento contínuo
  String _direction = 'center';

  @override
  void initState() {
    super.initState();
    placeObjectsFromMatrix();
  }

  @override
  void dispose() {
    super.dispose();
    playerMovementTimer?.cancel();

  }

    void _onJoystickDirectionChanged(String newDirection) {

    setState(() {
      _direction = newDirection;
          });
       if (_direction != 'center') {
          startPlayerMovement(_direction);
        }else{
          stopPlayerMovement();
        }
      //_valor = newValor;
  }

    

  String _randomground() {
    Random random = Random();
    int randomIndex = random.nextInt(groundstypesCity.length);
    return groundstypesCity[randomIndex];
  }


  String randomscemen() {
    Random random = Random();
    int randomIndex = random.nextInt(ccemens.length);
    return ccemens[randomIndex];
  }

    void spawnEnemies() {
    cementimgs.clear();
    for (int i = 0; i < 4; i++) {
      cementimgs.add({
        'img': randomscemen(),
      });
    }
  }

  void placeObjectsFromMatrix() {
  obstacles.clear();
  obstaclesType2.clear();
  obstaclesType3.clear();
  obstaclesType4.clear();
  obstaclesType5.clear();
  obstaclesType6.clear();
  obstaclesType7.clear();
  obstaclesType8.clear();
  obstaclesType9.clear();
  obstaclesType10.clear();
  obstaclesType11.clear();
  obstaclesType12.clear();
  obstaclesType13.clear();
  obstaclesType14.clear();
  obstaclesType15.clear();
  obstaclesType16.clear();
  obstaclesType17.clear();
  obstaclesType18.clear();
  obstaclesType19.clear();
  obstaclesType20.clear();
  obstaclesType21.clear();
  obstaclesType22.clear();
  obstaclesType23.clear();
  obstaclesType24.clear();

  quests.clear();
  teleports.clear();
  moveenemys.clear();

  // Vamos percorrer a matriz completa de 32x32, não apenas uma parte
  for (int y = 0; y < matrizcomplet.length; y++) {
    for (int x = 0; x < matrizcomplet[y].length; x++) {
      if (matrizcomplet[y][x] == '1') {
        obstacles.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '2') {
        obstaclesType2.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '3') {
        obstaclesType3.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '4') {
        obstaclesType4.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '5') {
        obstaclesType5.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '6') {
        obstaclesType6.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '7') {
        obstaclesType7.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '8') {
        obstaclesType8.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '9') {
        obstaclesType9.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '10') {
        obstaclesType10.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '11') {
        obstaclesType11.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '12') {
        obstaclesType12.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '13') {
        obstaclesType13.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '14') {
        obstaclesType14.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '15') {
        obstaclesType15.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '16') {
        obstaclesType16.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '17') {
        obstaclesType17.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '18') {
        obstaclesType18.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '19') {
        obstaclesType19.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '20') {
        obstaclesType20.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '21') {
        obstaclesType21.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '22') {
        obstaclesType22.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '23') {
        obstaclesType23.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '24') {
        obstaclesType24.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == 'P') {
        playerX = x;
        playerY = y;
      } else if (matrizcomplet[y][x] == 'M') {
        quests.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == 'T') {
        teleports.add(Offset(x.toDouble(), y.toDouble()));
      }
      else if (matrizcomplet[y][x] == 'I') {
        followingEnemies.add({
        'position': Offset(x.toDouble(), y.toDouble()),
        });
        }
    }
  }
}


double _heuristic(Offset a, Offset b) {
  return (a.dx - b.dx).abs() + (a.dy - b.dy).abs(); // Distância Manhattan
}

List<Offset> _reconstructPath(Map<Offset, Offset> cameFrom, Offset current) {
  List<Offset> totalPath = [current];
  while (cameFrom.containsKey(current)) {
    current = cameFrom[current]!;
    totalPath.add(current);
  }
  return totalPath.reversed.toList();
}

  // Função que inicializa o terreno apenas uma vez
  void initializeGroundMatrix() {
    final random = Random();
    for (int y = 0; y < totalBoardSize; y++) {
      List<String> row = [];
      for (int x = 0; x < totalBoardSize; x++) {
        // Seleciona uma imagem aleatória para cada célula do chão
        String ground = groundstypesCity[random.nextInt(groundstypesCity.length)];
        row.add(ground);
      }
      groundMatrix.add(row);
    }
  }

  void movePlayer(String direction) {
    //await _audioPlayer.play(AssetSource('sound/tap.mp3'));
    setState(()  {
      int newX = playerX;
      int newY = playerY;

      switch (direction) {
        case 'up':
          newY = max(0, playerY - 1);
          playerboardposition = playerpositionlist[1];
          break;
        case 'down':
          newY = min(totalBoardSize - 1, playerY + 1);
          playerboardposition = playerpositionlist[0];
          break;
        case 'left':
          newX = max(0, playerX - 1);
          playerboardposition = playerpositionlist[3];
          break;
        case 'right':
          newX = min(totalBoardSize - 1, playerX + 1);
          playerboardposition = playerpositionlist[2];
          break;
      }

      if (!obstacles.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType2.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType3.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType4.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType5.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType6.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType7.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType8.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType9.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType10.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType11.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType12.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType13.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType14.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType15.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType16.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType17.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType18.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType19.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType20.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType21.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType12.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType13.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType22.contains(Offset(newX.toDouble(), newY.toDouble()))) {
        playerX = newX;
        playerY = newY;
        checkCollision();
      }
    });
  }

  void checkCollision() {

    if (teleports.contains(Offset(playerX.toDouble(), playerY.toDouble()))) {
      teleports.remove(Offset(playerX.toDouble(), playerY.toDouble()));
        glob.playermap += 1;
        //showCustomDialNewMap(context, 'Neighborhoad Cavern');
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => MyAppBoard()), (Route<dynamic> route) => false); 
      print(playermap);
    }

     if (quests.contains(Offset(playerX.toDouble(), playerY.toDouble()))) {
      quests.remove(Offset(playerX.toDouble(), playerY.toDouble()));
      addItem(itemsnews[1]);
      addItem(itemsnews[2]);
      addItem(itemsnews[0]);
      addItem(itemsnews[3]);

      showCustomDialogMission(context, 0);
     }
  }

  void startPlayerMovement(String direction) {
    currentDirection = direction;

    playerMovementTimer?.cancel(); // Cancelar qualquer movimento anterior
    movePlayer(currentDirection!); // Executa o movimento imediatamente

    // Inicia o Timer para movimento contínuo
    playerMovementTimer = Timer.periodic(Duration(milliseconds: playerspeed), (timer) {
      movePlayer(currentDirection!);
    });
  }

  // Função para parar o movimento contínuo do jogador
  void stopPlayerMovement() {
    playerMovementTimer?.cancel();
    currentDirection = null;
    playerspeed = 500;
  }

  List<List<String>> newBoardMatrix() {
    if (glob.playermap == 1) {
      return boardHome;
    } else if (glob.playermap == 2) {
      return map2;
    } else if (glob.playermap == 3) {
      return map2ok;
    } else {
      return matrizcomplet;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Home',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              itemCount: boardSize * boardSize,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: boardSize,
              ),
              itemBuilder: (BuildContext context, int index) {
                int x = index % boardSize;
                int y = index ~/ boardSize;

                int windowX = playerX - boardSize ~/ 2 + x;
                int windowY = playerY - boardSize ~/ 2 + y;

                windowX = max(0, min(totalBoardSize - 1, windowX));
                windowY = max(0, min(totalBoardSize - 1, windowY));

                Offset position = Offset(windowX.toDouble(), windowY.toDouble());
                
                bool isPlayer = windowX == playerX && windowY == playerY;
                bool isObstacle = obstacles.contains(position);
                bool isObstacleType2 = obstaclesType2.contains(position);
                bool isObstacleType3 = obstaclesType3.contains(position);
                bool isObstacleType4 = obstaclesType4.contains(position);
                bool isObstacleType5 = obstaclesType5.contains(position);
                bool isObstacleType6 = obstaclesType6.contains(position);
                bool isObstacleType7 = obstaclesType7.contains(position);
                bool isObstacleType8 = obstaclesType8.contains(position);
                bool isObstacleType9 = obstaclesType9.contains(position);
                bool isObstacleType10 = obstaclesType10.contains(position);
                bool isObstacleType11 = obstaclesType11.contains(position);
                bool isObstacleType12 = obstaclesType12.contains(position);
                bool isObstacleType13 = obstaclesType13.contains(position);
                bool isObstacleType14 = obstaclesType14.contains(position);
                bool isObstacleType15 = obstaclesType15.contains(position);
                bool isObstacleType16 = obstaclesType16.contains(position);
                bool isObstacleType17 = obstaclesType17.contains(position);
                bool isObstacleType18 = obstaclesType18.contains(position);
                bool isObstacleType19 = obstaclesType19.contains(position);
                bool isObstacleType20 = obstaclesType20.contains(position);
                bool isObstacleType21 = obstaclesType21.contains(position);
                bool isObstacleType22 = obstaclesType22.contains(position);
                bool isObstacleType23 = obstaclesType23.contains(position);
                bool isObstacleType24 = obstaclesType24.contains(position);
                bool isQuest = quests.contains(position);
                bool isTeleport = teleports.contains(position);
                bool isAmberBonus = bonuses.containsKey('amber') && bonuses['amber'] == position;
                bool isPurpleBonus = bonuses.containsKey('purple') && bonuses['purple'] == position;
                bool isFollowingEnemy = followingEnemies.any(
                    (enemy) => enemy['position'] == position);
                Map<String, dynamic>? enemy = enemies.firstWhere(
                  (enemy) => enemy['position'] == position,
                  orElse: () => {},
                );

                String groundImage = 'groundhouse.png';

                return Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/misc/$groundImage'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: isPlayer
                        ? Container(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(playerboardposition),
                                fit: BoxFit.fill,
                              ),
                            ),
                          )
                        :  isAmberBonus
                                ? Image.asset('assets/dungeon/merchant.png')
                                : isPurpleBonus
                                    ? Image.asset(
                                        'assets/dungeon/gift.png',
                                        width: 35.0,
                                        height: 35.0,
                                      )
                                    : isObstacle
                                        ? Image.asset(
                                            'assets/misc/wallout.png',
                                            fit: BoxFit.fill,
                                          )
                                        : isObstacleType2
                                            ? Image.asset(
                                                'assets/misc/hwall.png',
                                                fit: BoxFit.fill,
                                              )
                                            : isObstacleType3
                                                ? Image.asset(
                                                    'assets/misc/hwallright.png',
                                                    fit: BoxFit.fill,
                                                  )
                                                : isObstacleType4
                                                    ? Image.asset(
                                                        'assets/misc/hwallleft.png',
                                                        fit: BoxFit.fill,
                                                      ): isObstacleType5
                                                    ? Image.asset(
                                                        'assets/misc/doorm.png',
                                                        fit: BoxFit.fill,
                                                      ): isObstacleType6
                                                    ? Image.asset(
                                                        'assets/misc/plant1.png',
                                                        fit: BoxFit.fill,
                                                      ) : isObstacleType7
                                                    ? Image.asset(
                                                        'assets/misc/pc1.png',
                                                        fit: BoxFit.fill,
                                                      )
                                                      : isObstacleType8
                                                        ? Image.asset(
                                                            'assets/misc/pc2.gif',
                                                            fit: BoxFit.fitWidth,
                                                            //width: 150,
                                                          )
                                                          : isObstacleType9
                                                        ? Image.asset(
                                                            'assets/misc/bed1.png',
                                                            fit: BoxFit.fill,
                                                            //width: 70,
                                                          ): isObstacleType10
                                                        ? Image.asset(
                                                            'assets/misc/sink1.png',
                                                            fit: BoxFit.fill,
                                                          ): isObstacleType11
                                                        ? Image.asset(
                                                            'assets/misc/sink2.png',
                                                            fit: BoxFit.fill,
                                                          ) : isObstacleType12
                                                        ? Image.asset(
                                                            'assets/misc/chair1.png',
                                                            width: 25,
                                                            //fit: BoxFit.fill,
                                                          ): isObstacleType13
                                                        ? Image.asset(
                                                            'assets/misc/bed2.png',
                                                            fit: BoxFit.fill,
                                                          ) : isObstacleType14
                                                        ? Image.asset(
                                                            'assets/misc/hwalldoor.png',
                                                            fit: BoxFit.fill,
                                                          ) : isObstacleType15
                                                        ? Image.asset(
                                                            'assets/misc/hwallext.png',
                                                            fit: BoxFit.fill,
                                                          ): isObstacleType16
                                                        ? Image.asset(
                                                            'assets/misc/hwallext.png',
                                                            fit: BoxFit.fill,
                                                          ): isObstacleType17
                                                        ? Image.asset(
                                                            'assets/misc/hwalldoor.png',
                                                            fit: BoxFit.fill,
                                                          ): isObstacleType18
                                                        ? Image.asset(
                                                            'assets/misc/hwalldoor.png',
                                                            fit: BoxFit.fill,
                                                          )
                                                              : isQuest
                                                            ? Container(
                                                                width: 20.0,
                                                                height: 20.0,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  shape: BoxShape
                                                                      .rectangle,
                                                                  color: Colors.blue,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(5),
                                                                ),
                                                                child: const Center(
                                                                  child: Text(
                                                                    '?',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize: 12),
                                                                  ),
                                                                ),
                                                              )
                                                            : isTeleport
                                                                ? Container(
                                                                    width: 50,
                                                                    height: 50,
                                                                    decoration:
                                                                        const BoxDecoration(
                                                                      image:
                                                                          DecorationImage(
                                                                        image: AssetImage(
                                                                            'assets/dungeon/portal2.png'),
                                                                        fit: BoxFit
                                                                            .fill,
                                                                      ),
                                                                    ),
                                                                  )
                                                                : isFollowingEnemy
                                                                    ? EnemyBeatle(time: 500, value: 10, imgmove: beatlemovenow,)
                                                                    : null,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(0.5),
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.brown, Colors.black],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('assets/interface/hudh.png'),
                      fit: BoxFit.fill,
                    ),),
                    child: Column(
                      children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Inventori()),
                            );
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [Colors.blue, Colors.lightBlueAccent],
                            ),
                          ),
                          child: const Text('Inventory'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          margin: const EdgeInsets.all(1.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [Colors.blue, Colors.lightBlueAccent],
                            ),
                          ),
                          child: const Text('Save'),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(5.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color.fromARGB(206, 236, 99, 137),
                              Color.fromARGB(206, 255, 0, 72),
                            ],
                          ),
                          image: const DecorationImage(image: AssetImage('assets/interface/heart.png'),
                      fit: BoxFit.fill,),
                        ),
                        ), Text(": ${glob.playerlife}/${glob.playerlifepoints}",
                            style: const TextStyle(fontSize: 18, backgroundColor: Colors.red, fontFamily: 'PixelifySans')),
                            Text('D.L.: ${glob.gscore}',
                            style: const TextStyle(
                                color: Colors.white,
                                backgroundColor: Colors.purple)),
                      
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyMap()),
                            );
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [Colors.blue, Colors.lightBlueAccent],
                            ),
                          ),
                          child: const Text('WorldMap'),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyStatus()),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1.0),
                          padding: const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black),
                            gradient: const LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [Colors.blue, Colors.lightBlueAccent],
                            ),
                          ),
                          child: const Text('Status'),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        padding: const EdgeInsets.all(5.5),
                        decoration: BoxDecoration(
                          image: const DecorationImage(image: AssetImage('assets/interface/goldp.png'),
                      fit: BoxFit.fill,),
                          border: Border.all(color: Colors.black),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            colors: [
                              Color.fromARGB(206, 184, 204, 54),
                              Colors.amber,
                            ],
                          ),
                        ),
                      ),
                      Text(": ${glob.playergold}",
                            style: const TextStyle(fontSize: 18, backgroundColor: Colors.amber)),
                                                    
                        Text(
                          'P.L.: ${glob.gplayerValue}/${glob.playerxptonext}',
                          style: const TextStyle(
                              color: Colors.white,
                              backgroundColor: Colors.purple),
                        ),
                    ],
                  ),
                ])
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Joystick(
                          size: 140,
                          onDirectionChanged: _onJoystickDirectionChanged,
                        ),
                        /*
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTapDown: (details) => startPlayerMovement('up'),
                              onTapUp: (details) => stopPlayerMovement(),
                              child: const Icon(Icons.arrow_upward),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                             GestureDetector(
                              onTapDown: (details) => startPlayerMovement('left'),
                              onTapUp: (details) => stopPlayerMovement(),
                            ),
                             GestureDetector(
                              onTapDown: (details) => startPlayerMovement('right'),
                              onTapUp: (details) => stopPlayerMovement(),
                              child: const Icon(Icons.arrow_forward),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTapDown: (details) => startPlayerMovement('down'),
                              onTapUp: (details) => stopPlayerMovement(),
                              child: const Icon(Icons.arrow_downward),
                            ),
                          ],
                        ),
                        */
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
