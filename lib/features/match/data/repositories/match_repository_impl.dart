// 把 domain 層的 MatchRepository（昨天定義的）跟今天的 MatchRemoteDataSource 接起來
import 'package:sports_app/features/match/domain/entities/match.dart';
import 'package:sports_app/features/match/domain/repositories/match_repository.dart';
import 'package:sports_app/features/match/data/datasources/match_remote_datasource.dart';
import 'package:sports_app/features/match/data/models/match_model.dart';

class MatchRepositoryImpl implements MatchRepository {
  final MatchRemoteDataSource matchRemoteDataSource;
  MatchRepositoryImpl({required this.matchRemoteDataSource});

  @override
  Future<List<Match>> getMatches() async {
    return await matchRemoteDataSource.getMatches();
  }

  @override
  Future<void> addMatch(Match match) async {
    final matchModel = MatchModel(
      id: match.id,
      homeTeam: match.homeTeam,
      guestTeam: match.guestTeam,
      homeScore: match.homeScore,
      guestScore: match.guestScore,
      date: match.date,
      playerIds: match.playerIds,
    );

    await matchRemoteDataSource.addMatch(matchModel);
  }
}
