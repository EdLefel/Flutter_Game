import 'dart:async';

import 'package:flutter/material.dart';
import 'dart:math';

import 'package:jogodacobrinha/globals/globals.dart';


class MyJoy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: JoystickPage(),
    );
  }
}

class JoystickPage extends StatefulWidget {
  @override
  _JoystickPageState createState() => _JoystickPageState();
}

class _JoystickPageState extends State<JoystickPage> {
  String _direction = 'Centro';

  void _onDirectionChanged(String newDirection) {
    setState(() {
      _direction = newDirection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Joystick Flutter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Joystick(
              size: 100,
              onDirectionChanged: _onDirectionChanged,
            ),
            SizedBox(height: 20),
            Text(
              'Direção: $_direction',
              style: TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}

class Joystick extends StatefulWidget {
  final double size;
  final Function(String) onDirectionChanged;

  Joystick({required this.size, required this.onDirectionChanged});

  @override
  _JoystickState createState() => _JoystickState();
}

class _JoystickState extends State<Joystick> {
  Offset _joystickPosition = Offset(0, 0); // Posição atual do joystick
  Offset _origin = Offset(0, 0); // Centro do joystick
  double _maxDistance = 150.0; // Distância máxima que o joystick pode mover
  String _currentDirection = 'Centro'; // Direção atual
  Timer? _speedTimer;

  @override
  void initState() {
    super.initState();
    _maxDistance = widget.size / 2 - 30; // Ajusta a distância máxima com base no tamanho do joystick

    @override
  void dispose() {
    // Cancela o timer quando o widget é descartado
    _speedTimer?.cancel();
    super.dispose();
  }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) {
        _origin = details.localPosition; // Define o centro
      },
      onPanUpdate: (details) {
        setState(() {
          Offset offset = details.localPosition - _origin;

          if (offset.distance <= _maxDistance) {
            _joystickPosition = offset;
          } else {
            _joystickPosition = Offset(
              _maxDistance * cos(offset.direction),
              _maxDistance * sin(offset.direction),
            );
          }

          String newDirection = _getDirection(offset);
          if (newDirection != _currentDirection) {
            _currentDirection = newDirection;
            widget.onDirectionChanged(_currentDirection);
          }
        });
      },
      onPanEnd: (details) {
        setState(() {
          _joystickPosition = Offset(0, 0); // Reseta a posição
          _currentDirection = 'Centro'; // Reseta a direção
          widget.onDirectionChanged(_currentDirection);
        });
      },
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: const BoxDecoration(
          color: Color.fromARGB(67, 52, 1, 1),
          shape: BoxShape.circle,
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: (widget.size / 2) + _joystickPosition.dx - 30,
              top: (widget.size / 2) + _joystickPosition.dy - 30,
              child: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(127, 122, 186, 234),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDirection(Offset offset) {
    if (offset.dy.abs() > offset.dx.abs()) {
      // Movimento vertical
      if (offset.dy > 1) {
          timeplayerspeed();
           return 'down';
      } else {
        timeplayerspeed();
        return 'up';
      }
    } else {
      // Movimento horizontal
      if (offset.dx > 5) {
        timeplayerspeed();
        return 'right';
      } else {
        timeplayerspeed();
        return 'left';
      }
    }
  }

void timeplayerspeed() {
    // Cancela qualquer timer existente antes de iniciar um novo
    _speedTimer?.cancel();

    _speedTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) { // Verifica se o widget ainda está montado antes de chamar setState
       playerspeed = 200;
      } else {
        timer.cancel(); // Cancela o timer se o widget não estiver mais montado
      }
    });
  }
}