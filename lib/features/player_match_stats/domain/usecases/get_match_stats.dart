import 'package:equatable/equatable.dart';
import 'package:sports_app/core/usecases/usecase.dart';

import 'package:sports_app/features/player_match_stats/domain/entities/player_match_stats.dart';
import 'package:sports_app/features/player_match_stats/domain/repositories/player_match_stats_repository.dart';

class GetMatchStatsParams extends Equatable {
  final String matchId;
  const GetMatchStatsParams({required this.matchId});

  @override
  List<Object> get props => [matchId];
}

class GetMatchStats
    extends UseCase<List<PlayerMatchStats>, GetMatchStatsParams> {
  final PlayerMatchStatsRepository repository;
  GetMatchStats({required this.repository});

  @override
  Future<List<PlayerMatchStats>> call(GetMatchStatsParams params) async {
    return await repository.getMatchStats(params.matchId);
  }
}
