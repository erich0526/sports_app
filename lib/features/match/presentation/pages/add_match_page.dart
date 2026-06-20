import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_event.dart';
import 'package:sports_app/features/match/domain/entities/match.dart';

// State 類別不需要建構子，也沒有 key 這個概念（key 是給 Widget 用的）
class _AddMatchPageState extends State<AddMatchPage> {
  // 四個輸入框各自對應一個 controller，負責讀取使用者輸入的文字
  final homeTeamController = TextEditingController();
  final guestTeamController = TextEditingController();
  final homeScoreController = TextEditingController();
  final guestScoreController = TextEditingController();

  // 頁面關閉時釋放四個 controller，避免記憶體洩漏
  // (跟 Bloc 要 close() 是同一種概念，凡是長期持有資源的物件用完都要釋放)
  @override
  void dispose() {
    homeTeamController.dispose();
    guestTeamController.dispose();
    homeScoreController.dispose();
    guestScoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新增賽事')),
      body: Column(
        children: [
          // 主場隊伍名稱輸入框
          TextField(controller: homeTeamController),
          // 客場隊伍名稱輸入框
          TextField(controller: guestTeamController),
          // 主場分數輸入框，限制鍵盤只能輸入數字
          TextField(
            controller: homeScoreController,
            keyboardType: TextInputType.number,
          ),
          // 客場分數輸入框，限制鍵盤只能輸入數字
          TextField(
            controller: guestScoreController,
            keyboardType: TextInputType.number,
          ),
          // 新增按鈕
          ElevatedButton(
            onPressed: () {
              // 用四個 controller 的 .text 組成一個新的 Match 物件
              final newMatch = Match(
                // id 給空字串，因為 Firestore 會自動產生真正的文件 ID
                id: '',
                homeTeam: homeTeamController.text,
                guestTeam: guestTeamController.text,
                // 分數欄位是 int，但 controller.text 拿到的是 String，
                // 用 int.parse() 轉換型別
                homeScore: int.parse(homeScoreController.text),
                guestScore: int.parse(guestScoreController.text),
                // 今天先簡化，直接用當下時間，不做日期選擇器
                date: DateTime.now(),
                playerIds: const [],
              );
              // 觸發 AddMatchEvent，MatchBloc 會去呼叫 AddMatch UseCase
              // 寫入 Firestore，成功後自動重新載入列表
              context.read<MatchBloc>().add(AddMatchEvent(match: newMatch));
              // 新增完成，返回上一頁（賽事列表）
              Navigator.pop(context);
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
