import 'package:flame/events.dart';
import 'package:flame/palette.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:one_for_all/flame_things/flame_animation/rain_partical.dart';

enum ButtonState { unpressed, pressed }

class DynamicIslandButton extends SpriteGroupComponent<ButtonState>
    with HasGameRef<RainEffect> {
  @override
  Future<void> onLoad() async {
    final pressedSprite = await gameRef.loadSprite(
      'buttons.png',
      srcPosition: Vector2(0, 20),
      srcSize: Vector2(60, 20),
    );
    final unpressedSprite = await gameRef.loadSprite(
      'buttons.png',
      srcSize: Vector2(60, 20),
    );

    add(TextComponent(
        text: 'Sign in',
        textRenderer:
            TextPaint(style: TextStyle(color: BasicPalette.white.color)))
      ..anchor = Anchor.center
      ..x = size.x / 2
      ..y = size.y / 2);

    sprites = {
      ButtonState.pressed: pressedSprite,
      ButtonState.unpressed: unpressedSprite,
    };

    current = ButtonState.unpressed;
  }

  bool onTapUp(TapUpInfo info) {
    current = ButtonState.unpressed;
    return true;
  }

  bool onTapDown(TapDownInfo info) {
    current = ButtonState.pressed;
    print("=== This is Flutter Flame Button ===");
    return true;
  }
}
