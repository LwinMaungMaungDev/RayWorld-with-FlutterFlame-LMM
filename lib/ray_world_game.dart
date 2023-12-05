import 'package:flame/game.dart';

import 'components/player.dart';

// This will be the heart of your game.
// You’ll create and manage all your other components from here.
class RayWorldGame extends FlameGame {
  final Player _player = Player();

  @override
  Future<void> onLoad() async {
    add(_player);
  }
}

// "add" is a super important method when building games with the Flame engine.
// It allows you to register any component with the core game loop and
// ultimately render them on screen.
// You can use it to add players, enemies, and lots of other things as well.
