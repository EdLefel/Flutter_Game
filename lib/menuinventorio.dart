import 'package:flutter/material.dart';
import 'package:jogodacobrinha/globals/globals.dart';
import 'package:jogodacobrinha/items.dart';

class Inventori extends StatefulWidget {
  const Inventori({super.key});

  @override
  State<Inventori> createState() => _InventoriState();
}

class _InventoriState extends State<Inventori> {
  void equipItem(Item item) {
    setState(() {
      if (item.tipo == 0) {
        equippedItems['helmet'] = item.imagePath;
        playerDefense = item.valor;
      } else if (item.tipo == 2) {
        equippedItems['body'] = item.imagePath;
        playerDefense = item.valor;
      } else if (item.tipo == 3) {
        equippedItems['pants'] = item.imagePath;
        playerDefense = item.valor;
      } else if (item.tipo == 4) {
        equippedItems['boots'] = item.imagePath;
        playerDefense = item.valor;
      } else if (item.tipo == 1) {
        equippedItems['hand1'] = item.imagePath;
        setState(() {
          playermeeleatk = item.valor;
        });
        print(playerAttack);
      }
    });
  }

    void usedItemPL(Item item) {
      if (item.valor == 25 && polifenumber > 1){
        playerlife += 25;
      }
    }


  void showOptions(Item item) {
    if (item.tipo == 5) {
      showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opções para ${item.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Usar'),
                onTap: () {
                  Navigator.pop(context);
                  usedItemPL(item);
                },
              ),
              ListTile(
                title: const Text('Excluir'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    removeItem(item);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
    }
    else{
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Opções para ${item.name}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: const Text('Equipar'),
                onTap: () {
                  Navigator.pop(context);
                  equipItem(item);
                },
              ),
              ListTile(
                title: const Text('Excluir'),
                onTap: () {
                  Navigator.pop(context);
                  setState(() {
                    removeItem(item);
                  });
                },
              ),
            ],
          ),
        );
      },
    );
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[600],
      appBar: AppBar(
        backgroundColor: Colors.lime,
        title: const Text('Inventori'),
      ),
      body: Container(
              decoration: BoxDecoration(
                /*
                gradient: const LinearGradient(
                  begin: Alignment.topCenter, // Início do gradiente
                  end: Alignment.bottomCenter, // Fim do gradiente
                  colors: [
                    Colors.black, // Primeira cor
                    Colors.brown, // Primeira cor
                  ],
                ),
                */
                color: Colors.brown,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
               children: [
          //SingleChildScrollView(
            //scrollDirection: Axis.horizontal,
            //child: 
            Row(
              children: [
                buildEquippedItemContainer('helmet'),
                buildEquippedItemContainer('body'),
  
              ],
            ),
            Row(
              children: [
                buildEquippedItemContainer('pants'),
                buildEquippedItemContainer('boots'),

              ],
            ),
            Row(
              children: [
               
                buildEquippedItemContainer('hand1'),
                buildEquippedItemContainer('hand2'),
              ],
            ),
            const Divider(
              color: Colors.black,
              thickness: 5.0,
            ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(items.length, (index) {
                  final item = items[index];
                  return GestureDetector(
                    onTap: () {
                      showOptions(item);
                    }, 
                    child:
                    Container(
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(2.0),
                       decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.black),
                      ),
                      child: Expanded( 
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(item.imagePath),
                          Text(item.name),
                        ],
                      ),
                    ),
                  ));
                }),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }

  Widget buildEquippedItemContainer(String slot) {
    return GestureDetector(
      onTap: () {
        print("$slot container clicked");
      },
        child: Container(
        width: 110.0,
        height: 150.0,
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        color: Colors.grey[400],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(equippedItems[slot]!),
            Text(slot),
          ],
        ),
      ),
    );
  }
}
