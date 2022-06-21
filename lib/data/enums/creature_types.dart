import 'package:flame/game.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/shared/app_images.dart';

class _CreatureTypeExtension {
  static List<String> creatureTypes = [
    "Nemertea",
    "Tuhit",
    "Korath",
    "Rhapsody",
    "Bastion",
    "Ural",
    "Peacock",
    "Spitfire",
    "Plaiedes",
    "Deonida",
    "Tyrant",
    "Intrepid",
    "Titan",
    "Patriot",
    "Xiphos",
    "Xerxes",
    "Daedalus",
    "Kestrel",
    "Mantis",
    "MantisPrime",
    "Onyx",
    "Phoenix",
    "Leviathan",
    "Kaiser",
    "Numitor",
    "Etch",
    "Hyperion",
  ];
}

enum CreatureType {
  Nemertea,
  Tuhit,
  Korath,
  Rhapsody,
  Bastion,
  Ural,
  Peacock,
  Spitfire,
  Plaiedes,
  Deonida,
  Tyrant,
  Intrepid,
  Titan,
  Patriot,
  Xiphos,
  Xerxes,
  Daedalus,
  Kestrel,
  Mantis,
  MantisPrime,
  Onyx,
  Phoenix,
  Leviathan,
  Kaiser,
  Numitor,
  Etch,
  Hyperion,
}

extension CreatureTypeExtension on CreatureType {
  String get getCreatureName {
    return _CreatureTypeExtension.creatureTypes[this.index];
  }

  String get getCreatureImage {
    switch (this) {
      case CreatureType.Nemertea:
        return AppImages.ships.nemerteaShip;
      case CreatureType.Tuhit:
        return AppImages.ships.tuhitShip;
      case CreatureType.Korath:
        return AppImages.ships.korathShip;
      case CreatureType.Rhapsody:
        return AppImages.ships.rhapsodyShip;
      case CreatureType.Bastion:
        return AppImages.ships.bastionShip;
      case CreatureType.Ural:
        return AppImages.ships.uralShip;
      /*case CreatureType.Peacock:
        return AppImages.ships.peacockShip;
      case CreatureType.Spitfire:
        return AppImages.ships.spitfireShip;*/
      default:
        throw 'Unknown image for $this';
    }
  }
}
