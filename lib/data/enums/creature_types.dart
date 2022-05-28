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
}
