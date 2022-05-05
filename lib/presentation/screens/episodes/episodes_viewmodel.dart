import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/data/models/episode_model.dart';
import 'package:zspace/data/models/level_model.dart';
import 'package:zspace/domain/entities/episode.dart';
import 'package:zspace/presentation/screens/level_information/level_information_page.dart';

class EpisodesViewModel extends BaseViewModel {
  late List<EpisodeModel> episodes;

  init() {
    episodes = [
      EpisodeModel(
        name: 'Episode 1',
        levels: [
          LevelModel(
            level: 1,
            episodeId: 1,
          ),
          LevelModel(
            level: 3,
            episodeId: 1,
          ),
          LevelModel(
            level: 2,
            episodeId: 1,
          ),
        ],
      ),
      EpisodeModel(
        name: 'Episode 2',
        levels: [
          LevelModel(
            level: 1,
            episodeId: 2,
          ),
          LevelModel(
            level: 3,
            episodeId: 2,
          ),
          LevelModel(
            level: 2,
            episodeId: 2,
          ),
        ],
      ),
      EpisodeModel(
        name: 'Episode 3',
        levels: [
          LevelModel(
            level: 1,
            episodeId: 2,
          ),
        ],
      ),
      EpisodeModel(
        name: 'Episode 3',
        levels: [
          LevelModel(
            level: 1,
            episodeId: 2,
          ),
        ],
      ),
      EpisodeModel(
        name: 'Episode 3',
        levels: [
          LevelModel(
            level: 1,
            episodeId: 2,
          ),
        ],
      ),
    ];
  }

  routeToLevelInformationPage() {
    Get.to(() => LevelInformationPage());
  }

  showError() {}
}
