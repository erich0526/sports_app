import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/features/player/presentation/bloc/player_event.dart';
import 'package:sports_app/features/player/presentation/bloc/player_state.dart';
import 'package:sports_app/features/player/domain/usecases/get_player_stats.dart';
import 'package:sports_app/features/player/domain/usecases/get_player.dart';
import 'package:sports_app/features/player/domain/usecases/evaluate_player.dart';
import 'package:sports_app/core/usecases/usecase.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc({
    required this.getPlayers,
    required this.getPlayerStats,
    required this.evaluatePlayer,
  }) : super(PlayerInitial()) {
    on<LoadPlayersEvent>((event, emit) async {
      emit(PlayerLoading());
      try {
        final players = await getPlayers(NoParams());
        emit(PlayersLoaded(players: players));
      } catch (e) {
        emit(PlayerError(message: e.toString()));
      }
    });

    on<GetPlayerStatsEvent>((event, emit) async {
      try {
        final player = await getPlayerStats(GetPlayerStatsParams(id: event.id));
        emit(PlayerStatsLoaded(player: player));
      } catch (e) {
        emit(PlayerError(message: e.toString()));
      }
    });

    on<EvaluatePlayerEvent>((event, emit) async {
      try {
        final evaluation = await evaluatePlayer(
          EvaluatePlayerParams(player: event.player),
        );

        emit(PlayerEvaluated(evaluation: evaluation, player: event.player));
      } catch (e) {
        emit(PlayerError(message: e.toString()));
      }
    });
  }

  final GetPlayers getPlayers;
  final GetPlayerStats getPlayerStats;
  final EvaluatePlayer evaluatePlayer;
}
