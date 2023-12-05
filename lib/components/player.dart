import 'package:flame/components.dart';

import '../helpers/direction.dart';

// Extends SpriteComponent to render a static image in your game.
// By using the HasGameRef mixin,
// the Player now has access to the core functionality of the Flame engine.
class Player extends SpriteComponent with HasGameRef {
  Direction direction = Direction.none;
  final double _playerSpeed = 300.0;

  Player()
      : super(
          size: Vector2.all(50.0), // The size of player is 50
        );

  // "update" is a function unique to Flame components.
  // It will be called each time a frame must be rendered, and
  // Flame will ensure all your game components update at the same time.
  // The delta represents how much time has passed since the last update cycle
  // and can be used to move the player predictably.

  @override
  void update(double delta) {
    super.update(delta);
    movePlayer(delta);
  }

  void movePlayer(double delta) {
    switch (direction) {
      case Direction.up:
        moveUp(delta);
        break;
      case Direction.down:
        moveDown(delta);
        break;
      case Direction.left:
        moveLeft(delta);
        break;
      case Direction.right:
        moveRight(delta);
        break;
      case Direction.none:
        break;
    }
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png'); // Load the sprite
    position = gameRef.size / 2; // Set the position at middle
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _playerSpeed));
  }

  void moveUp(double delta) {
    position.add(Vector2(0, delta * -_playerSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(delta * -_playerSpeed, 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _playerSpeed, 0));
  }
}
