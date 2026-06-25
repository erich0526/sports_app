import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_event.dart';
import 'package:sports_app/features/match/domain/entities/match.dart';

import 'package:sports_app/core/injection_container.dart';
import 'package:sports_app/features/player_match_stats/domain/entities/player_match_stats.dart';
import 'package:sports_app/features/player_match_stats/domain/usecases/add_match_stats.dart';

import 'package:sports_app/features/match/domain/usecases/add_match.dart';

// State 類別不需要建構子，也沒有 key 這個概念（key 是給 Widget 用的）
class _AddMatchPageState extends State<AddMatchPage> {
  // 輸入框各自對應一個 controller，負責讀取使用者輸入的文字
  final homeTeamController = TextEditingController();
  final guestTeamController = TextEditingController();
  final homeScoreController = TextEditingController();
  final guestScoreController = TextEditingController();
  final playerIdsController = TextEditingController();
  final matchStatsController = TextEditingController();

  // 頁面關閉時釋放 controller，避免記憶體洩漏
  // (跟 Bloc 要 close() 是同一種概念，凡是長期持有資源的物件用完都要釋放)
  @override
  void dispose() {
    homeTeamController.dispose();
    guestTeamController.dispose();
    homeScoreController.dispose();
    guestScoreController.dispose();
    playerIdsController.dispose();
    matchStatsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新增賽事')),
      body: Column(
        children: [
          // 主場隊伍名稱輸入框
          TextField(
            controller: homeTeamController,
            decoration: const InputDecoration(labelText: '主場隊伍'),
          ),
          // 客場隊伍名稱輸入框
          TextField(
            controller: guestTeamController,
            decoration: const InputDecoration(labelText: '客場隊伍'),
          ),
          // 主場分數輸入框，限制鍵盤只能輸入數字
          TextField(
            controller: homeScoreController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: '主場分數'),
          ),
          // 客場分數輸入框，限制鍵盤只能輸入數字
          TextField(
            controller: guestScoreController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(hintText: '客場分數'),
          ),
          TextField(
            controller: playerIdsController,
            decoration: const InputDecoration(
              labelText: '球員 ID（逗號分隔）',
              hintText: 'player1,player2',
            ),
          ),
          TextField(
            controller: matchStatsController,
            decoration: const InputDecoration(
              labelText: '本場數據（每行：球員ID:得分:籃板:助攻:抄截:阻攻:上場分鐘）',
              hintText: 'LBJ_6:25:10:8:2:1:36',
            ),
            maxLines: 5,
          ),
          // 新增按鈕
          ElevatedButton(
            onPressed: () async {
              if (homeTeamController.text.isEmpty ||
                  guestTeamController.text.isEmpty ||
                  homeScoreController.text.isEmpty ||
                  guestScoreController.text.isEmpty) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('請填寫所有欄位')));
                return;
              }
              final bloc = context.read<MatchBloc>(); // async 前先存
              final newMatch = Match(
                id: '',
                homeTeam: homeTeamController.text,
                guestTeam: guestTeamController.text,
                homeScore: int.parse(homeScoreController.text),
                guestScore: int.parse(guestScoreController.text),
                date: DateTime.now(),
                playerIds: playerIdsController.text.isEmpty
                    ? []
                    : playerIdsController.text
                          .split(',')
                          .map((e) => e.trim())
                          .toList(),
              );
              final matchId = await sl<AddMatch>()(
                AddMatchParams(match: newMatch),
              );
              // 用真實 matchId 寫入 stats
              if (matchStatsController.text.isNotEmpty) {
                final lines = matchStatsController.text.trim().split('\n');
                for (final line in lines) {
                  final parts = line.split(':');
                  if (parts.length == 7) {
                    final stats = PlayerMatchStats(
                      id: '',
                      matchId: matchId, // ← 用真實 ID
                      playerId: parts[0].trim(),
                      points: int.tryParse(parts[1]) ?? 0,
                      rebounds: int.tryParse(parts[2]) ?? 0,
                      assists: int.tryParse(parts[3]) ?? 0,
                      steals: int.tryParse(parts[4]) ?? 0,
                      blocks: int.tryParse(parts[5]) ?? 0,
                      minutes: int.tryParse(parts[6]) ?? 0,
                    );
                    sl<AddMatchStats>()(AddMatchStatsParams(stats: stats));
                  }
                }
              }
              // 重新載入列表
              bloc.add(LoadMatchesEvent());

              if (context.mounted) Navigator.pop(context);
            },
            child: const Text('新增'),
          ),
        ],
      ),
    );
  }
}

// AddMatchPage 本身只負責「告訴 Flutter 我需要一個 State」
// 不放任何邏輯，邏輯都在上面的 _AddMatchPageState
class AddMatchPage extends StatefulWidget {
  const AddMatchPage({super.key});

  @override
  State<AddMatchPage> createState() => _AddMatchPageState();
}
