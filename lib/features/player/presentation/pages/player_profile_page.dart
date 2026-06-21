import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/features/player/presentation/bloc/player_state.dart';
import 'package:sports_app/features/player/presentation/bloc/player_event.dart';
import 'package:sports_app/features/player/presentation/bloc/player_bloc.dart';

class PlayerProfilePage extends StatelessWidget {
  const PlayerProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerBloc, PlayerState>(
      listener: (context, state) {
        if (state is PlayerStatsLoaded) {
          context.read<PlayerBloc>().add(
            EvaluatePlayerEvent(player: state.player),
          );
        }
      },
      builder: (context, state) {
        if (state is PlayerLoading) {
          return Scaffold(
            appBar: AppBar(title: const Text('球員資料')),
            body: const Center(child: CircularProgressIndicator()),
          );
        } else if (state is PlayerEvaluated) {
          return Scaffold(
            appBar: AppBar(title: Text('球員個人生涯數據')),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('球員姓名：${state.player.name}'),
                  Text('效力隊伍：${state.player.team}'),
                  Text('球員位置：${state.player.position}'),
                  Divider(),
                  Text('── 生涯數據 ──'),
                  Text('出賽場次：${state.player.matches}'),
                  Text('勝場數：${state.player.wins}'),
                  Text('總上場時間（分鐘）：${state.player.minutes}'),
                  Text('總得分：${state.player.points}'),
                  Text('總籃板：${state.player.rebounds}'),
                  Text('總助攻：${state.player.assists}'),
                  Text('總阻攻：${state.player.blocks}'),
                  Text('總抄截：${state.player.steals}'),
                  Text('總失誤：${state.player.turnovers}'),
                  Divider(),
                  Text('── 場均數據 ──'),
                  Text('場均得分：${state.evaluation.avgScores.toStringAsFixed(1)}'),
                  Text(
                    '場均籃板：${state.evaluation.avgRebounds.toStringAsFixed(1)}',
                  ),
                  Text(
                    '場均助攻：${state.evaluation.avgAssists.toStringAsFixed(1)}',
                  ),
                  Text('場均阻攻：${state.evaluation.avgBlocks.toStringAsFixed(1)}'),
                  Text('場均抄截：${state.evaluation.avgSteals.toStringAsFixed(1)}'),
                  Text(
                    '場均失誤：${state.evaluation.avgTurnover.toStringAsFixed(1)}',
                  ),
                  Divider(),
                  Text('── 整體評估 ──'),
                  Text(
                    '整體命中率：${(state.evaluation.hitRatio * 100).toStringAsFixed(1)}',
                  ),
                  Text(
                    '勝率：${(state.evaluation.winRatio * 100).toStringAsFixed(1)}',
                  ),
                  Text('效率值：${state.evaluation.efficiency.toStringAsFixed(1)}'),
                  Text(
                    '總評分：${state.evaluation.overallRate.toStringAsFixed(1)}',
                  ),
                ],
              ),
            ),
          );
        } else if (state is PlayerError) {
          return Scaffold(
            appBar: AppBar(title: const Text('球員資料')),
            body: Center(child: Text(state.message)),
          );
        } else {
          return Scaffold(
            appBar: AppBar(title: const Text('球員資料')),
            body: Center(child: CircularProgressIndicator()),
          );
        }
        // return const SizedBox();
      },
    );
  }
}
