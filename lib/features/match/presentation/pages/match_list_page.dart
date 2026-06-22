import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/core/injection_container.dart';
import 'package:sports_app/features/match/presentation/bloc/match_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_event.dart';
import 'package:sports_app/features/match/presentation/bloc/match_state.dart';
import 'package:sports_app/features/match/presentation/pages/add_match_page.dart';
import 'package:sports_app/features/match/presentation/pages/match_detail_page.dart';

// 賽事列表頁面，不需要自己的內部狀態，畫面完全由 MatchBloc 的 State 決定
class MatchListPage extends StatelessWidget {
  const MatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 把 MatchBloc 放進 widget tree，讓底下的子 widget 都能取用
    // 用 sl<MatchBloc>() 從 GetIt 拿到實例，建立完馬上 add(LoadMatchesEvent())
    // 觸發第一次載入賽事列表
    return BlocProvider(
      create: (context) => sl<MatchBloc>()..add(LoadMatchesEvent()),
      // 用 Builder 包一層，目的是拿到一個「真正在 BlocProvider 底下」的新 context
      // 因為 build() 外層的 context 是 MatchListPage 自己的位置，不在 BlocProvider 範圍內
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('賽事列表')),
            // 監聽 MatchBloc 的狀態變化，依照不同 State 顯示不同畫面
            body: BlocBuilder<MatchBloc, MatchState>(
              builder: (context, state) {
                // 載入中：顯示轉圈圈
                if (state is MatchLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                // 載入完成：顯示賽事列表
                if (state is MatchLoaded) {
                  return ListView.builder(
                    // state is MatchLoaded 之後，Dart 自動把 state 當作
                    // MatchLoaded 型別使用，所以可以直接取 state.matches
                    itemCount: state.matches.length,
                    itemBuilder: (context, index) {
                      // 取出第 index 筆賽事資料
                      final match = state.matches[index];
                      return ListTile(
                        // 標題顯示主場 vs 客場隊伍名稱
                        title: Text('${match.homeTeam} vs ${match.guestTeam}'),
                        // 副標題顯示比分
                        subtitle: Text(
                          '${match.homeScore} : ${match.guestScore}',
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (innerContext) =>
                                  MatchDetailPage(match: match),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
                // 發生錯誤：顯示錯誤訊息
                if (state is MatchError) {
                  return Center(child: Text(state.message));
                }
                // 其他情況（例如 MatchInitial）：顯示空白
                return const SizedBox();
              },
            ),
            // 右下角的新增按鈕
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    // innerContext 改名是為了不要跟外層的 context 撞名
                    // (否則會「遮蔽」外層的 context，導致讀不到 MatchBloc)
                    builder: (innerContext) => BlocProvider.value(
                      // 用 BlocProvider.value 把「同一個」MatchBloc 實例傳給新頁面
                      // 而不是讓新頁面自己重新建立一個（GetIt 找不到會報錯）
                      // 這裡明確使用外層(Builder 給的)的 context 才能正確讀到 MatchBloc
                      value: context.read<MatchBloc>(),
                      child: const AddMatchPage(),
                    ),
                  ),
                );
              },
              child: const Icon(Icons.add),
            ),
          );
        },
      ),
    );
  }
}
