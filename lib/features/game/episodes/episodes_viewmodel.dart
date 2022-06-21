import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/data/enums/creature_types.dart';
import 'package:zspace/data/models/spawn_model.dart';
import 'package:zspace/domain/repositories/local_data_repository.dart';

import '../../../data/models/episode_model.dart';
import '../../../data/models/level_model.dart';
import '../../../domain/repositories/data_repository.dart';
import '../../../injection_container.dart';
import '../level_information/level_information_page.dart';

class EpisodesViewModel extends BaseViewModel {
  late List<EpisodeModel> episodes;
  late bool isInited;

  init() async {
    episodes = [];
    isInited = false;
    await Future.wait([
      getEpisodes(),
      getCurrentLevel(),
    ]);
    isInited = true;
    notifyListeners();
  }

  Future getCurrentLevel() async {
    final data = await locator<DataRepository>().getCurrentLevel();
    if (data is Right) {
      final currentLevel = (data as Right).value as LevelModel;
      log('Current level: ${currentLevel.level}');
      log('User level: ${locator<LocalDataRepository>().getUser().levelId}');
      locator<LocalDataRepository>().getUser().levelId = currentLevel.level;
      await locator<LocalDataRepository>().getUser().save();
      log('User level after save: ${locator<LocalDataRepository>().getUser().levelId}');
    } else {
      log('Error getting current level: ${(data as Left).value}');
      //
    }
  }

  Future getEpisodes() async {
    final data = await locator<DataRepository>().getEpisodes();
    if (data is Right) {
      episodes = (data as Right).value;
    } else {
      episodes = [];
    }
  }

  routeToLevelInformationPage(EpisodeModel episode, LevelModel level) {
    final isEpisodeUnlocked = ((episode.levels?.any((element) =>
                element.level ==
                locator<LocalDataRepository>().getUser().levelId)) ==
            true) ||
        (episode.levels!.last.level! <
            locator<LocalDataRepository>().getUser().levelId!);
    if (isEpisodeUnlocked)
      Get.to(
        () => LevelInformationPage(
          episode: episode,
          level: level,
        ),
      );
  }
}
