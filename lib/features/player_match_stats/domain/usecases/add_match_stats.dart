import 'package:equatable/equatable.dart';
import 'package:sports_app/core/usecases/usecase.dart';

import 'package:sports_app/features/player_match_stats/domain/entities/player_match_stats.dart';
import 'package:sports_app/features/player_match_stats/domain/repositories/player_match_stats_repository.dart';

class AddMatchStatsParams extends Equatable {
  final PlayerMatchStats stats;
  const AddMatchStatsParams({required this.stats});

  @override
  List<Object> get props => [stats];
}

class AddMatchStats extends UseCase<void, AddMatchStatsParams> {
  final PlayerMatchStatsRepository repository;
  AddMatchStats({required this.repository});

  @override
  Future<void> call(AddMatchStatsParams params) async {
    return await repository.addMatchStats(params.stats);
  }
}
