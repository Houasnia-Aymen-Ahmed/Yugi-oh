enum CardType { monster, spell, trap }

class YugiohCard {
  final String id;
  final String name;
  final String description;
  final CardType type;
  final int? attack;
  final int? defense;
  final int? level;
  final String imageUrl;

  YugiohCard({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.attack,
    this.defense,
    this.level,
    this.imageUrl = '',
  });

  bool get isMonster => type == CardType.monster;
}
