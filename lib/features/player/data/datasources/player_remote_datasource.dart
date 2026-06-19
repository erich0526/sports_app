import 'package:sports_app/features/player/data/models/player_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class PlayerRemoteDataSource {
  Future<List<PlayerModel>> getAllPlayers();
  Future<PlayerModel> getPlayer(String id);
}

class PlayerRemoteDataSourceImpl implements PlayerRemoteDataSource {
  final FirebaseFirestore firestore;
  PlayerRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<PlayerModel>> getAllPlayers() async {
    final fsMatches = await firestore.collection('players').get();
    return fsMatches.docs
        .map((doc) => PlayerModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<PlayerModel> getPlayer(String id) async {
    final doc = await firestore.collection('players').doc(id).get();
    return PlayerModel.fromJson(doc.data()!, doc.id);
  }
}
