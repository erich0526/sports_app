//AddMatches 是「新增賽事」這個動作的封裝。它繼承 usecase.dart，呼叫 match_repository.dart 的 addMatch() 方法，把結果回傳給之後的 BLoC
import 'package:sports_app/features/match/domain/entities/match.dart';
import 'package:sports_app/features/match/domain/repositories/match_repository.dart';
import 'package:sports_app/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';

// AddMatchParams 類別是 AddMatch 專用的參數類別，繼承 Equatable
// 為什麼不直接把 Match 當參數傳，而要包一層 Params？（提示：和 UseCase 的泛型設計有關）
// 因為call()設計的時候參數就要帶「Params型態的params參數」( call(Params params) )
class AddMatchParams extends Equatable {
  // 建構子:說明這個欄位代表什麼
  // AddMatchParams 需要一個 match 才能運作，透過建構子把它傳進來，存成 final 欄位
  final Match match;
  const AddMatchParams({required this.match});

  @override
  List<Object> get props => [match];
}

// UseCase<新增賽事的型別, 參數型別>
// 新增賽事的型別 → void，因為Future<void> addMatch(Match match)
// 參數型別 → AddMatchParams，因為AddMatchParams
class AddMatch extends UseCase<String, AddMatchParams> {
  // 說明為什麼需要傳入 repository（依賴注入的概念）
  // 因為domain要跟data拿資料，但是domain不認識data
  // 所以domain只能透過定義repository interface才讓data去implement repository
  final MatchRepository repository;
  AddMatch({required this.repository});

  @override
  // 說明這個方法做了什麼事、params.match 是從哪裡來的
  // 呼叫 repository.addMatch(params.match) 並回傳結果。params.match 是從AddMatchParams來的
  Future<String> call(AddMatchParams params) async {
    return await repository.addMatch(params.match);
  }
}
