import 'package:decorated_icon/decorated_icon.dart';
import 'package:flutter/material.dart';

class ThemeButtonIcon extends StatelessWidget {
  final double width, height, radius, iconSize, textSize, opacity;
  final String buttonText;
  final IconData buttonIcon;
  final Function() onTap;
  final Color? iconColor, textColor;
  const ThemeButtonIcon(
    this.buttonText, {
    this.width: 130,
    this.height: 130,
    this.radius: 5,
    this.iconSize: 70,
    this.textSize: 20,
    required this.buttonIcon,
    required this.onTap,
    this.opacity = 0.175,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(radius),
      child: InkWell(
        onTap: onTap,
        splashColor: Colors.white54,
        highlightColor: Colors.white10,
        borderRadius: BorderRadius.circular(radius),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(opacity),
            borderRadius: BorderRadius.circular(radius),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: DecoratedIcon(
                  buttonIcon,
                  size: iconSize,
                  color: iconColor ?? Colors.white,
                  shadows: [
                    BoxShadow(
                      blurRadius: iconSize / 3,
                      color: iconColor?.withAlpha(200) ??
                          Colors.white.withAlpha(200),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                buttonText,
                style: TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: textSize,
                ),
                overflow: TextOverflow.clip,
              )
            ],
          ),
        ),
      ),
    );
  }
}
