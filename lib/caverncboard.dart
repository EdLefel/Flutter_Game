import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jogodacobrinha/boardcity.dart';
import 'package:jogodacobrinha/combats/battlescreen.dart';
import 'package:jogodacobrinha/globals/globalboards.dart';
import 'package:jogodacobrinha/globals/globals.dart';
import 'package:jogodacobrinha/globals/globalsenemy.dart';
import 'package:jogodacobrinha/items.dart';
import 'package:jogodacobrinha/joken.dart';
import 'package:jogodacobrinha/menugamemaps/statusplayer.dart';
import 'package:jogodacobrinha/menuinventorio.dart';
import 'package:jogodacobrinha/screens/joystick.dart';
import 'package:jogodacobrinha/shoping.dart';
import 'dart:math';
import 'package:jogodacobrinha/globals/globals.dart' as glob;
import 'package:jogodacobrinha/worldmap.dart';

class MyAppBoard extends StatelessWidget {
  const MyAppBoard({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'House',
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
  static const int boardSize = 10;
  static const int totalBoardSize = 32; // Tamanho total do tabuleiro

  int playerX = totalBoardSize ~/ 2;
  int playerY = totalBoardSize ~/ 2;

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
  List<Map<String, dynamic>> followingEnemies2 = []; // Lista de inimigos que seguem o jogador
  late Timer enemyMovementTimer; // Timer para movimentar os inimigos  
  List<List<String>> groundMatrix = [];
  List<String> groundstypesOne = ["ground1.png", "ground2.png", "ground3.png", "ground4.png"];
  List<List<String>> matrizcomplet =  matrizcomplet2;
  String playerboardposition = 'assets/images/playerfront.png';
  Timer? playerMovementTimer; // Timer para movimento contínuo do jogador
  String _direction = 'center';

  @override
  void initState() {
    super.initState();
    placeObjectsFromMatrix();
    spawnEnemies();
    startEnemyMovement(); // Inicia o movimento automático dos inimigos
    spawnBonuses();
    initializeGroundMatrix();
  }

  @override
  Future<void> dispose() async {
    enemyMovementTimer.cancel(); // Cancela o Timer quando o widget é destruído
    playerMovementTimer?.cancel(); // Cancelar qualquer movimento anterior
    super.dispose();
  }

    void _onJoystickDirectionChanged(String newDirection) {
      _direction = newDirection;
       if (_direction != 'center') {
        setState(() {
          startPlayerMovement(_direction);
        });
        }else{
          setState(() {
            stopPlayerMovement();
          });
        }
      //_valor = newValor;
  }
    // Inicia o Timer para mover os inimigos automaticamente a cada 500ms
  void startEnemyMovement() {
    enemyMovementTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        moveFollowingEnemies(); // Move os inimigos a cada intervalo
        moveFollowingEnemiesMatysMale();
      });
    });
  }

    void showCustomDialog(BuildContext context, int enytotal, String calltype) {
    showDialog(
      context: context,
      barrierDismissible: false,  // Fecha o diálogo ao clicar fora
      builder: (BuildContext context) {
        if(calltype == "bonuses"){
          return Dialog(
          backgroundColor: Colors.black.withOpacity(0.5),  // Fundo translucido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text( "Iniciar Batalha?",style: const TextStyle(color: Colors.white, fontFamily: 'PixelifySans'), textAlign: TextAlign.center,),
                 
                const SizedBox(height: 20),
                Center(
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Get Out (-5 life)', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    const Padding(padding: EdgeInsets.all(10),),
                    GestureDetector(
                      onTap: () async {
                        lifeplayerDown(5);
                        Navigator.of(context).pop();
                        await dispose();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyText()),
                        );                  
                        },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Start', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    ]
                    )
                )
                  ],
            ),
          ),);
        }
        else if (calltype == "enemyMantysM"){
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.5),  // Fundo translucido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text( "Iniciar Batalha?",style: const TextStyle(color: Colors.white, fontFamily: 'PixelifySans'), textAlign: TextAlign.center,),
                 
                const SizedBox(height: 20),
                Center(
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Get Out (-5 life)', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    const Padding(padding: EdgeInsets.all(10),),
                    GestureDetector(
                      onTap: () async {
                        lifeplayerDown(5);
                        Navigator.of(context).pop();
                        await dispose();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyBattle()),
                        );                  
                        },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Start', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    ]
                    )
                )
                  ],
            ),
          ),);}
           else{
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.5),  // Fundo translucido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text( "Iniciar Batalha?",style: const TextStyle(color: Colors.white, fontFamily: 'PixelifySans'), textAlign: TextAlign.center,),
                 
                const SizedBox(height: 20),
                Center(
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Get Out (-5 life)', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    const Padding(padding: EdgeInsets.all(10),),
                    GestureDetector(
                      onTap: () async {
                        lifeplayerDown(5);
                        Navigator.of(context).pop();
                        await dispose();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MyBattle()),
                        );                  
                        },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Start', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    ]
                    )
                )
                  ],
            ),
          ),);}
      });
      }

      void showCustomDialogCity(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,  // Fecha o diálogo ao clicar fora
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.black.withOpacity(0.5),  // Fundo translucido
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                Text( "Deseja ir para a cidade?",style: const TextStyle(color: Colors.white, fontFamily: 'PixelifySans'), textAlign: TextAlign.center,),
                 
                const SizedBox(height: 20),
                Center(
                  child: 
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Get Out', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    const Padding(padding: EdgeInsets.all(10),),
                    GestureDetector(
                      onTap: () async {
                          await dispose();
                          Navigator.of(context).pop();
                          Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CityBoard()),);
                        },
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(1),
                        child: Text('Go!', style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontFamily: 'PixelifySans')),
                        )
                    ),
                    ]
                    )
                )
                  ],
            ),
          ),);}
        );
      }


  String _randomground() {
    Random random = Random();
    int randomIndex = random.nextInt(groundstypesOne.length);
    return groundstypesOne[randomIndex];
  }

  static String _randomenemy() {
    Random random = Random();
    int randomIndex = random.nextInt(dungeonimg.length);
    return dungeonimg[randomIndex];
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
      } else if (matrizcomplet[y][x] == '9') {
        obstaclesType9.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '10') {
        obstaclesType10.add(Offset(x.toDouble(), y.toDouble()));
      }else if (matrizcomplet[y][x] == '11') {
        obstaclesType11.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '12') {
        obstaclesType12.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '13') {
        obstaclesType13.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '14') {
        obstaclesType14.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '15') {
        obstaclesType15.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '16') {
        obstaclesType16.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '17') {
        obstaclesType17.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '18') {
        obstaclesType18.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '19') {
        obstaclesType19.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '20') {
        obstaclesType20.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '21') {
        obstaclesType21.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '22') {
        obstaclesType22.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '23') {
        obstaclesType23.add(Offset(x.toDouble(), y.toDouble()));
      } else if (matrizcomplet[y][x] == '24') {
        obstaclesType24.add(Offset(x.toDouble(), y.toDouble()));
      }

       else if (matrizcomplet[y][x] == 'P') {
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
      else if (matrizcomplet[y][x] == 'IM') {
        followingEnemies2.add({
        'position': Offset(x.toDouble(), y.toDouble()),
        });
        }
    }
  }
}

