import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieCache {
  final Map<String, LottieComposition> _compositions = {};

  /// Caches the given [LottieAsset]s.
  Future<void> add(String assetName) async {
    _compositions[assetName] = await AssetLottie(assetName).load();
  }

  /// Get the lottie from cache.
  Widget load(
    String assetName,
    Widget fallback, {
    double? height,
    BoxFit? fit,
  }) {
    final composition = _compositions[assetName];
    return composition != null
        ? Lottie(
            composition: composition,
            height: height,
            fit: fit,
          )
        : fallback;
  }
}
