import 'package:equatable/equatable.dart';
import 'package:sports_app/features/match/domain/entities/match.dart';
import 'package:sports_app/features/match/domain/usecases/get_match_players.dart';

// 宣告一個 abstract class，這是所有State的共同父類別
abstract class MatchState extends Equatable {
  const MatchState();

  @override
  List<Object> get props => [];
}

// 宣告一個具體事件(是一個「訊號」，不需要任何輸入參數)
// 這個事件代表「Bloc 剛建立，還沒做任何事」，不需要任何欄位，建構子是空的
class MatchInitial extends MatchState {
  const MatchInitial();
}

// 這個事件代表「正在向 Firestore 要資料」，不需要任何欄位，建構子是空的
class MatchLoading extends MatchState {
  const MatchLoading();
}

// 這個事件代表「把拿到的資料帶給畫面」，需要存值
class MatchLoaded extends MatchState {
  const MatchLoaded({required this.matches});
  final List<Match> matches;

  @override
  List<Object> get props => [matches];
}

// 這個事件代表「帶著錯誤訊息」，需要存值
class MatchError extends MatchState {
  const MatchError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

class MatchPlayersLoaded extends MatchState {
  final MatchWithPlayers matchWithPlayers;
  const MatchPlayersLoaded({required this.matchWithPlayers});
  @override
  List<Object> get props => [matchWithPlayers];
}
