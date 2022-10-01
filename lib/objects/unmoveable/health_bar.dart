import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:zspace/objects/game_object.dart';
import 'package:zspace/objects/moveable/ships/ship.dart';
import 'dart:math' as math;

import 'package:zspace/shared/app_theme.dart';

class HealthBar extends PositionComponent {
  final Ship object;
  final Color barFillColor, barEmptyColor;
  final bool addText;
  HealthBar({
    required this.object,
    this.addText: false,
    this.barFillColor: const Color.fromARGB(255, 229, 57, 53),
    this.barEmptyColor: Colors.grey,
  });

  @override
  void update(double dt) {
    super.update(dt);
    //this.angle = object.angle;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final maxWidth = object.size.x;
    final armorWidth = object.size.x * object.getArmor() / object.getMaxArmor();

    canvas.save();
    //canvas.rotate(-absoluteAngle);
    //canvas.rotate(-this.angle);
    //canvas.rotate((255 * math.pi / 180).roundToDouble());
    /*double modOfAngle;
    canvas.rotate(-object.angle);
    if (object.angle < 0) {
      modOfAngle = (object.angle) % 3.15;
    } else {
      modOfAngle = (-object.angle) % 3.15;
    }
    //modOfAngle = modOfAngle.roundToDouble();
    if (object.angle > 3) {
      log('3 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(object.size.x * modOfAngle, object.size.y * modOfAngle);
    } else if (object.angle > 2) {
      log('2 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(object.size.x * modOfAngle, object.size.y * modOfAngle);
    } else if (object.angle > 1) {
      log('1 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(-object.size.x, 1 * -modOfAngle - 20);
    } else if (object.angle > 0) {
      log('0 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(object.size.x * modOfAngle, object.size.y * modOfAngle);
    } else if (object.angle < 0) {
      log('-0 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(0, object.size.y * 2 * modOfAngle);
    } else if (object.angle < 1) {
      log('-1 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(object.size.x * modOfAngle, object.size.y * modOfAngle);
    } else if (object.angle < 2) {
      log('-2 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(object.size.x * modOfAngle, object.size.y * modOfAngle);
    } else if (object.angle < 3) {
      log('-3 ${object.angle} mod: ${modOfAngle}');
      canvas.translate(
          object.size.x * modOfAngle, object.size.y * modOfAngle / 2);
    }*/
    //canvas.rotate(90 * math.pi / 180);

    canvas.translate(
        object.x - (object.size.x / 2), object.y - (object.size.y / 2));
    //canvas.rotate(-object.angle);
    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        0,
        maxWidth,
        20,
        Radius.circular(5),
      ),
      new Paint()..color = barEmptyColor.withOpacity(0.55),
    );
    canvas.drawRRect(
      RRect.fromLTRBR(
        0,
        0,
        armorWidth,
        20,
        Radius.circular(5),
      ),
      new Paint()..color = barFillColor.withOpacity(0.9),
    );

    if (addText) _paintText(canvas, Size(object.size.x, object.size.y));

    canvas.restore();
  }

  void _paintText(Canvas canvas, Size size) {
    final textSpan = TextSpan(
      text:
          '${object.getArmor().toInt() == 0 ? '1' : object.getArmor().toInt()}',
      style: AppTheme().smallParagraphSemiBoldText,
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        // Do calculations here:
        (size.width - textPainter.width) * 0.5,
        (size.height - textPainter.height) * -0.1,
      ),
    );
  }
}
