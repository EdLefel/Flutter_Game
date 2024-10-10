/*
import 'package:flutter/material.dart';
import 'package:flutter_spinning_wheel/flutter_spinning_wheel.dart';
import 'dart:math';


class LuckyWheelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Roleta da Sorte',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LuckyWheelScreen(),
    );
  }
}

class LuckyWheelScreen extends StatefulWidget {
  @override
  _LuckyWheelScreenState createState() => _LuckyWheelScreenState();
}

class _LuckyWheelScreenState extends State<LuckyWheelScreen> {
  final List<String> _items = [
    'Poção de Vida',
    'Poção de Stamina',
    'Poção de Mana',
    'Nada',
    'Veneno',
    'Tente de Novo',
    'Quase Conseguiu',
    'XP em Dobro'
  ];

  final _wheelNotifier = StreamController<int>();

  @override
  void dispose() {
    _wheelNotifier.close();
    super.dispose();
  }

  void _spinWheel() {
    final random = Random();
    final selected = random.nextInt(_items.length);
    _wheelNotifier.add(selected);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Roleta da Sorte'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              Image.asset('assets/wheel.png'), // Coloque a imagem da sua roleta aqui
              width: 300,
              height: 300,
              dividers: _items.length,
              onUpdate: (int selected) {
                setState(() {
                  // Atualiza o estado se necessário
                });
              },
              onEnd: (int selected) {
                _showResultDialog(_items[selected]);
              },
              shouldStartOrStop: _wheelNotifier.stream,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text('Girar Roleta'),
            ),
          ],
        ),
      ),
    );
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text('Resultado: $result'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
*/
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:jogodacobrinha/globals/globals.dart';
import 'dart:math';

import 'package:jogodacobrinha/items.dart';

void main() {
  runApp(LuckyWheelApp());
}

class LuckyWheelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Barra da sorte',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LuckyWheelScreen(),
    );
  }
}

class LuckyWheelScreen extends StatefulWidget {
  @override
  _LuckyWheelScreenState createState() => _LuckyWheelScreenState();
}

class _LuckyWheelScreenState extends State<LuckyWheelScreen> {
  final List<String> _items = [
    'Life Potion',
    '3 Life Potions',
    '500 golden coins',
    '2500 golden coins',
    'F&Ck U',
    '10 Life Potions',
    '5 golden coins',
    '10 golden coins',
    '15 golden coins',
    '20 golden coins',
    '25 golden coins',
    '30 golden coins',
    '35 golden coins',
    '40 golden coins',
    '45 golden coins',
    '50 golden coins',
    '55 golden coins',
    '60 golden coins',
    '5 Life Potions',
    'Life Potion',
    '2 Life Potions',
    '7 Life Potions'
  ];

  StreamController<int> _selected = StreamController<int>();

  @override
  void dispose() {
    _selected.close();
    super.dispose();
  }

  void _spinWheel() {
    final random = Random();
    final selected = random.nextInt(_items.length);
    _selected.add(selected);
  }

  void _showResultDialog(String result) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text('Result: $result'),
        actions: [
          TextButton(
            onPressed: () {
              if (result == "Life Potion"){
                addItem(itemsnews[1]);
              }
              else if(result == "5 golden coins"){
                playergold += 5;
              }
              else if(result == "10 golden coins"){
                playergold += 10;
              }
              else if(result == "15 golden coins"){
                playergold += 15;
              }
              else if(result == "20 golden coins"){
                playergold += 20;
              }
              else if(result == "25 golden coins"){
                playergold += 25;
              }
              else if(result == "30 golden coins"){
                playergold += 30;
              }
              else if(result == "35 golden coins"){
                playergold += 35;
              }
              else if(result == "40 golden coins"){
                playergold += 40;
              }
              else if(result == "45 golden coins"){
                playergold += 45;
              }
              else if(result == "50 golden coins"){
                playergold += 50;
              }
              else if(result == "55 gold coins"){
                playergold += 55;
              }
              else if(result == "F&Ck U"){
                playerlife -= 15;
              }

              Navigator.of(ctx).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Good Lucky'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: FortuneBar(
                selected: _selected.stream,
                items: [
                  for (var item in _items)
                    FortuneItem(
                      child: Text(item),
                    ),
                ],
                onAnimationEnd: () {
                  //final selectedValue = _items[_selected.stream(value)];
                  //_showResultDialog(selectedValue);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _spinWheel,
              child: Text('Girar Roleta'),
            ),
          ],
        ),
      ),
    );
  }
}