void moveFollowingEnemies() {
  for (var enemy in followingEnemies) {
    Offset enemyPosition = enemy['position'];
    Offset playerPosition = Offset(playerX.toDouble(), playerY.toDouble());

    // Calcular a distância Manhattan entre o jogador e o inimigo
    double distanceToPlayer = (enemyPosition.dx - playerX).abs() + (enemyPosition.dy - playerY).abs();

    // Se o inimigo estiver a 9 blocos de distância ou menos, ele segue o jogador
    if (distanceToPlayer <= 9) {
      // Usa o algoritmo A* para encontrar o caminho
      List<Offset> path = aStarPathfinding(enemyPosition, playerPosition);

      // Se há um caminho disponível, move o inimigo para o próximo passo no caminho
      if (path.isNotEmpty) {
        Offset nextPosition = path[1]; // Próximo passo no caminho

        // Verifica se a posição está livre de obstáculos antes de mover
        if (!obstacles.contains(nextPosition) &&
            !obstaclesType2.contains(nextPosition) &&
            !obstaclesType3.contains(nextPosition) &&
            !obstaclesType4.contains(nextPosition) &&
            !obstaclesType5.contains(nextPosition) &&
            !obstaclesType6.contains(nextPosition) &&
            !obstaclesType7.contains(nextPosition) &&
            !obstaclesType8.contains(nextPosition) &&
            !obstaclesType10.contains(nextPosition) &&
            !obstaclesType11.contains(nextPosition) &&
            !obstaclesType12.contains(nextPosition) &&
            !obstaclesType13.contains(nextPosition) &&
            !obstaclesType14.contains(nextPosition) &&
            !obstaclesType15.contains(nextPosition) &&
            !obstaclesType16.contains(nextPosition) &&
            !obstaclesType17.contains(nextPosition) &&
            !obstaclesType18.contains(nextPosition) &&
            !obstaclesType19.contains(nextPosition) &&
            !obstaclesType20.contains(nextPosition) &&
            !obstaclesType21.contains(nextPosition) &&
            !obstaclesType22.contains(nextPosition) &&
            !obstaclesType23.contains(nextPosition) &&
            !obstaclesType24.contains(nextPosition) &&
            !obstaclesType9.contains(nextPosition)) {
          enemy['position'] = nextPosition;

          // Atualiza a direção visual do inimigo
          int dx = nextPosition.dx.toInt() - enemyPosition.dx.toInt();
          int dy = nextPosition.dy.toInt() - enemyPosition.dy.toInt();

          setState(() {
            if (dx > 0) {
              beatlemovenow = 'beatleright.gif';
            } else if (dx < 0) {
              beatlemovenow = 'beatleleft.gif';
            } else if (dy > 0) {
              beatlemovenow = 'beatlefront.gif';
            } else if (dy < 0) {
              beatlemovenow = 'beatleback.gif';
            }
          });
        }
      }
    }
  }
}

