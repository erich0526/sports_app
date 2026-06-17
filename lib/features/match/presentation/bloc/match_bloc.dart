import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_event.dart';
import 'package:sports_app/features/match/presentation/bloc/match_state.dart';
import 'package:sports_app/features/match/domain/usecases/add_match.dart';
import 'package:sports_app/features/match/domain/usecases/get_matches.dart';
import 'package:sports_app/core/usecases/usecase.dart';

class MatchBloc extends Bloc<MatchEvent, MatchState> {
  MatchBloc({required this.getMatches, required this.addMatch})
    : super(MatchInitial()) {
    // 註冊 on<LoadMatchesEvent>
    on<LoadMatchesEvent>((event, emit) async {
      emit(MatchLoading());
      // 呼叫 getMatches,結果存到一個變數
      // 用 try-catch 包起來,成功 emit(MatchLoaded(matches: 結果))
      // 失敗 emit(MatchError(message: 錯誤訊息))
      try {
        // 可能會出錯的程式碼
        final matches = await getMatches(NoParams());
        emit(MatchLoaded(matches: matches));
      } catch (e) {
        // 出錯時執行這裡,e 是錯誤物件
        emit(MatchError(message: e.toString()));
      }
    });

    // 註冊 on<AddMatchEvent>
    on<AddMatchEvent>((event, emit) async {
      try {
        await addMatch(AddMatchParams(match: event.match));
        // addMatch 執行完不會回傳資料,所以不能直接 emit 它的結果
        // 新增成功後,要重新呼叫一次 getMatches,這樣才會顯示新增後的結果
        final matches = await getMatches(NoParams());
        // 把最新列表 emit 出去
        emit(MatchLoaded(matches: matches));
      } catch (e) {
        emit(MatchError(message: e.toString()));
      }
    });
  }

  final GetMatches getMatches;
  final AddMatch addMatch;
}
