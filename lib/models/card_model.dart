import 'dart:math';

enum CardAttribute {
  fire,
  water,
  earth,
  wind,
  light,
  dark,
}

extension CardAttributeExtension on CardAttribute {
  String get displayName {
    switch (this) {
      case CardAttribute.fire:
        return 'Fire';
      case CardAttribute.water:
        return 'Water';
      case CardAttribute.earth:
        return 'Earth';
      case CardAttribute.wind:
        return 'Wind';
      case CardAttribute.light:
        return 'Light';
      case CardAttribute.dark:
        return 'Dark';
    }
  }

  String get japaneseName {
    switch (this) {
      case CardAttribute.fire:
        return '炎';
      case CardAttribute.water:
        return '水';
      case CardAttribute.earth:
        return '地';
      case CardAttribute.wind:
        return '風';
      case CardAttribute.light:
        return '光';
      case CardAttribute.dark:
        return '闇';
    }
  }
}

class CardAbility {
  final String name;
  final String description;
  final int cost;

  const CardAbility({
    required this.name,
    required this.description,
    required this.cost,
  });
}

class BattleCard {
  final String name;
  final String? imagePath;
  final int attack;
  final int defense;
  final int hp;
  final CardAttribute attribute;
  final CardAbility ability;
  final int rarity;

  const BattleCard({
    required this.name,
    this.imagePath,
    required this.attack,
    required this.defense,
    required this.hp,
    required this.attribute,
    required this.ability,
    required this.rarity,
  });

  static final List<CardAbility> _abilities = [
    const CardAbility(
      name: 'Fireball',
      description: 'Deal 30 damage to enemy',
      cost: 2,
    ),
    const CardAbility(
      name: 'Shield',
      description: 'Increase defense by 20',
      cost: 1,
    ),
    const CardAbility(
      name: 'Heal',
      description: 'Restore 25 HP',
      cost: 2,
    ),
    const CardAbility(
      name: 'Thunder Strike',
      description: 'Deal 40 damage, 20% stun chance',
      cost: 3,
    ),
    const CardAbility(
      name: 'Poison',
      description: 'Deal 10 damage per turn for 3 turns',
      cost: 2,
    ),
    const CardAbility(
      name: 'Rage',
      description: 'Increase attack by 25',
      cost: 2,
    ),
    const CardAbility(
      name: 'Ice Blast',
      description: 'Deal 25 damage, slow enemy',
      cost: 2,
    ),
    const CardAbility(
      name: 'Earthquake',
      description: 'Deal 35 damage to all enemies',
      cost: 4,
    ),
    const CardAbility(
      name: 'Wind Slash',
      description: 'Deal 20 damage, attack twice',
      cost: 3,
    ),
    const CardAbility(
      name: 'Dark Curse',
      description: 'Reduce enemy attack by 15',
      cost: 2,
    ),
    const CardAbility(
      name: 'Holy Light',
      description: 'Deal 30 damage to dark enemies',
      cost: 2,
    ),
    const CardAbility(
      name: 'Drain Life',
      description: 'Deal 20 damage, heal same amount',
      cost: 3,
    ),
  ];

  static BattleCard generateRandom({
    required String name,
    String? imagePath,
  }) {
    final random = Random();
    
    final rarity = random.nextInt(5) + 1;
    
    final baseMultiplier = 1.0 + (rarity - 1) * 0.2;
    
    final attack = (random.nextInt(50) + 30 * baseMultiplier).round();
    final defense = (random.nextInt(40) + 20 * baseMultiplier).round();
    final hp = (random.nextInt(60) + 50 * baseMultiplier).round();
    
    final attribute = CardAttribute.values[random.nextInt(CardAttribute.values.length)];
    
    final ability = _abilities[random.nextInt(_abilities.length)];

    return BattleCard(
      name: name,
      imagePath: imagePath,
      attack: attack,
      defense: defense,
      hp: hp,
      attribute: attribute,
      ability: ability,
      rarity: rarity,
    );
  }

  String get rarityStars {
    return '★' * rarity + '☆' * (5 - rarity);
  }
}
