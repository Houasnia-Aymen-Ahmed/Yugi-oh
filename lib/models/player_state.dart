import 'card_model.dart';

class PlayerState {
  static const int maxMonsterZones = 5;
  static const int maxSpellTrapZones = 5;

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
        monsterZone = monsterZone ?? List.filled(maxMonsterZones, null),
        spellTrapZone = spellTrapZone ?? List.filled(maxSpellTrapZones, null),
        graveyard = graveyard ?? [];

  void drawCard() {
    if (deck.isNotEmpty) {
      hand.add(deck.removeLast());
    }
  }

  bool playMonster(YugiohCard card, int zoneIndex) {
    if (!card.isMonster) return false;
    if (zoneIndex < 0 || zoneIndex >= monsterZone.length) return false;
    if (monsterZone[zoneIndex] != null) return false; // Zone occupied

    if (hand.contains(card)) {
      hand.remove(card);
      monsterZone[zoneIndex] = card;
      return true;
    }
    return false;
  }
}
