import 'package:equatable/equatable.dart';
import 'package:sports_app/features/player/domain/entities/player.dart';

abstract class PlayerEvent extends Equatable {
  const PlayerEvent();

  @override
  List<Object> get props => [];
}

class LoadPlayersEvent extends PlayerEvent {
  const LoadPlayersEvent();
}

class GetPlayerStatsEvent extends PlayerEvent {
  const GetPlayerStatsEvent({required this.id});
  final String id;

  @override
  List<Object> get props => [id];
}

class EvaluatePlayerEvent extends PlayerEvent {
  const EvaluatePlayerEvent({required this.player});
  final Player player;

  @override
  List<Object> get props => [player];
}
