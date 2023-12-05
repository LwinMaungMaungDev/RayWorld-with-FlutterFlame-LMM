import 'package:flame/components.dart';

// Extends SpriteComponent to render a static image in your game.
// By using the HasGameRef mixin,
// the Player now has access to the core functionality of the Flame engine.
class Player extends SpriteComponent with HasGameRef {
  Player()
      : super(
          size: Vector2.all(50.0), // The size of player is 50
        );

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await gameRef.loadSprite('player.png'); // Load the sprite
    position = gameRef.size / 2; // Set the position at middle
  }
}
