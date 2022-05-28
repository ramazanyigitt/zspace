class AppImages {
  static final _AppImagesShips ships = _AppImagesShips();
  static final _AppImagesLasers lasers = _AppImagesLasers();
  static final _AppImagesExplosions explosions = _AppImagesExplosions();
  static final _AppImagesRockets rockets = _AppImagesRockets();

  static final loading = 'loading.gif';
  static final logo = 'logo1.png';
  static final spaceBackground = 'space_background.json';
  static final saturn = 'saturn.json';
  static final starShip = 'starship.json';
  static final mapEpisode1Level1 = 'level1.png';
}

class _AppImagesLasers {
  final base = 'lasers/';
  late final redLaser = base + 'red_laser.png';
}

class _AppImagesShips {
  final base = 'ships/';
  late final vengeanceShip = base + 'vengeance.png';
  late final tuhitShip = base + 'tuhit.png';
  late final leonovShip = base + 'leonov.png';
}

class _AppImagesExplosions {
  final base = 'explosions/';
  late final normalExplosion = base + 'explosion.png';
}

class _AppImagesRockets {
  final base = 'rockets/';
  late final shortRangeRocket = base + 'short_range.png';
  late final shieldRocket = base + 'shield_rocket.png';
  late final energyRocket = base + 'energy_rocket.png';
  late final hellStormRocket = base + 'hell_storm_rocket.png';
}

extension AppImageString on String {
  String get appImage => 'assets/images/$this';
  String get gameMap => 'maps/$this';
  String get appLottie => 'assets/lotties/$this';
}
