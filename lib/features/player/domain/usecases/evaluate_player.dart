import 'package:sports_app/features/player/domain/entities/player.dart';
import 'package:sports_app/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class EvaluatePlayerParams extends Equatable {
  final Player player;
  const EvaluatePlayerParams({required this.player});

  @override
  List<Object> get props => [player];
}

class PlayerEvaluation extends Equatable {
  final double avgScores;
  final double avgAssists;
  final double avgRebounds;
  final double avgSteals;
  final double avgBlocks;
  final double avgTurnover;
  final double avgMisses;
  final double efficiency;
  final double hitRatio;
  final double winRatio;
  final double overallRate;

  const PlayerEvaluation({
    required this.avgScores,
    required this.avgAssists,
    required this.avgRebounds,
    required this.avgSteals,
    required this.avgBlocks,
    required this.avgTurnover,
    required this.avgMisses,
    required this.efficiency,
    required this.hitRatio,
    required this.winRatio,
    required this.overallRate,
  });

  @override
  List<Object> get props => [
    avgScores,
    avgAssists,
    avgRebounds,
    avgSteals,
    avgBlocks,
    avgTurnover,
    avgMisses,
    efficiency,
    hitRatio,
    winRatio,
    overallRate,
  ];
}

class EvaluatePlayer extends UseCase<PlayerEvaluation, EvaluatePlayerParams> {
  @override
  Future<PlayerEvaluation> call(EvaluatePlayerParams params) async {
    final double avgScores =
        params.player.points / params.player.matches.clamp(1, 9999);
    final double avgAssists =
        params.player.assists / params.player.matches.clamp(1, 9999);
    final double avgRebounds =
        params.player.rebounds / params.player.matches.clamp(1, 9999);
    final double avgSteals =
        params.player.steals / params.player.matches.clamp(1, 9999);
    final double avgBlocks =
        params.player.blocks / params.player.matches.clamp(1, 9999);
    final double avgTurnover =
        params.player.turnovers / params.player.matches.clamp(1, 9999);
    final double avgMisses =
        params.player.misses / params.player.matches.clamp(1, 9999);

    final double efficiency =
        (avgScores + avgRebounds + avgAssists + avgSteals + avgBlocks) -
        (avgMisses + avgTurnover);

    final double hitRatio = 1 - (params.player.misses / params.player.attempts);

    final double winRatio =
        params.player.wins / params.player.matches.clamp(1, 9999);

    final double overallRate = efficiency * 0.7 + winRatio * 100 * 0.3;

    return PlayerEvaluation(
      avgScores: avgScores,
      avgAssists: avgAssists,
      avgRebounds: avgRebounds,
      avgSteals: avgSteals,
      avgBlocks: avgBlocks,
      avgTurnover: avgTurnover,
      avgMisses: avgMisses,
      efficiency: efficiency,
      hitRatio: hitRatio,
      winRatio: winRatio,
      overallRate: overallRate,
    );
  }
}
