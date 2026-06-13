// 定義一個所有 UseCase 共用的基礎類別。目的是讓每個 UseCase 的結構統一，都只有一個 call() 方法。
// 這個檔案寫好之後，GetMatches 和 AddMatch 都會繼承它
import 'package:equatable/equatable.dart';

// 定義抽象的 call(參數)，但沒有定義具體的實作內容(所以才叫抽象)
abstract class UseCase<outputType, Params> {
  Future<outputType> call(Params params);
}

// 建立NoParams繼承Equatable並回傳空串列(get props => [])，避免不必要的記憶體位置比較錯誤
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