void moveFollowingEnemiesMatysMale() {
  for (var enemy2 in followingEnemies2) {
    Offset enemyPosition = enemy2['position'];
    Offset playerPosition = Offset(playerX.toDouble(), playerY.toDouble());

    // Calcular a distância Manhattan entre o jogador e o inimigo
    double distanceToPlayer = (enemyPosition.dx - playerX).abs() + (enemyPosition.dy - playerY).abs();

    // Se o inimigo estiver a 12 blocos de distância ou menos, ele segue o jogador
    if (distanceToPlayer <= 12) {
      // Usa o algoritmo A* para encontrar o caminho
      List<Offset> path = aStarPathfinding(enemyPosition, playerPosition);

      // Se há um caminho disponível, move o inimigo para o próximo passo no caminho
      if (path.isNotEmpty) {
        Offset nextPosition = path[1]; // Próximo passo no caminho

        // Verifica se a posição está livre de obstáculos antes de mover
        if (!obstacles.contains(nextPosition) &&
            !obstaclesType2.contains(nextPosition) &&
            !obstaclesType3.contains(nextPosition) &&
            !obstaclesType4.contains(nextPosition) &&
            !obstaclesType5.contains(nextPosition) &&
            !obstaclesType6.contains(nextPosition) &&
            !obstaclesType7.contains(nextPosition) &&
            !obstaclesType8.contains(nextPosition) &&
            !obstaclesType10.contains(nextPosition) &&
            !obstaclesType11.contains(nextPosition) &&
            !obstaclesType12.contains(nextPosition) &&
            !obstaclesType13.contains(nextPosition) &&
            !obstaclesType14.contains(nextPosition) &&
            !obstaclesType15.contains(nextPosition) &&
            !obstaclesType16.contains(nextPosition) &&
            !obstaclesType17.contains(nextPosition) &&
            !obstaclesType18.contains(nextPosition) &&
            !obstaclesType19.contains(nextPosition) &&
            !obstaclesType20.contains(nextPosition) &&
            !obstaclesType21.contains(nextPosition) &&
            !obstaclesType22.contains(nextPosition) &&
            !obstaclesType23.contains(nextPosition) &&
            !obstaclesType24.contains(nextPosition) &&
            !obstaclesType9.contains(nextPosition)) {
          enemy2['position'] = nextPosition;

          // Atualiza a direção visual do inimigo
          int dx = nextPosition.dx.toInt() - enemyPosition.dx.toInt();
          int dy = nextPosition.dy.toInt() - enemyPosition.dy.toInt();

          setState(() {
            if (dx > 0) {
              mantysmovesnow = 'MantisRight.gif';
            } else if (dx < 0) {
              mantysmovesnow = 'MantisLeft.gif';
            } else if (dy > 0) {
              mantysmovesnow = 'MantisFront.gif';
            } else if (dy < 0) {
              mantysmovesnow = 'MantisBack.gif';
            }
          });
        }
      }
    }
  }
}



