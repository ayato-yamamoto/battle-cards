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
      name: 'ファイアボール',
      description: '敵に30ダメージを与える',
      cost: 2,
    ),
    const CardAbility(
      name: 'シールド',
      description: '防御力を20上昇させる',
      cost: 1,
    ),
    const CardAbility(
      name: 'ヒール',
      description: 'HPを25回復する',
      cost: 2,
    ),
    const CardAbility(
      name: 'サンダーストライク',
      description: '40ダメージ、20%でスタン',
      cost: 3,
    ),
    const CardAbility(
      name: 'ポイズン',
      description: '3ターン毎ターン10ダメージ',
      cost: 2,
    ),
    const CardAbility(
      name: 'レイジ',
      description: '攻撃力を25上昇させる',
      cost: 2,
    ),
    const CardAbility(
      name: 'アイスブラスト',
      description: '25ダメージ、敵を減速',
      cost: 2,
    ),
    const CardAbility(
      name: 'アースクエイク',
      description: '全ての敵に35ダメージ',
      cost: 4,
    ),
    const CardAbility(
      name: 'ウィンドスラッシュ',
      description: '20ダメージを2回与える',
      cost: 3,
    ),
    const CardAbility(
      name: 'ダークカース',
      description: '敵の攻撃力を15減少させる',
      cost: 2,
    ),
    const CardAbility(
      name: 'ホーリーライト',
      description: '闇属性の敵に30ダメージ',
      cost: 2,
    ),
    const CardAbility(
      name: 'ドレインライフ',
      description: '20ダメージを与え同量回復',
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

  int get cardCost {
    final statScore = attack + defense + (hp / 2).round();
    final rarityBonus = rarity * 20;
    final abilityBonus = ability.cost * 10;
    final totalScore = statScore + rarityBonus + abilityBonus;
    final rawCost = (totalScore / 60).round();
    return rawCost.clamp(1, 12);
  }
}
