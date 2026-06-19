import 'package:sports_app/features/player/domain/entities/player.dart';

abstract class PlayerRepository {
  Future<List<Player>> getAllPlayers();
  Future<Player> getPlayer(String id);
}
