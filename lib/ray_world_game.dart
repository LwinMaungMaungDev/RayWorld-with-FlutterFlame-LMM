import 'dart:ui';

import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';

import 'helpers/direction.dart';
import 'helpers/map_loader.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'components/world_collidable.dart';

// This will be the heart of your game.
// You’ll create and manage all your other components from here.
class RayWorldGame extends FlameGame
    with HasCollisionDetection, KeyboardEvents {
  final Player _player = Player();
  final World _world = World();

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  // Here, you use a helper function, MapLoader, to read
  // rayworld_collision_map.json, located in your assets folder.
  // For each rectangle, it creates a WorldCollidable and adds it to your game.
  void addWorldCollision() async =>
      (await MapLoader.readRayWorldCollisionMap()).forEach((rect) {
        add(WorldCollidable()
          ..position = Vector2(rect.left, rect.top)
          ..width = rect.width
          ..height = rect.height);
      });

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isKeyDown = event is RawKeyDownEvent;
    Direction? keyDirection;

    if (event.logicalKey == LogicalKeyboardKey.keyA) {
      keyDirection = Direction.left;
    } else if (event.logicalKey == LogicalKeyboardKey.keyD) {
      keyDirection = Direction.right;
    } else if (event.logicalKey == LogicalKeyboardKey.keyW) {
      keyDirection = Direction.up;
    } else if (event.logicalKey == LogicalKeyboardKey.keyS) {
      keyDirection = Direction.down;
    }

    if (isKeyDown && keyDirection != null) {
      _player.direction = keyDirection;
    } else if (_player.direction == keyDirection) {
      _player.direction = Direction.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }

  @override
  Future<void> onLoad() async {
    await add(_world);
    // You must load the world completely before loading your player.
    // If you add the world afterward, it will render on top of your Player
    // sprite, obscuring it.
    add(_player);
    addWorldCollision();

    // For your player to traverse the world properly, you’ll want the game
    // viewport to follow the main character whenever they move.
    _player.position = _world.size / 2;
    camera.followComponent(
      _player,
      worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y),
    );
  }
}

// "add" is a super important method when building games with the Flame engine.
// It allows you to register any component with the core game loop and
// ultimately render them on screen.
// You can use it to add players, enemies, and lots of other things as well.
