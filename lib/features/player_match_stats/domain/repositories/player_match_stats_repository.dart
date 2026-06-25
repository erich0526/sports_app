import 'package:sports_app/features/player_match_stats/domain/entities/player_match_stats.dart';

abstract class PlayerMatchStatsRepository {
  Future<List<PlayerMatchStats>> getMatchStats(String matchId);
  Future<void> addMatchStats(PlayerMatchStats stats);
}
