import 'package:equatable/equatable.dart';
import 'package:sports_app/core/usecases/usecase.dart';
import 'package:sports_app/features/player/domain/entities/player.dart';
import 'package:sports_app/features/match/domain/repositories/match_repository.dart';
import 'package:sports_app/features/player/domain/repositories/player_repository.dart';
import 'package:sports_app/features/match/domain/entities/match.dart';

class GetMatchPlayersParams extends Equatable {
  final String matchId;
  const GetMatchPlayersParams({required this.matchId});

  @override
  List<Object> get props => [matchId];
}

class MatchWithPlayers extends Equatable {
  final Match match;
  final List<Player> players;
  const MatchWithPlayers({required this.match, required this.players});

  @override
  List<Object> get props => [match, players];
}

class GetMatchPlayers extends UseCase<MatchWithPlayers, GetMatchPlayersParams> {
  final MatchRepository matchRepository;
  final PlayerRepository playerRepository;
  GetMatchPlayers({
    required this.matchRepository,
    required this.playerRepository,
  });

  @override
  Future<MatchWithPlayers> call(GetMatchPlayersParams params) async {
    // 1. 用 matchId 取得那場賽事
    final match = await matchRepository.getMatch(params.matchId);

    // 2. 用 Future.wait 並行取得所有球員
    final players = await Future.wait(
      match.playerIds.map((id) => playerRepository.getPlayer(id)),
    );

    return MatchWithPlayers(match: match, players: players);
  }
}
