import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sports_app/core/injection_container.dart';
import 'package:sports_app/features/match/presentation/bloc/match_bloc.dart';
import 'package:sports_app/features/match/presentation/bloc/match_event.dart';
import 'package:sports_app/features/match/presentation/bloc/match_state.dart';

class MatchListPage extends StatelessWidget {
  const MatchListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MatchBloc>()..add(LoadMatchesEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('賽事列表')),
        body: BlocBuilder<MatchBloc, MatchState>(
          builder: (context, state) {
            if (state is MatchLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MatchLoaded) {
              return ListView.builder(
                itemCount: state.matches.length,
                itemBuilder: (context, index) {
                  final match = state.matches[index];
                  return ListTile(
                    title: Text('${match.homeTeam} vs ${match.guestTeam}'),
                    subtitle: Text('${match.homeScore} : ${match.guestScore}'),
                  );
                },
              );
            }
            if (state is MatchError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
