import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../models/player_state.dart';
import '../widgets/card_widget.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late PlayerState playerState;
  late PlayerState opponentState;

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    // Setup dummy deck
    List<YugiohCard> dummyDeck = List.generate(
      20,
      (index) => YugiohCard(
        id: 'card_$index',
        name: 'Dark Magician $index',
        description: 'The ultimate wizard in terms of attack and defense.',
        type: CardType.monster,
        attack: 2500,
        defense: 2100,
        level: 7,
      ),
    );

    playerState = PlayerState(deck: List.from(dummyDeck));
    opponentState = PlayerState(deck: List.from(dummyDeck));

    // Draw initial hand
    for (int i = 0; i < 5; i++) {
      playerState.drawCard();
      opponentState.drawCard();
    }
  }

  void _drawCard() {
    setState(() {
      playerState.drawCard();
    });
  }

  void _playMonster(YugiohCard card) {
    // Find first empty zone
    int emptyZone = playerState.monsterZone.indexWhere((c) => c == null);
    if (emptyZone != -1) {
      setState(() {
        playerState.playMonster(card, emptyZone);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Monster zones are full!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Game Screen'),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('LP: ${playerState.lifePoints}'),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Opponent Hand (hidden)
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: opponentState.hand
                      .map((c) => const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: CardWidget(isFaceDown: true),
                          ))
                      .toList(),
                ),
              ),
            ),

            // Opponent Field
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[200],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: opponentState.monsterZone.map((card) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CardWidget(card: card),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Divider
            Container(height: 2, color: Colors.black),

            // Player Field
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[300],
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: playerState.monsterZone.map((card) {
                      return Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: CardWidget(card: card),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),

            // Player Hand
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.blue[50],
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Your Hand', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: playerState.hand.map((card) {
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: CardWidget(
                                card: card,
                                onTap: () => _playMonster(card),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _drawCard,
        tooltip: 'Draw Card',
        child: const Icon(Icons.style),
      ),
    );
  }
}
