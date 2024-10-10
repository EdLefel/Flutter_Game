import 'dart:async';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:jogodacobrinha/combats/clicks.dart';
import 'package:jogodacobrinha/globals/globals.dart' as glob;
import 'package:jogodacobrinha/globals/globalsenemy.dart';
import 'package:jogodacobrinha/caverncboard.dart';

class MyBattle extends StatelessWidget {
  const MyBattle({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: BattleScreen(),
    );
  }

}
class MyDivider extends StatelessWidget {
  const MyDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return 
 LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Container(
          width: constraints.maxWidth, 
 // A largura será igual à largura máxima disponível
          height: 1,
          color: Colors.black,
        );
      },
    );
  }
}


glob.Enemy getRandomEnemy() {
  Random random = Random();
  return enemiesList[random.nextInt(enemiesList.length)];
}

getRandomNumbers(){  
  int randomNumber = Random().nextInt(5 - 1);
  if(randomNumber > 15){
    randomNumber = 15;
  }
  glob.numerodeinimigos = randomNumber;
  return randomNumber;
}
void startCombat(int numberOfEnemies) {
    glob.enemiesnow.clear(); // Limpa a lista para garantir que não tenha restos de combates anteriores.
    for (int i = 0; i <= numberOfEnemies; i++) {
        glob.Enemy randomEnemy = getRandomEnemy();
        print("Adicionando inimigo: ${randomEnemy.name}");
        glob.enemiesnow.add(randomEnemy);
    }
    print("Iniciando combate com $numberOfEnemies inimigos.");
    print("Inimigos prontos para o combate: ${glob.enemiesnow.length}");
    print(glob.enemiesnow);
}

  void showCustomDialog(BuildContext context, String name, int lifetotal, String weakness, int xp, int dano, int gold) {
    showDialog(
      context: context,
      barrierDismissible: true,  // Fecha o diálogo ao clicar fora
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
                const Text('Informações do inimigo.',style: TextStyle(color: Colors.white, fontSize: 18),),
                const SizedBox(height: 20),
                Text( "Inimigo: $name",style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                Text( "Vida Padrão $lifetotal",style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                Text( "Fraqueza: $weakness",style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                Text( "Dano Padrão: $dano",style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                Text( "Valor de XP: $xp",style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                const SizedBox(height: 10),
                Text( "Ouro: $gold",style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                Text( "Itens drops: ?",style: const TextStyle(color: Colors.white), textAlign: TextAlign.center,),
                 
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Fechar'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

class MyAtk extends StatelessWidget {
  final String danotype;
  final String damageMessage;

  const MyAtk({super.key, required this.danotype, required this.damageMessage});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
         if (danotype == "comum"){

         return Stack(
          children: [
            Image.asset('assets/combat/sworddmg.gif'),
            Text(
              damageMessage,
              style: const TextStyle(),
              )
          ],
        );
        }else if(danotype == "fire"){
          return Stack(
          children: [
            Image.asset('assets/combat/firedmg.gif'),
            Text(
              damageMessage,
              style: const TextStyle(),
              )
          ],
        );
        }else if(danotype == "water"){
          return Stack(
          children: [
            Image.asset('assets/combat/waterdmg.gif'),
            Text(
              damageMessage,
              style: const TextStyle(),
              )
          ],
        );
        }else{
          return Stack(
          children: [
            Image.asset('assets/combat/sworddmg.gif'),
            Text(
              damageMessage,
              style: const TextStyle(),
              )
          ],
        );
        }
      },
    );
  }
}

class BattleScreen extends StatefulWidget {
  const BattleScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BattleScreenState createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {

  int playerLife = glob.playerlife;
  glob.Enemy currentEnemy = enemiesList[1];
  String currentenemyname = "none";
  int currenteenemylife = 0;
  int currentenemylifetotal = 0;
  String currentenemyweakness = "none";
  int currentenemyxp = 0;
  int currentenemygold = 0;
  String currentenemyimg = "loading";
  int currentenemydamage = 0;
  
  bool playerTurn = true;
  String turnMessage = "Turno do Player";
  String damageMessage = "";
  String damagems1 = "";
  String damagems2 = "";
  bool showDamageText = false;
  final _audioPlayer = AudioPlayer();
  int diceface = 0;
  String danotype = "sworddmg";
  String selectedMagic = "fire";
  int numin = 0;
  int numinn = 0;
  bool isButtonDisabled = false;

  
  final TextStyle myTextS = const TextStyle(
    fontSize: 18,
    //fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  final TextStyle myTextS2 = const TextStyle(
    fontSize: 18,
    //fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  final TextStyle myTextS3 = const TextStyle(
    fontSize: 16,
    //fontWeight: FontWeight.bold,
    color: Colors.white,
    backgroundColor: Colors.black,
  );
  final TextStyle myTextS4 = const TextStyle(
    fontSize: 18,
    //fontWeight: FontWeight.bold,
    color: Colors.black,
  );
  final TextStyle myTextS5 = const TextStyle(
    fontSize: 14,
    color: Colors.black,
  );
  final TextStyle myTextS6 = const TextStyle(
    fontSize: 12,
    color: Colors.black,
  );
    final TextStyle myTextS7 = const TextStyle(
    fontSize: 11,
    color: Colors.white,
  );

  Random random = Random();
  int currentImageIndex1 = 0;
  int currentImageIndex2 = 0;
  bool dadoatkdef = false;
  int counter = 0;

    @override
      void initState()  {
      super.initState();
      startCombat(getRandomNumbers());
      if (glob.enemiesnow.length > 0) {
      chamarInimigoAgora(numeroinimigoagora());
        print ("total de 0 inimigos no start");
      } 
      else {
        print("A lista de inimigos está vazia!");
         nextEnemyOrWin();
          //_showEndDialog("Masmorra sem inimigos.");
          //chamarInimigoAgora(numeroinimigoagora());
      }   // Verifique se está populada após startCombat()
      }

  List<String> imagesatk = [
    'assets/images/dice_1.png',
    'assets/images/dice_2.png',
    'assets/images/dice_3.png',
    'assets/images/dice_4.png',
    'assets/images/dice_5.png',
    'assets/images/dice_6.png',
  ];
  List<String> imagesdef = [
    'assets/images/dice_1.png',
    'assets/images/dice_2.png',
    'assets/images/dice_3.png',
    'assets/images/dice_4.png',
    'assets/images/dice_5.png',
    'assets/images/dice_6.png',
  ];

  
 int numeroinimigoagora() {
    int enemienownumber = 0;
    numin = glob.enemiesnow.length;
    if (enemienownumber <= glob.enemiesnow.length && enemienownumber > 0) {
        setState(() {
            enemienownumber += 1;
            numinn +=1;
            print(enemienownumber);
        });
        return enemienownumber;
    }
    
    else if (enemienownumber == 0){
      setState(() {
            enemienownumber += 1;
            numinn +=1;
            print('enimigo agora: $enemienownumber');
        });
      return 0;
    }
    else{
      return 0;
    }    
}


bool chamarInimigoAgora(int number) {
     if(number < enemiesList.length){
       setState(() {
        currentEnemy = glob.enemiesnow[number];
        currentenemyname = currentEnemy.name;
        currenteenemylife = currentEnemy.health + glob.gscore;
        currentenemylifetotal = currentEnemy.health + glob.gscore;
        currentenemyweakness = currentEnemy.weakness;
        currentenemyxp = currentEnemy.experience;
        currentenemyimg = currentEnemy.nomefoto;
        currentenemydamage = currentEnemy.damageacresc;
        currentenemygold = currentEnemy.gold;
        });

      return true;
    } else{
        setState(() {
        currentEnemy = glob.enemiesnow[number];
        currentenemyname = currentEnemy.name;
        currenteenemylife = currentEnemy.health + glob.gscore;
        currentenemylifetotal = currentEnemy.health + glob.gscore;
        currentenemyweakness = currentEnemy.weakness;
        currentenemyxp = currentEnemy.experience;
        currentenemyimg = currentEnemy.nomefoto;
        currentenemydamage = currentEnemy.damageacresc;
        currentenemygold = currentEnemy.gold;
        });

    return true;
    }
}


Future<void> nextEnemyOrWin() async {
    int nextIndex = glob.enemiesnow.indexOf(currentEnemy) + 1;
    if (nextIndex < glob.enemiesnow.length) {
        chamarInimigoAgora(nextIndex);
        glob.levelsUps(currentenemyxp, currentenemygold);
        numinn += nextIndex;
        setState(() {
            playerTurn = true;
            turnMessage = "Turno do Player";
        });
    } else {
        glob.levelsUps(currentenemyxp, currentenemygold);
        _showEndDialog('Você ganhou!');
    }
}

Future<void> attack() async {
    if (playerTurn && !isButtonDisabled) {
      setState(() {
        isButtonDisabled = true; 
      });
      await _rollDice();
      //await _audioPlayer.play(AssetSource('sound/atk.mp3'));

      await Future.delayed(const Duration(milliseconds: 300));

      //diceface = random.nextInt(6 - 1);
      int damageplayer = diceface+1;
      int playeratk = glob.playerAttack;
      int damagetotal = (damageplayer) + playeratk;
      damageMessage = "Você causou $damagetotal de dano!";
      damagems1 = "dano de habilidade $damageplayer";
      damagems2 = "dano de arma e bônus $playeratk ";
      currenteenemylife -= damagetotal;
      showDamage(damageMessage);

      setState(() {
        currenteenemylife -= damagetotal;
        showDamageText = true;
      });

      if (currenteenemylife <= 0) {
        currenteenemylife = 0;
        showDamageText = true;
        await nextEnemyOrWin();
      } else {
        setState(() {
          showDamageText = true;
          playerTurn = false;
          turnMessage = "Turno do Player";
        });

        await Future.delayed(const Duration(milliseconds: 2000));

        await enemyAttack();
      }

      setState(() {
        isButtonDisabled = false;
      });
    }
  }

  Future<void> enemyAttack() async {
    await Future.delayed(const Duration(milliseconds: 300));

    setState(() {
      diceface = random.nextInt(6 - 1);
      showDamageText = false;
    });

    await Future.delayed(const Duration(milliseconds: 300));

    int damage = diceface + currentenemydamage;
    damageMessage = '-$damage';
    showDamage(damageMessage);

    setState(() {
      playerLife -= damage;
      glob.playerlife -=damage;
      if (playerLife < 0) {
        playerLife = 0;
        glob.playerlife -=damage;
      }
      showDamageText = true;
    });

    if (playerLife <= 0) {
      // Tratar derrota do player
      
    } else {
      setState(() {
        playerTurn = true;
        turnMessage = "Turno do Inimigo";
      });
    }
  }

  Future<void> defend() async {
    if (playerTurn && !isButtonDisabled) {
      setState(() {
        isButtonDisabled = true;
      });
      await _rollDice();
      //await _audioPlayer.play(AssetSource('sounds/def.mp3'));
      

      setState(() {
        diceface = random.nextInt(6 - 1);
      });

      await Future.delayed(const Duration(milliseconds: 300));

      int defense = diceface + glob.playerDefense;
      String defenseText = '+$defense';
      showDamage(defenseText);

      setState(() {
        showDamageText = true;
        playerTurn = false;
        turnMessage = "Turno do Player";
      });

      await Future.delayed(const Duration(milliseconds: 2000));

      await enemyAttack();

      setState(() {
        isButtonDisabled = false;
      });
    }
  }
  Future<void> magicAttack() async {
      if (playerTurn && !isButtonDisabled) {
      setState(() {
        isButtonDisabled = true; 
        showDamageText = true;
        playerTurn = false;
        turnMessage = "Turno do Player";
      });
      await _rollDice();
      int magicDamage = diceface + 1;
      if(selectedMagic == 'fire'){
        int playeratk = glob.playerfireatk;
        int damagetotal = magicDamage + glob.playerfireatk;
        danotype = selectedMagic;
        showDamageText = true;
        damageMessage = "Você causou $damagetotal de dano!";
      damagems1 = "dano de jogada $magicDamage ";
      damagems2 = "dano de arma e bônus $playeratk ";
        currenteenemylife -= damagetotal;
        if (currentenemyweakness == 'fire') {
          damagetotal *= 2;
          damageMessage = "Causou Critico: $damagetotal de dano!"; // Dano dobrado se for fraqueza
          }
      }
      if(selectedMagic == 'water'){
        int playeratk = glob.playerwateratk;
        int damagetotal = magicDamage + glob.playerwateratk;
        danotype = selectedMagic;
        showDamageText = true;
        damageMessage = "Você causou $damagetotal de dano!";
        damagems1 = "dano de jogada $magicDamage ";
        damagems2 = "dano de  e habilidade $playeratk ";
        currenteenemylife -= damagetotal;
        if (currentenemyweakness == 'water') {
          damagetotal *= 2;
          currenteenemylife -= damagetotal;
          damageMessage = "Causou Critico: $damagetotal de dano!"; // Dano dobrado se for fraqueza
          }
      }
      if(selectedMagic == 'radioativ'){
        //int playeratk = glob.playerfireatk;
        int damagetotal = magicDamage + glob.playerradioativeatk;
        danotype = selectedMagic;
        showDamageText = true;
        damageMessage = "Você causou $damagetotal de dano!";
        damagems1 = "dano de jogada $magicDamage ";
        currenteenemylife -= damagetotal;
        if (currentenemyweakness == 'radioativ') {
          damagetotal *= 2;
          damageMessage = "Causou Critico: $damagetotal de dano!"; // Dano dobrado se for fraqueza
          }
      }
            if(selectedMagic == 'eletric'){
        //int playeratk = glob.playerfireatk;
        int damagetotal = magicDamage + glob.playereletricatk;
        danotype = selectedMagic;
        showDamageText = true;
        damageMessage = "Você causou $damagetotal de dano!";
        damagems1 = "dano de jogada $magicDamage ";
        currenteenemylife -= damagetotal;
        if (currentenemyweakness == 'eletric') {
          damagetotal *= 2;
          damageMessage = "Causou Critico: $damagetotal de dano!"; // Dano dobrado se for fraqueza
          }
      }
        await Future.delayed(const Duration(milliseconds: 500));
        setState(() {
            showDamageText = false;
        });

        if (currenteenemylife <= 0) {
            await nextEnemyOrWin();
        } else {
            await Future.delayed(const Duration(milliseconds: 500));
            enemyAttack();
        }
        setState(() {
            isButtonDisabled = false;
        });
    }
}

  Future<void> showDamage(String message) async {
    setState(() {
      damageMessage = message;
      showDamageText = true;
    });

    await Future.delayed(const Duration(milliseconds: 1000));

    setState(() {
      showDamageText = false;
    });
  }



  Future<void> _rollDice() async {
    await _audioPlayer.play(AssetSource('sound/rolling-dice.mp3'));

    Timer.periodic(const Duration(milliseconds: 80), (timer) {
      counter++;
      setState(() {
        if (dadoatkdef == true) {
          currentImageIndex1 = random.nextInt(6 - 1);
          currentImageIndex1 = diceface;
        } else {
          currentImageIndex2 = random.nextInt(6 - 1);
          currentImageIndex2 = diceface;
        }
      });

      if (counter >= 13) {
        timer.cancel();
        setState(() {
          counter = 1;
        });
      }
    });
  }

  void _showEndDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              if(message == 'Você ganhou!'){
                int bonuschance = Random().nextInt(100 - 0);
                if(bonuschance >= 80){
                Navigator.of(context).pop();
                Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => ClickChallengeApp()), (Route<dynamic> route) => false);                 
                }else{
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BoardGame()));                  
                }

              }else{
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const BoardGame()));
              }

            },
            child: const Text('Continuar...'),
          ),
        ],
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Combat Screen', style: TextStyle(color: Color.fromARGB(99, 255, 255, 255)),),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Image.asset('assets/combat/backmasmorra.png', fit: BoxFit.cover),
                Positioned.fill(
                  child: Center(
                    child: showDamageText
                        ? MyAtk(danotype: danotype, damageMessage: damageMessage)
                        : GestureDetector(
                          onTap: () {
                            showCustomDialog(context, currentenemyname, currenteenemylife, currentenemyweakness, currentenemyxp, currentenemydamage, currentenemygold );
                        
                      },
                      child:Image.asset(
                            'assets/combat/$currentenemyimg.gif',
                    ),
                          ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 10,
                  child: Column(
                    children: [
                      Text('Enemy: $currentenemyname',style: myTextS3),
                      Text('❤️: $currenteenemylife/ $currentenemylifetotal ',style: myTextS3), 
                  ],)
                  ),
              ],
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            const Divider(color: Colors.white),
            Row(
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
                              Colors.white, // Primeira cor
                            ],
                            tileMode: TileMode.clamp, 
                          ),
                      ),
                  width: 230,
                  height: 300,
                  child:  Column(
                      children: [
                        Text('Sua Vida: $playerLife', style: myTextS),
                        const MyDivider(),
                        Text(turnMessage, style: myTextS2),
                        Text(damageMessage, style: myTextS5),
                        const MyDivider(),
                        Text(damagems1, style: myTextS6),
                        Text(damagems2, style: myTextS6),
                      ],
                    ),),
            const Padding(padding: EdgeInsets.only(left: 10)),
            Row(
              children: [
                Column(
                  children: [
                      Text('total: $numinn/$numin', style: myTextS7,),
                      Text('Escolha de magia:', style: myTextS7,),
                       DropdownButton<String>(
                        dropdownColor: Colors.black,
                        focusColor: Colors.black,
                        value: selectedMagic,
                        items: <String>["defesa", "water", "fire", "radioative", "eletric", 'earth']
                            .map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, style: myTextS7,),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedMagic = newValue!;
                          });
                        },
                        ),
                const SizedBox( height: 10),
                Row(
                  children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.red,
                      ),
                      child: Transform.rotate(
                        angle: random.nextDouble() * 180,
                        child: Image.asset(
                          imagesatk[currentImageIndex1],
                          height: 40,
                        ),
                      ),
                    ),
                    const SizedBox( height: 10),
                    playerTurn ?
                    GestureDetector(
                      onTap: () {
                        if (playerTurn) {
                          attack();
                          dadoatkdef = true;
                        }
                      },
                      child: Container(
                        width: 60,
                       decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(1.0),
                        child: const Text(
                          'ATACK',
                          style:
                              TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ):  GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        width: 60,
                       decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                        ),
                        padding: const EdgeInsets.all(1.0),
                        child: const Text(
                          '----',
                          style:
                              TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox( width: 5),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.amber,
                      ),
                      child: Transform.rotate(
                        angle: random.nextDouble() * 180,
                        child: Image.asset(
                          imagesdef[currentImageIndex2],
                          height: 40,
                        ),
                      ),
                    ),
                    const SizedBox( height: 10),
                    playerTurn ?
                    GestureDetector(
                      onTap: () {
                       if (playerTurn && selectedMagic == "defesa") {
                          defend();
                          dadoatkdef = false;
                        }else{
                          magicAttack();
                          dadoatkdef = false;
                        }
                      },
                      child: Container(
                        width: 60,
                         decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                        padding: const EdgeInsets.all(1.0),
                        child: const Text(
                          'Magic',
                          style:
                              TextStyle(fontSize: 12, color: Colors.purple, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                    : GestureDetector(
                      onTap: () {
                      },
                      child: Container(
                        width: 60,
                         decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        color: Colors.white,
                      ),
                        padding: const EdgeInsets.all(1.0),
                        child: const Text(
                          '----',
                          style:
                              TextStyle(fontSize: 12, color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),])])
          ],
        ),]),
      ),
    );
  }
}
