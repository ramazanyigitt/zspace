import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:zspace/data/enums/creature_types.dart';
import 'package:zspace/data/models/spawn_model.dart';

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
    await getEpisodes();
    isInited = true;
    notifyListeners();
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
    Get.to(
      () => LevelInformationPage(
        episode: episode,
        level: level,
      ),
    );
  }
}
