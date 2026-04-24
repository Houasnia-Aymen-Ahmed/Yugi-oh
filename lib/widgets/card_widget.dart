import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardWidget extends StatelessWidget {
  final YugiohCard? card;
  final bool isFaceDown;
  final VoidCallback? onTap;
  final double width;
  final double height;

  const CardWidget({
    super.key,
    this.card,
    this.isFaceDown = false,
    this.onTap,
    this.width = 60,
    this.height = 87, // ~ Yu-Gi-Oh card aspect ratio
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(4),
          color: isFaceDown
              ? Colors.brown // Card back (has precedence over null card)
              : card == null
                  ? Colors.transparent // Empty zone
                  : _getCardColor(card!.type),
        ),
        child: _buildCardContent(),
      ),
    );
  }

  Widget _buildCardContent() {
    if (isFaceDown) {
      return const Center(
        child: Icon(Icons.circle, color: Colors.orange, size: 20), // Placeholder back
      );
    }
    if (card == null) {
      return const SizedBox(); // Empty zone
    }

    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            card!.name,
            style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
          if (card!.isMonster)
            Text(
              '${card!.attack}/${card!.defense}',
              style: const TextStyle(fontSize: 8),
            ),
        ],
      ),
    );
  }

  Color _getCardColor(CardType type) {
    switch (type) {
      case CardType.monster:
        return Colors.orange[200]!; // Normal monster color approx
      case CardType.spell:
        return Colors.green[200]!;
      case CardType.trap:
        return Colors.pink[200]!;
    }
  }
}
