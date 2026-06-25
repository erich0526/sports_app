import 'package:sports_app/features/player_match_stats/domain/entities/player_match_stats.dart';
import 'package:sports_app/features/player_match_stats/domain/repositories/player_match_stats_repository.dart';
import 'package:sports_app/features/player_match_stats/data/datasources/player_match_stats_datasource.dart';
import 'package:sports_app/features/player_match_stats/data/models/player_match_stats_model.dart';

class PlayerMatchStatsRepositoryImpl implements PlayerMatchStatsRepository {
  final PlayerMatchStatsDatasource playerMatchStatsDatasource;
  PlayerMatchStatsRepositoryImpl({required this.playerMatchStatsDatasource});

  @override
  Future<List<PlayerMatchStats>> getMatchStats(String matchId) async {
    return await playerMatchStatsDatasource.getMatchStats(matchId);
  }

  @override
  Future<void> addMatchStats(PlayerMatchStats stats) async {
    final playerMatchStatsModel = PlayerMatchStatsModel(
      id: stats.id,
      matchId: stats.matchId,
      playerId: stats.playerId,
      points: stats.points,
      rebounds: stats.rebounds,
      assists: stats.assists,
      steals: stats.steals,
      blocks: stats.blocks,
      minutes: stats.minutes,
    );

    await playerMatchStatsDatasource.addMatchStats(playerMatchStatsModel);
  }
}
