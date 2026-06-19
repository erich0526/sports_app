import 'package:sports_app/features/player/domain/entities/player.dart';
import 'package:sports_app/features/player/domain/repositories/player_repository.dart';
import 'package:sports_app/features/player/data/datasources/player_remote_datasource.dart';

class PlayerRepositoryImpl implements PlayerRepository {
  final PlayerRemoteDataSource playerRemoteDataSource;
  PlayerRepositoryImpl({required this.playerRemoteDataSource});

  @override
  Future<List<Player>> getAllPlayers() async {
    return await playerRemoteDataSource.getAllPlayers();
  }

  @override
  Future<Player> getPlayer(String id) async {
    return await playerRemoteDataSource.getPlayer(id);
  }
}
