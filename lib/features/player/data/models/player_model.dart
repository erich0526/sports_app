import 'package:sports_app/features/player/domain/entities/player.dart';

class PlayerModel extends Player {
  const PlayerModel({
    required super.id,
    required super.name,
    required super.team,
    required super.position,
    required super.points,
    required super.rebounds,
    required super.assists,
    required super.steals,
    required super.blocks,
    required super.attempts,
    required super.misses,
    required super.turnovers,
    required super.minutes,
    required super.matches,
    required super.wins,
  });

  factory PlayerModel.fromJson(Map<String, dynamic> json, String id) {
    return PlayerModel(
      id: id,
      name: (json['name']).toString(),
      team: (json['team']).toString(),
      position: (json['position']).toString(),
      points: (json['points']).toInt(),
      rebounds: (json['rebounds']).toInt(),
      assists: (json['assists']).toInt(),
      steals: (json['steals']).toInt(),
      blocks: (json['blocks']).toInt(),
      attempts: (json['attempts']).toInt(),
      misses: (json['misses']).toInt(),
      turnovers: (json['turnovers']).toInt(),
      minutes: (json['minutes']).toInt(),
      matches: (json['matches']).toInt(),
      wins: (json['wins']).toInt(),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'team': team,
      'position': position,
      'points': points,
      'rebounds': rebounds,
      'assists': assists,
      'steals': steals,
      'blocks': blocks,
      'attempts': attempts,
      'misses': misses,
      'turnovers': turnovers,
      'minutes': minutes,
      'matches': matches,
      'wins': wins,
    };
  }
}
