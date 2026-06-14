//GetMatches 是「取得所有賽事」這個動作的封裝。它繼承 usecase.dart，呼叫 match_repository.dart 的 getMatches() 方法，把結果回傳給之後的 BLoC
import 'package:sports_app/features/match/domain/entities/match.dart';
import 'package:sports_app/features/match/domain/repositories/match_repository.dart';
import 'package:sports_app/core/usecases/usecase.dart';

// UseCase<取得所有賽事的型別, 參數型別>
// 取得所有賽事的型別 → List<Match>，因為Future<List<Match>> getAllMatch()
// 參數型別 → NoParams，因為getAllMatch()不用帶參數
class GetMatches extends UseCase<List<Match>, NoParams> {
  // GetMatches 需要一個 MatchRepository 才能運作，透過建構子把它傳進來，存成 final 欄位
  // 建構子寫法一樣，建構子名稱必須和類別名稱一樣
  final MatchRepository repository;
  GetMatches({required this.repository});

  @override
  // 呼叫 repository.getMatches() 並回傳結果
  Future<List<Match>> call(NoParams params) async {
    return await repository.getMatches();
  }
}
