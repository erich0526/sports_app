import 'package:equatable/equatable.dart';

// 宣告一個 abstract class，這是所有Event的共同父類別
abstract class MatchEvent extends Equatable {
  const MatchEvent();

  @override
  List<Object> get props => [];
}

// 宣告一個具體事件(是一個「訊號」，不需要任何輸入參數)
// 這個事件代表「頁面載入，請去拿賽事列表」，不需要任何欄位，建構子是空的
class LoadMatchesEvent extends MatchEvent {
  const LoadMatchesEvent();
}
