// 宣告「這個 Repository 能做什麼操作」，不寫任何實作內容
import 'package:sports_app/features/match/domain/entities/match.dart';

abstract class MatchRepository {
  // 回傳型別 方法名稱(參數);
  Future<List<Match>> getMatches();
  Future<void> addMatch(Match match);
}
