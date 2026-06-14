// MatchModel 是 Match 的延伸版本，多了「跟 Firestore 對話」的能力：
// fromJson：把 Firestore 回來的資料轉成 MatchModel
// toJson：把 MatchModel 轉成可以存進 Firestore 的格式
import 'package:sports_app/features/match/domain/entities/match.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MatchModel extends Match {
  const MatchModel({
    required super.id,
    required super.homeTeam,
    required super.guestTeam,
    required super.homeScore,
    required super.guestScore,
    required super.date,
  });

  // Firestore 裡的欄位叫什麼名字，就用 json['那個名字'] 取值，而且型別要對應
  factory MatchModel.fromJson(Map<String, dynamic> json, String id) {
    return MatchModel(
      id: id,
      homeTeam: (json['homeTeam']).toString(),
      guestTeam: (json['guestTeam']).toString(),
      homeScore: (json['homeScore']).toInt(),
      guestScore: (json['guestScore']).toInt(),
      date: (json['date'] as Timestamp).toDate(),
    );
  }
  // toJson 回傳 Map<String, dynamic>，把五個欄位放進去（id 不用放，因為 id 是文件本身的識別碼，不是欄位內容）
  Map<String, dynamic> toJson() {
    return {
      'homeTeam': homeTeam,
      'guestTeam': guestTeam,
      'homeScore': homeScore,
      'guestScore': guestScore,
      'date': date,
    };
  }
}
