// 定義 Match 這筆資料有哪些欄位
// 繼承 Equatable 讓欄位內容可以被比較
import 'package:equatable/equatable.dart';

class Match extends Equatable {
  const Match({
    required this.id,
    required this.homeTeam,
    required this.guestTeam,
    required this.homeScore,
    required this.guestScore,
    required this.date,
  });

  final String id;
  final String homeTeam;
  final String guestTeam;
  final int homeScore;
  final int guestScore;
  final DateTime date;

  @override
  List<Object> get props => [
    id,
    homeTeam,
    guestTeam,
    homeScore,
    guestScore,
    date,
  ];
}
