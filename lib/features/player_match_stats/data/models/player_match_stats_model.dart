import 'package:sports_app/features/player_match_stats/domain/entities/player_match_stats.dart';

class PlayerMatchStatsModel extends PlayerMatchStats {
  const PlayerMatchStatsModel({
    required super.id,
    required super.matchId,
    required super.playerId,
    required super.points,
    required super.rebounds,
    required super.assists,
    required super.steals,
    required super.blocks,
    required super.minutes,
  });

  factory PlayerMatchStatsModel.fromJson(Map<String, dynamic> json, String id) {
    return PlayerMatchStatsModel(
      id: id,
      matchId: (json['matchId']).toString(),
      playerId: (json['playerId']).toString(),
      points: (json['points']).toInt(),
      rebounds: (json['rebounds']).toInt(),
      assists: (json['assists']).toInt(),
      steals: (json['steals']).toInt(),
      blocks: (json['blocks']).toInt(),
      minutes: (json['minutes']).toInt(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'matchId': matchId,
      'playerId': playerId,
      'points': points,
      'rebounds': rebounds,
      'assists': assists,
      'steals': steals,
      'blocks': blocks,
      'minutes': minutes,
    };
  }
}
