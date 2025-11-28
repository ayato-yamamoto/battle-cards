import 'dart:io';
import 'package:flutter/material.dart';
import '../models/card_model.dart';

class TradingCardWidget extends StatelessWidget {
  final BattleCard card;
  final double width;
  final double height;

  const TradingCardWidget({
    super.key,
    required this.card,
    this.width = 300,
    this.height = 420,
  });

  Color _getAttributeColor() {
    switch (card.attribute) {
      case CardAttribute.fire:
        return Colors.red.shade700;
      case CardAttribute.water:
        return Colors.blue.shade700;
      case CardAttribute.earth:
        return Colors.brown.shade700;
      case CardAttribute.wind:
        return Colors.green.shade700;
      case CardAttribute.light:
        return Colors.amber.shade600;
      case CardAttribute.dark:
        return Colors.purple.shade900;
    }
  }

  Color _getAttributeAccentColor() {
    switch (card.attribute) {
      case CardAttribute.fire:
        return Colors.orange.shade300;
      case CardAttribute.water:
        return Colors.cyan.shade300;
      case CardAttribute.earth:
        return Colors.brown.shade300;
      case CardAttribute.wind:
        return Colors.lightGreen.shade300;
      case CardAttribute.light:
        return Colors.yellow.shade200;
      case CardAttribute.dark:
        return Colors.deepPurple.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    final attributeColor = _getAttributeColor();
    final accentColor = _getAttributeAccentColor();

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            attributeColor,
            attributeColor.withOpacity(0.8),
            accentColor.withOpacity(0.6),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: attributeColor.withOpacity(0.5),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: Colors.amber.shade300,
          width: 3,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _buildHeader(attributeColor),
            const SizedBox(height: 6),
            _buildImageSection(),
            const SizedBox(height: 6),
            _buildStatsSection(attributeColor),
            const SizedBox(height: 4),
            _buildAbilitySection(attributeColor),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(Color attributeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade400, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              card.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 2,
                  ),
                ],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: attributeColor,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.white54, width: 1),
            ),
            child: Text(
              card.attribute.japaneseName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageSection() {
    return Expanded(
      flex: 5,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.shade400, width: 2),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: card.imagePath != null
              ? Image.file(
                  File(card.imagePath!),
                  fit: BoxFit.cover,
                )
              : Container(
                  color: Colors.grey.shade800,
                  child: const Center(
                    child: Icon(
                      Icons.image,
                      size: 60,
                      color: Colors.grey,
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildStatsSection(Color attributeColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber.shade400, width: 1),
      ),
      child: Column(
        children: [
          Text(
            card.rarityStars,
            style: TextStyle(
              color: Colors.amber.shade400,
              fontSize: 14,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatItem('ATK', card.attack, Colors.red.shade400),
              _buildStatItem('DEF', card.defense, Colors.blue.shade400),
              _buildStatItem('HP', card.hp, Colors.green.shade400),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 10,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toString(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildAbilitySection(Color attributeColor) {
    return Expanded(
      flex: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.shade400, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: Colors.amber.shade400,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  card.ability.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Cost: ${card.ability.cost}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Text(
                card.ability.description,
                style: TextStyle(
                  color: Colors.grey.shade300,
                  fontSize: 10,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
