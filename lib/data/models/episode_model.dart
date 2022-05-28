import 'level_model.dart';
import '../../domain/entities/episode.dart';

class EpisodeModel extends Episode {
  final String? name;
  final List<LevelModel>? levels;

  EpisodeModel({
    this.name,
    this.levels,
  }) : super(
          name: name,
          levels: levels,
        );

  fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
      name: json['name'],
      levels: (json['levels'] as List<dynamic>)
          .map<LevelModel>((e) => LevelModel().fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'levels': levels?.map((e) => e.toJson()).toList() ?? [],
    };
  }

  @override
  String toString() {
    return 'EpisodeModel{name: $name, levels: $levels}';
  }
}
