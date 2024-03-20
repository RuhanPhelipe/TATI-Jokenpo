import 'dart:math';

import 'package:flutter/material.dart';

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

  // This method verify who wins then update the screen state
  void _play(String playerChoice) {
    String compChoice = _options[Random().nextInt(_options.length)];

    String m;

    if (playerChoice == 'pedra' && compChoice == 'papel' ||
        playerChoice == 'papel' && compChoice == 'tesoura' ||
        playerChoice == 'tesoura' && compChoice == 'pedra') {
      m = 'Você Perdeu!!!';
      _placar[1] += 1;
    } else if (compChoice == playerChoice) {
      m = 'Empate!!!';
      _placar[2] += 1;
    } else {
      m = 'Você Venceu!!!';
      _placar[0] += 1;
    }

    setState(() {
      _message = m;
      _imgPlayerChoice = 'images/$playerChoice.png';
      _imgCompChoice = 'images/$compChoice.png';
    });
  }

  // This method create the Widget that will act like 'buttons' to trigger the method _play()
  List<Widget> _setButtons() {
    List<Widget> widgetList = [];

    for (var option in _options) {
      widgetList.add(GestureDetector(
        onTap: () => _play(option),
        child: Image.asset(
          'images/$option.png',
          width: 100,
        ),
      ));
    }

    return widgetList;
  }

  // This method resets the state to its initial values
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
                    Text('JOGADOR',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Image.asset(_imgPlayerChoice)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text('VS',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ),
                Column(
                  children: [
                    Text(
                      'COMPUTADOR',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(_imgCompChoice)
                  ],
                ),
              ],
            ),
            SizedBox(height: 32),
            Text(
              _message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _setButtons(),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                counterWrapCircle('Vitórias', _placar[0].toString()),
                counterWrapCircle('Derrotas', _placar[1].toString()),
                counterWrapCircle('Empates', _placar[2].toString())
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _reset(),
        child: Icon(Icons.refresh),
      ),
    );
  }

  Widget counterWrapCircle(String textTop, String textBottom) {
    return SizedBox(
      height: 90,
      width: 90,
      child: ClipOval(
        child: Material(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                textTop,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                textBottom,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )
            ],
          ),
          color: Colors.amberAccent,
        ),
      ),
    );
  }
}
