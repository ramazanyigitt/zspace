import 'level_model.dart';
import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode {
  final String? name;
  final List<LevelModel>? levels;
  final String? image;

  EpisodeModel({
    this.name,
    this.levels,
    this.image,
  }) : super(
          name: name,
          levels: levels,
          image: image,
        );

  fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      name: json['name'],
      levels: (json['level'] as List<dynamic>)
          .map<LevelModel>((e) => LevelModel().fromJson(e))
          .toList(),
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'level': levels?.map((e) => e.toJson()).toList() ?? [],
      'image': image,
    };
  }

  @override
  String toString() {
    return 'EpisodeModel{name: $name, level: $levels}';
  }
}
