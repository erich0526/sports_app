import 'package:equatable/equatable.dart';
import 'package:sports_app/features/player/domain/entities/player.dart';
import 'package:sports_app/features/player/domain/usecases/evaluate_player.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayerInitial extends PlayerState {
  const PlayerInitial();
}

class PlayerLoading extends PlayerState {
  const PlayerLoading();
}

class PlayersLoaded extends PlayerState {
  const PlayersLoaded({required this.players});
  final List<Player> players;

  @override
  List<Object> get props => [players];
}

class PlayerStatsLoaded extends PlayerState {
  const PlayerStatsLoaded({required this.player});
  final Player player;

  @override
  List<Object> get props => [player];
}

class PlayerEvaluated extends PlayerState {
  const PlayerEvaluated({required this.player, required this.evaluation});
  final PlayerEvaluation evaluation;
  final Player player;

  @override
  List<Object> get props => [evaluation, player];
}

class PlayerError extends PlayerState {
  const PlayerError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}
