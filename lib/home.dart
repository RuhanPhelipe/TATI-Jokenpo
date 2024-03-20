import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyJokenpoHome extends StatefulWidget {
  const MyJokenpoHome({super.key});

  @override
  State<MyJokenpoHome> createState() => _MyJokenpoHomeState();
}

class _MyJokenpoHomeState extends State<MyJokenpoHome> {
  final List _options = ['pedra', 'papel', 'tesoura'];

  String _message = 'Quem Venceu o Jogo!!!';

  String _imgCompChoice = 'images/padrao.png';
  String _imgPlayerChoice = 'images/padrao.png';

  List _placar = [0, 0, 0];

  void _play(String playerChoice) {
    String compChoice = _options[Random().nextInt(_options.length)];

    String m;

    if (playerChoice == 'pedra' && compChoice == 'papel' ||
        playerChoice == 'papel' && compChoice == 'tesoura' ||
        playerChoice == 'tesoura' && compChoice == 'pedra') {
      m = 'Você Perdeu!!!';
      _placar[1] += 1;
    } else if (compChoice == 'pedra' && playerChoice == 'papel' ||
        compChoice == 'papel' && playerChoice == 'tesoura' ||
        compChoice == 'tesoura' && playerChoice == 'pedra') {
      m = 'Você Venceu!!!';
      _placar[0] += 1;
    } else {
      m = 'Empate!!!';
      _placar[2] += 1;
    }

    //print(compChoice);

    setState(() {
      _message = m;
      _imgPlayerChoice = 'images/$playerChoice.png';
      _imgCompChoice = 'images/$compChoice.png';
    });
  }

  List<Widget> _setButtons() {
    List<Widget> list = [];

    for (var w in _options) {
      list.add(GestureDetector(
        onTap: () => _play(w),
        child: Image.asset(
          'images/$w.png',
          width: 100,
        ),
      ));
    }

    return list;
  }

  void _reset() {
    setState(() {
      _message = 'Quem Venceu o Jogo!!!';

      _imgCompChoice = 'images/padrao.png';
      _imgPlayerChoice = 'images/padrao.png';

      _placar = [0, 0, 0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jokenpo'),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text('PLAYER',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Image.asset(_imgPlayerChoice)
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'COMP',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(_imgCompChoice)
                  ],
                ),
              ],
            ),
            Text(
              _message,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text('Placar: $_placar'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _setButtons(),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.small(
        onPressed: () => _reset(),
        child: Icon(Icons.refresh),
      ),
    );
  }
}
