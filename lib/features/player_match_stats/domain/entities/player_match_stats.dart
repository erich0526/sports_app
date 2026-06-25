import 'package:equatable/equatable.dart';

class PlayerMatchStats extends Equatable {
  final String id; //Firestore 文件 ID
  final String matchId;
  final String playerId;
  final int points;
  final int rebounds;
  final int assists;
  final int steals;
  final int blocks;
  final int minutes;

  const PlayerMatchStats({
    required this.id,
    required this.matchId,
    required this.playerId,
    required this.points,
    required this.rebounds,
    required this.assists,
    required this.steals,
    required this.blocks,
    required this.minutes,
  });

  @override
  List<Object> get props => [
    id,
    matchId,
    playerId,
    points,
    rebounds,
    assists,
    steals,
    blocks,
    minutes,
  ];
}
