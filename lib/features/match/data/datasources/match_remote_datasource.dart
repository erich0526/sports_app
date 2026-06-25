import 'package:sports_app/features/match/data/models/match_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MatchRemoteDataSource {
  // 回傳型別 方法名稱(參數);
  Future<List<MatchModel>> getMatches(); // 取得「所有」賽事，回傳型別應該是一個 list
  Future<String> addMatch(MatchModel matchModel);
  Future<MatchModel> getMatch(String id);
}

class MatchRemoteDataSourceImpl implements MatchRemoteDataSource {
  // 建構子:這個 class 需要一個 FirebaseFirestore 物件才能操作 Firestore。寫法和 GetMatches 接收 repository 一模一樣的概念
  final FirebaseFirestore firestore;
  MatchRemoteDataSourceImpl({required this.firestore});

  @override
  Future<List<MatchModel>> getMatches() async {
    final fsMatches = await firestore.collection('matches').get();
    return fsMatches.docs
        .map((doc) => MatchModel.fromJson(doc.data(), doc.id))
        .toList();
  }

  @override
  Future<String> addMatch(MatchModel matchModel) async {
    final ref = await firestore.collection('matches').add(matchModel.toJson());
    return ref.id; // ← 回傳 Firestore 自動產生的 ID
  }

  @override
  Future<MatchModel> getMatch(String id) async {
    final doc = await firestore.collection('matches').doc(id).get();
    return MatchModel.fromJson(doc.data()!, doc.id);
  }
}
