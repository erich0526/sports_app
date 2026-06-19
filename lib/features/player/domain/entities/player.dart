import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String name; // 球員姓名
  final String team; // 所屬隊伍
  final String position; // 球員位置
  final int points; // 總得分數
  final int rebounds; // 總籃板數
  final int assists; // 總助攻數
  final int steals; // 總抄截數
  final int blocks; // 總阻攻數
  final int attempts; // 總投籃出手次數
  final int misses; // 總投籃落空次數
  final int turnovers; // 總失誤次數
  final int minutes; // 總上場時間
  final int matches; // 出賽場次
  final int wins; // 勝場數

  const Player({
    required this.id,
    required this.name,
    required this.team,
    required this.position,
    required this.points,
    required this.rebounds,
    required this.assists,
    required this.steals,
    required this.blocks,
    required this.attempts,
    required this.misses,
    required this.turnovers,
    required this.minutes,
    required this.matches,
    required this.wins,
  });

  @override
  List<Object> get props => [
    id,
    name,
    team,
    position,
    points,
    rebounds,
    assists,
    steals,
    blocks,
    attempts,
    misses,
    turnovers,
    minutes,
    matches,
    wins,
  ];
}
