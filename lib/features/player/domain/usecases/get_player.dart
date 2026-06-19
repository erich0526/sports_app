import 'package:sports_app/features/player/domain/entities/player.dart';
import 'package:sports_app/features/player/domain/repositories/player_repository.dart';
import 'package:sports_app/core/usecases/usecase.dart';

class GetPlayers extends UseCase<List<Player>, NoParams> {
  final PlayerRepository repository;
  GetPlayers({required this.repository});

  @override
  Future<List<Player>> call(NoParams params) async {
    return await repository.getAllPlayers();
  }
}
