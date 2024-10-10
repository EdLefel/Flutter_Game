
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:jogodacobrinha/globals/globals.dart' as glob;
import 'package:jogodacobrinha/caverncboard.dart';

class ClickChallengeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Desafio de Clique',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ClickChallengeScreen(),
    );
  }
}

class ClickChallengeScreen extends StatefulWidget {
  @override
  _ClickChallengeScreenState createState() => _ClickChallengeScreenState();
}

class _ClickChallengeScreenState extends State<ClickChallengeScreen> {
  int _clickCount = 0;
  Timer? _timer;
  int _remainingTime = 20; // Tempo restante
  bool _isPlaying = false;
  int _playerscore = 160;
  double _scale = 1.0;
  final _audioPlayer = AudioPlayer();
  String _lockImage = 'assets/cadeado.png'; // Imagem inicial do cadeado

  int _timeLimit(int parametro) {
    var resultado = parametro;
    if (glob.playeritemexp == 0) {
      resultado = parametro;
    }
    if (glob.playeritemexp == 1) {
      resultado = parametro * glob.gscore;
    }
    return resultado.toInt();
  }

  void _startChallenge() {
    setState(() {
      _clickCount = 0;
      _remainingTime = _timeLimit(20);
      _isPlaying = true;
      _lockImage = 'assets/cadeado.png'; // Restaura a imagem inicial ao reiniciar
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _remainingTime--;
        if (_remainingTime <= 0) {
          _endChallenge();
        }
      });
    });
  }

  void _endChallenge() {
    _timer?.cancel();
    setState(() {
      _isPlaying = false;
    });

    if (_clickCount >= _playerscore) {
      _lockImage = 'assets/cadeado_quebrado.png'; // Troca a imagem do cadeado se vencer
      _showResultDialog('Parabéns! Você venceu!');
    } else {
      _showResultDialog('Você perdeu!');
    }
  }

  void _showResultDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => BoardGame()), (Route<dynamic> route) => false); 
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  void _handleClick() {
    if (_isPlaying) {
      setState(() {
        _clickCount++;
        _animateContainer(); // Inicia a animação
        _playSound(); // Reproduz o som
        if (_clickCount >= _playerscore) {
          _endChallenge();
        }
      });
    }
  }

  void _animateContainer() {
    setState(() {
      _scale = 1.2;
    });
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        _scale = 1.0;
      });
    });
  }

  void _playSound() async {
    await _audioPlayer.play(AssetSource('click_sound.wav'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadeado do Báu'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_isPlaying) ...[
              Text(
                'Tempo Restante: $_remainingTime s',
                style: TextStyle(fontSize: 24),
              ),
              Text(
                'Cliques: $_clickCount/$_playerscore',
                style: TextStyle(fontSize: 24),
              ),
              GestureDetector(
                onTap: _handleClick,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 100),
                  width: 100 * _scale,
                  height: 100 * _scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(_lockImage), // Usa a imagem atual
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ] else ...[
               const Text(
                'Quebre o cadeádo do báu para obter a recompensa, você precisa ser rápido antes que a masmorra se destrua.',
                style: TextStyle(fontSize: 24),
              ),
              GestureDetector(
                onTap: _startChallenge,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(_lockImage), // Usa a imagem inicial
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
