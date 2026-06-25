import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sports_app/features/player_match_stats/data/models/player_match_stats_model.dart';

abstract class PlayerMatchStatsDatasource {
  Future<List<PlayerMatchStatsModel>> getMatchStats(String matchId);
  Future<void> addMatchStats(PlayerMatchStatsModel stats);
}

class PlayerMatchStatsDatasourceImpl implements PlayerMatchStatsDatasource {
  final FirebaseFirestore firestore;
  PlayerMatchStatsDatasourceImpl({required this.firestore});

  @override
  Future<List<PlayerMatchStatsModel>> getMatchStats(String matchId) async {
    final fsMatches = await firestore
        .collection('player_match_stats')
        .where('matchId', isEqualTo: matchId)
        .get();
    return fsMatches.docs
        .map((doc) => PlayerMatchStatsModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<void> addMatchStats(PlayerMatchStatsModel matchModel) async {
    await firestore.collection('player_match_stats').add(matchModel.toJson());
  }
}