List<Offset> aStarPathfinding(Offset start, Offset goal) {
  final List<Offset> directions = [
    const Offset(0, 1),   // baixo
    const Offset(1, 0),   // direita
    const Offset(0, -1),  // cima
    const Offset(-1, 0),  // esquerda
  ];

  List<Offset> openList = [start];
  Map<Offset, double> gScore = {start: 0.0};
  Map<Offset, double> fScore = {start: _heuristic(start, goal)};
  Map<Offset, Offset> cameFrom = {};

  Set<Offset> closedSet = {};

  while (openList.isNotEmpty) {
    // Encontra o nó na openList com o menor fScore
    openList.sort((a, b) => fScore[a]!.compareTo(fScore[b]!));
    Offset current = openList.first;

    if (current == goal) {
      return _reconstructPath(cameFrom, current);
    }

    openList.remove(current);
    closedSet.add(current);

    for (Offset direction in directions) {
      Offset neighbor = current + direction;

      // Ignora se o vizinho está fora dos limites
      if (neighbor.dx < 0 || neighbor.dy < 0 ||
          neighbor.dx >= totalBoardSize || neighbor.dy >= totalBoardSize) {
        continue;
      }

      // Ignora se o vizinho está em um obstáculo
      if (obstacles.contains(neighbor) ||
          obstaclesType2.contains(neighbor) ||
          obstaclesType2.contains(neighbor) ||
          obstaclesType3.contains(neighbor) ||
          obstaclesType4.contains(neighbor) ||
          obstaclesType5.contains(neighbor) ||
          obstaclesType6.contains(neighbor) ||
          obstaclesType7.contains(neighbor) ||
          obstaclesType8.contains(neighbor) ||
          obstaclesType10.contains(neighbor) ||
          obstaclesType11.contains(neighbor) ||
          obstaclesType12.contains(neighbor) ||
          obstaclesType13.contains(neighbor) ||
          obstaclesType14.contains(neighbor) ||
          obstaclesType15.contains(neighbor) ||
          obstaclesType16.contains(neighbor) ||
          obstaclesType17.contains(neighbor) ||
          obstaclesType18.contains(neighbor) ||
          obstaclesType19.contains(neighbor) ||
          obstaclesType20.contains(neighbor) ||
          obstaclesType21.contains(neighbor) ||
          obstaclesType22.contains(neighbor) ||
          obstaclesType23.contains(neighbor) ||
          obstaclesType24.contains(neighbor) ||
          obstaclesType9.contains(neighbor))
           {
        continue;
      }

      // Se o vizinho já está no closedSet, ignora
      if (closedSet.contains(neighbor)) continue;

      // Custo real do caminho atual
      double tentativeGScore = gScore[current]! + 1;

      if (!openList.contains(neighbor)) {
        openList.add(neighbor);
      } else if (tentativeGScore >= gScore[neighbor]!) {
        continue; // Este não é o melhor caminho
      }

      // Este caminho é o melhor até agora
      cameFrom[neighbor] = current;
      gScore[neighbor] = tentativeGScore;
      fScore[neighbor] = tentativeGScore + _heuristic(neighbor, goal);
    }
  }

  // Se não há caminho possível
  return [];
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





  void spawnEnemies() {
    final random = Random();
    enemies.clear();
    for (int i = 0; i < 20; i++) {
      int enemyX;
      int enemyY;
      do {
        enemyX = random.nextInt(totalBoardSize);
        enemyY = random.nextInt(totalBoardSize);
      } while (Offset(enemyX.toDouble(), enemyY.toDouble()) ==
              Offset(playerX.toDouble(), playerY.toDouble()) ||
          obstacles.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType2.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType3.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType4.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType5.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType6.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType7.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType8.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType9.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType10.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType11.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType12.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType13.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType14.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType15.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType16.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType17.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType18.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType19.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType20.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType21.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType22.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType23.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          obstaclesType24.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          quests.contains(Offset(enemyX.toDouble(), enemyY.toDouble())) ||
          teleports.contains(Offset(enemyX.toDouble(), enemyY.toDouble())));
      int enemyValue = random.nextInt(glob.gscore) + 1;
      enemies.add({
        'position': Offset(enemyX.toDouble(), enemyY.toDouble()),
        'value': enemyValue,
        'dungeon': _randomenemy(),
      });
    }
  }

  // Função que inicializa o terreno apenas uma vez
  void initializeGroundMatrix() {
    final random = Random();
    for (int y = 0; y < totalBoardSize; y++) {
      List<String> row = [];
      for (int x = 0; x < totalBoardSize; x++) {
        // Seleciona uma imagem aleatória para cada célula do chão
        String ground = groundstypesOne[random.nextInt(groundstypesOne.length)];
        row.add(ground);
      }
      groundMatrix.add(row);
    }
  }

  void spawnBonuses() {
    final random = Random();
    bonuses.clear();
    for (int i = 0; i < 4; i++) {
      int bonusX;
      int bonusY;
      String bonusType = i == 0 ? 'amber' : 'purple';
      do {
        bonusX = random.nextInt(totalBoardSize);
        bonusY = random.nextInt(totalBoardSize);
      } while (Offset(bonusX.toDouble(), bonusY.toDouble()) ==
              Offset(playerX.toDouble(), playerY.toDouble()) ||
          obstacles.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType2.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType3.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType4.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType5.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType6.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType7.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType8.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType9.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType10.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType11.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType12.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType13.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType14.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType15.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType16.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType17.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType18.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType19.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType20.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType21.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType22.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType23.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          obstaclesType24.contains(Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          enemies.any((enemy) =>
              enemy['position'] ==
              Offset(bonusX.toDouble(), bonusY.toDouble())) ||
          bonuses.values.contains(Offset(bonusX.toDouble(), bonusY.toDouble())));
      bonuses[bonusType] = Offset(bonusX.toDouble(), bonusY.toDouble());
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
          !obstaclesType22.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType23.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType24.contains(Offset(newX.toDouble(), newY.toDouble())) &&
          !obstaclesType9.contains(Offset(newX.toDouble(), newY.toDouble()))) {
        playerX = newX;
        playerY = newY;
        checkCollision();
      }
    });
  }

  void checkCollision() {
    for (int i = 0; i < enemies.length; i++) {
      if (enemies[i]['position'] == Offset(playerX.toDouble(), playerY.toDouble())) {
        int enemyValue = enemies[i]['value'];
        glob.enemy1life = enemyValue;
        glob.gscore += enemyValue;
        enemies.removeAt(i);
        showCustomDialog(context, 1, "enemy");
        break;
      }
      }
    for (int i = 0; i < followingEnemies.length; i++) {
      if(followingEnemies[i]['position'] == Offset(playerX.toDouble(), playerY.toDouble())){
        //int enemyValue = enemies[i]['value'];
        print(followingEnemies[i]['position']);
        followingEnemies.removeAt(i);
        showCustomDialog(context, 1, "enemy");
        break;
      }
    }
    for (int i = 0; i < followingEnemies2.length; i++) {
      if(followingEnemies2[i]['position'] == Offset(playerX.toDouble(), playerY.toDouble())){
        //int enemyValue = enemies[i]['value'];
        print(followingEnemies2[i]['position']);
        followingEnemies2.removeAt(i);
        showCustomDialog(context, 1, "enemyMantysM");
        break;
      }
    }

    if (bonuses.containsKey('amber') &&
        bonuses['amber'] == Offset(playerX.toDouble(), playerY.toDouble())) {
      glob.gscore += 1;
      bonuses.remove('amber');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MyShop()),
      );
    }

    if (bonuses.containsKey('purple') &&
        bonuses['purple'] == Offset(playerX.toDouble(), playerY.toDouble())) {
      glob.gscore += 1;
      showCustomDialog(context, 1, "bonuses");
      
    }

    if (quests.contains(Offset(playerX.toDouble(), playerY.toDouble()))) {
      quests.remove(Offset(playerX.toDouble(), playerY.toDouble()));
      addItem(itemsnews[1]);
      addItem(itemsnews[2]);
      addItem(itemsnews[0]);
      addItem(itemsnews[3]);

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Quest'),
          content: const Text('You found a quest!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    if (teleports.contains(Offset(playerX.toDouble(), playerY.toDouble()))) {
      //teleports.remove(Offset(playerX.toDouble(), playerY.toDouble()));
      showCustomDialogCity(context);
      //setState(() {
        //boardMatrix = matrizcomplet;
        //glob.playermap += 1;
      //});
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
    currentDirection = 'centro';
  }

  List<List<String>> newBoardMatrix() {
    if (glob.playermap == 1) {
      return boardMatrixRandom1;
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
          'House',
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
                 bool isFollowingEnemy2 = followingEnemies2.any(
                    (enemy2) => enemy2['position'] == position);
                Map<String, dynamic>? enemy2 = enemies.firstWhere(
                  (enemy2) => enemy2['position'] == position,
                  orElse: () => {},
                );

                String groundImage = groundMatrix[windowY][windowX];

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
                        : enemy.isNotEmpty
                            ? Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/dungeon/${enemy['dungeon']}'),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Positioned(
                                      bottom: 0,
                                      right: 1,
                                      child: Text(
                                        '${enemy['value']}',
                                        style: const TextStyle(
                                            color: Colors.white, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : isAmberBonus
                                ? Image.asset('assets/dungeon/merchant.png')
                                : isPurpleBonus
                                    ? Image.asset(
                                        'assets/dungeon/gift.png',
                                        width: 40.0,
                                        height: 40.0,
                                      )
                                    : isObstacle
                                        ? Image.asset(
                                            'assets/misc/wallout.png',
                                            fit: BoxFit.fill,
                                          )
                                        : isObstacleType2
                                            ? Image.asset(
                                                'assets/misc/walltop.png',
                                                fit: BoxFit.fill,
                                              )
                                            : isObstacleType3
                                                ? Image.asset(
                                                    'assets/misc/wall.png',
                                                    fit: BoxFit.fill,
                                                  ): isObstacleType4
                                                ? Image.asset(
                                                    'assets/misc/wallleft.png',
                                                    fit: BoxFit.fill,
                                                  ): isObstacleType5
                                                ? Image.asset(
                                                    'assets/misc/wallright.png',
                                                    fit: BoxFit.fill,
                                                  ): isObstacleType6
                                            ? Image.asset(
                                                'assets/misc/wallrighttop.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType7
                                            ? Image.asset(
                                                'assets/misc/walllefttop.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType8
                                            ? Image.asset(
                                                'assets/misc/wallrigrow.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType9
                                            ? Image.asset(
                                                'assets/misc/walllefrow.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType10
                                            ? Image.asset(
                                                'assets/misc/wallbotrowlef.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType11
                                            ? Image.asset(
                                                'assets/misc/wallbotrowrig.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType12
                                            ? Image.asset(
                                                'assets/misc/wallbotrow.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType13
                                            ? Image.asset(
                                                'assets/misc/wallcavernrow.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType14
                                            ? Image.asset(
                                                'assets/misc/topwall.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType23
                                            ? Image.asset(
                                                'assets/misc/topwall.png',
                                                fit: BoxFit.fill,
                                              ): isObstacleType24
                                            ? Image.asset(
                                                'assets/misc/topwall.png',
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
                                                                    'assets/dungeon/portal.png'),
                                                                fit: BoxFit
                                                                    .fill,
                                                              ),
                                                            ),
                                                          )
                                                        : isFollowingEnemy
                                                            ? EnemyBeatle(time: 500, value: 10, imgmove: beatlemovenow,) 
                                                            : isFollowingEnemy2
                                                            ? EnemyMantys(time: 300, value: 10, imgmove: mantysmovesnow,)
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
                  colors: [Colors.black, Colors.black],
                ),
                //borderRadius: BorderRadius.circular(10),
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
