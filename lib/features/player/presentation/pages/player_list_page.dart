import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/core/injection_container.dart';
import 'package:sports_app/features/player/presentation/bloc/player_state.dart';
import 'package:sports_app/features/player/presentation/bloc/player_event.dart';
import 'package:sports_app/features/player/presentation/bloc/player_bloc.dart';
import 'package:sports_app/features/player/presentation/pages/player_profile_page.dart';

class PlayerListPage extends StatelessWidget {
  const PlayerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<PlayerBloc>()..add(LoadPlayersEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(title: Text('球員列表')),
            body: BlocBuilder<PlayerBloc, PlayerState>(
              builder: (context, state) {
                if (state is PlayerLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is PlayersLoaded) {
                  return ListView.builder(
                    itemCount: state.players.length,
                    itemBuilder: (context, index) {
                      final player = state.players[index];
                      return ListTile(
                        title: Text(player.name),
                        subtitle: Text(player.team),
                        onTap: () {
                          final bloc = context.read<PlayerBloc>();
                          bloc.add(GetPlayerStatsEvent(id: player.id));

                          // context.read<PlayerBloc>().add(
                          //   GetPlayerStatsEvent(id: player.id),
                          // );

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (innerContext) => BlocProvider.value(
                                value: bloc,
                                child: const PlayerProfilePage(),
                              ),
                            ),
                          ).then((_) {
                            bloc.add(LoadPlayersEvent());
                          });
                        },
                      );
                    },
                  );
                }
                if (state is PlayerError) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox();
              },
            ),
          );
        },
      ),
    );
  }
}
