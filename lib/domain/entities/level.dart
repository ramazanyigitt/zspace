import 'dart:convert';

import 'package:equatable/equatable.dart';

class Level extends Equatable {
  Level({
    this.level,
    this.episodeId,
  });

  final int? level;
  final int? episodeId;

  @override
  List<Object?> get props => [
        level,
        episodeId,
      ];
}
