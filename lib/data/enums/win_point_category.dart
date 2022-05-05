class _MarketCategoryExtension {
  static List<String> categories = [
    "All",
    "Ship",
    "Weapon",
    "Energy Generator",
    "Shield Generator",
  ];
}

enum MarketCategory {
  All,
  Ship,
  Weapon,
  EnergyGenerator,
  ShieldGenerator,
}

enum MarketDirection {
  asc,
  desc,
}

extension MarketCategoryExtension on MarketCategory {
  String get getCategoryName {
    return _MarketCategoryExtension.categories[this.index];
  }
}
