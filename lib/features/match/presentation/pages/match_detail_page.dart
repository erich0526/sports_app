import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/core/injection_container.dart';

// -----------------match-----------------
import 'package:sports_app/features/match/domain/entities/match.dart';
import 'package:sports_app/features/match/presentation/bloc/match_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_event.dart';
import 'package:sports_app/features/match/presentation/bloc/match_state.dart';

// -----------------player-----------------
import 'package:sports_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:sports_app/features/player/presentation/bloc/player_event.dart';
import 'package:sports_app/features/player/presentation/pages/player_profile_page.dart';

// -----------------player_match_stats-----------------
import 'package:sports_app/features/player_match_stats/domain/entities/player_match_stats.dart';
import 'package:sports_app/features/player_match_stats/domain/usecases/get_match_stats.dart';

class MatchDetailPage extends StatelessWidget {
  const MatchDetailPage({super.key, required this.match});
  final Match match;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<MatchBloc>()..add(LoadMatchPlayersEvent(matchId: match.id)),
        ),
        BlocProvider(create: (context) => sl<PlayerBloc>()),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: const Text('賽事詳情')),
            body: BlocBuilder<MatchBloc, MatchState>(
              builder: (context, state) {
                if (state is MatchLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is MatchPlayersLoaded) {
                  final statsFuture = sl<GetMatchStats>()(
                    GetMatchStatsParams(
                      matchId: state.matchWithPlayers.match.id,
                    ),
                  );
                  if (state.matchWithPlayers.players.isEmpty) {
                    return const Center(child: Text('本場賽事尚未加入球員'));
                  }
                  return Column(
                    children: [
                      // -----------------賽事資訊-----------------
                      Text(
                        '${state.matchWithPlayers.match.homeTeam} vs ${state.matchWithPlayers.match.guestTeam}',
                      ),
                      Text(
                        '${state.matchWithPlayers.match.homeScore} : ${state.matchWithPlayers.match.guestScore}',
                      ),
                      const Divider(),
                      // -----------------球員列表-----------------
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.matchWithPlayers.players.length,
                          itemBuilder: (context, index) {
                            final player =
                                state.matchWithPlayers.players[index];
                            return ListTile(
                              title: Text(player.name),
                              subtitle: FutureBuilder<List<PlayerMatchStats>>(
                                future: statsFuture,
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const Text('載入中...');
                                  }
                                  final statsList = snapshot.data!;
                                  final stats = statsList
                                      .where((s) => s.playerId == player.id)
                                      .firstOrNull;
                                  if (stats == null) {
                                    return Text(player.position);
                                  }
                                  return Text(
                                    '${player.position}｜本場：${stats.points}分 ${stats.rebounds}籃板 ${stats.assists}助攻 ${stats.steals}抄截 ${stats.blocks}阻攻',
                                  );
                                },
                              ),
                              onTap: () {
                                // ← 放在 ListTile 這一層
                                final bloc = context.read<PlayerBloc>();
                                bloc.add(GetPlayerStatsEvent(id: player.id));
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (innerContext) =>
                                        BlocProvider.value(
                                          value: bloc,
                                          child: const PlayerProfilePage(),
                                        ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is MatchError) {
                  return Center(child: Text(state.message));
                } else {
                  return const SizedBox();
                }
              },
            ),
          );
        },
      ),
    );
  }
}
