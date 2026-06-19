import 'package:sports_app/features/player/domain/entities/player.dart';
import 'package:sports_app/features/player/domain/repositories/player_repository.dart';
import 'package:sports_app/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

class GetPlayerStatsParams extends Equatable {
  final String id;
  const GetPlayerStatsParams({required this.id});

  @override
  List<Object> get props => [id];
}

class GetPlayerStats extends UseCase<Player, GetPlayerStatsParams> {
  final PlayerRepository repository;
  GetPlayerStats({required this.repository});

  @override
  Future<Player> call(GetPlayerStatsParams params) async {
    return await repository.getPlayer(params.id);
  }
}
