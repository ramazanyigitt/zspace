class AppImages {
  static final _Asteroids asteroid = _Asteroids();
  static final _AppImagesExplosions explosions = _AppImagesExplosions();
  static final _Items items = _Items();
  static final _AppImagesLasers lasers = _AppImagesLasers();
  static final _Maps maps = _Maps();
  static final _Mines mines = _Mines();
  static final _Planets planets = _Planets();
  static final _AppImagesPortals portals = _AppImagesPortals();
  static final _AppImagesRockets rockets = _AppImagesRockets();
  static final _AppImagesShields shields = _AppImagesShields();
  static final _AppImagesShips ships = _AppImagesShips();
  static final _Utilities utilities = _Utilities();

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
  late final korathShip = base + 'korath.png';
  late final nemerteaShip = base + 'nemertea.png';
  late final bastionShip = base + 'bastion.png';
  late final rhapsodyShip = base + 'rhapsody.png';
  late final uralShip = base + 'ural.png';
}

class _AppImagesExplosions {
  final base = 'explosions/';
  late final normalExplosion = base + 'explosion.png';
  late final blueExplosion = base + 'blue_explosion.png';
}

class _AppImagesRockets {
  final base = 'rockets/';
  late final shortRangeRocket = base + 'short_range.png';
  late final shieldRocket = base + 'shield_rocket.png';
  late final energyRocket = base + 'energy_rocket.png';
  late final hellStormRocket = base + 'hell_storm_rocket.png';
}

class _AppImagesShields {
  final base = 'shields/';
  late final shield = base + 'shield.png';
}

class _AppImagesPortals {
  final base = 'portals/';
  late final portal = base + 'portal.png';
  late final portalActive = base + 'portal_active.png';
}

class _Asteroids {
  final base = 'asteroids/';
  late final asteroid1 = base + 'asteroid_1.png';
  late final asteroid2 = base + 'asteroid_2.png';
  late final asteroid3 = base + 'asteroid_3.png';
  late final asteroid4 = base + 'asteroid_4.png';
}

class _Items {
  final base = 'items/';
  late final laserLevel1 = base + 'laser_level_1.png';
  late final laserLevel2 = base + 'laser_level_2.png';
  late final rocketLevel1 = base + 'rocket_level_1.png';
  late final rocketLevel2 = base + 'rocket_level_2.png';
  late final shieldLevel1 = base + 'shield_level_1.png';
  late final shieldLevel2 = base + 'shield_level_2.png';
  late final speedLevel1 = base + 'speed_level_1.png';
  late final speedLevel2 = base + 'speed_level_2.png';
}

class _Mines {
  final base = 'mines/';
  late final mine = base + 'mine.png';
}

class _Planets {
  final base = 'planets/';
  late final planet1 = base + 'planet_1.png';
  late final planet2 = base + 'planet_2.png';
}

class _Maps {
  final base = 'maps/';
  late final mapEpisode1Level1 = base + 'episode1_level1.png';
}

class _Utilities {
  final base = 'utilities/';
  late final credit = base + 'credit.png';
  late final goldDrop = base + 'gold_drop.png';
}

extension AppImageString on String {
  String get appImage => 'assets/images/$this';
  String get gameMap => 'maps/$this';
  String get appLottie => 'assets/lotties/$this';
}
