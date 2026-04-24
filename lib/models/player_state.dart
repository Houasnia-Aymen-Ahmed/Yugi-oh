import 'card_model.dart';

class PlayerState {
  int lifePoints;
  List<YugiohCard> deck;
  List<YugiohCard> hand;
  List<YugiohCard?> monsterZone;
  List<YugiohCard?> spellTrapZone;
  List<YugiohCard> graveyard;

  PlayerState({
    this.lifePoints = 8000,
    List<YugiohCard>? deck,
    List<YugiohCard>? hand,
    List<YugiohCard?>? monsterZone,
    List<YugiohCard?>? spellTrapZone,
    List<YugiohCard>? graveyard,
  })  : deck = deck ?? [],
        hand = hand ?? [],
        monsterZone = monsterZone ?? List.filled(5, null),
        spellTrapZone = spellTrapZone ?? List.filled(5, null),
        graveyard = graveyard ?? [];

  void drawCard() {
    if (deck.isNotEmpty) {
      hand.add(deck.removeLast());
    }
  }

  bool playMonster(YugiohCard card, int zoneIndex) {
    if (!card.isMonster) return false;
    if (zoneIndex < 0 || zoneIndex >= 5) return false;
    if (monsterZone[zoneIndex] != null) return false; // Zone occupied

    if (hand.contains(card)) {
      hand.remove(card);
      monsterZone[zoneIndex] = card;
      return true;
    }
    return false;
  }
}
