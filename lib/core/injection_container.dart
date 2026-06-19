import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sports_app/features/match/domain/usecases/get_matches.dart';
import 'package:sports_app/features/match/domain/usecases/add_match.dart';
import 'package:sports_app/features/match/domain/repositories/match_repository.dart';

import 'package:sports_app/features/match/data/datasources/match_remote_datasource.dart';
import 'package:sports_app/features/match/data/repositories/match_repository_impl.dart';
import 'package:sports_app/features/match/presentation/bloc/match_bloc.dart';

import 'package:sports_app/features/player/domain/usecases/get_player.dart';
import 'package:sports_app/features/player/domain/usecases/get_player_stats.dart';
import 'package:sports_app/features/player/domain/usecases/evaluate_player.dart';

import 'package:sports_app/features/player/domain/repositories/player_repository.dart';
import 'package:sports_app/features/player/data/datasources/player_remote_datasource.dart';
import 'package:sports_app/features/player/data/repositories/player_repository_impl.dart';
// import 'package:sports_app/features/player/presentation/bloc/player_bloc.dart';

final sl = GetIt.instance; //sl 是慣例命名（service locator）

void init() {
  // 內部按順序註冊，順序很重要，後面的東西依賴前面的
  // Firestore 實例
  sl.registerLazySingleton(() => FirebaseFirestore.instance);

  // Match DataSource
  sl.registerLazySingleton<MatchRemoteDataSource>(
    () => MatchRemoteDataSourceImpl(firestore: sl()),
  );

  // Match Repository
  sl.registerLazySingleton<MatchRepository>(
    () => MatchRepositoryImpl(matchRemoteDataSource: sl()),
  );

  // Match UseCases
  sl.registerLazySingleton<GetMatches>(() => GetMatches(repository: sl()));
  sl.registerLazySingleton<AddMatch>(() => AddMatch(repository: sl()));

  // 註冊 MatchBloc
  sl.registerFactory(() => MatchBloc(getMatches: sl(), addMatch: sl()));

  // Player DataSource
  sl.registerLazySingleton<PlayerRemoteDataSource>(
    () => PlayerRemoteDataSourceImpl(firestore: sl()),
  );

  // Player Repository
  sl.registerLazySingleton<PlayerRepository>(
    () => PlayerRepositoryImpl(playerRemoteDataSource: sl()),
  );

  // Player UseCases
  sl.registerLazySingleton<GetPlayerStats>(
    () => GetPlayerStats(repository: sl()),
  );
  sl.registerLazySingleton<GetPlayers>(() => GetPlayers(repository: sl()));
  sl.registerLazySingleton<EvaluatePlayer>(() => EvaluatePlayer());

  // 註冊 PlayerBloc
  // sl.registerFactory(() => PlayerBloc(GetPlayerStats: sl(), GetPlayers: sl()), EvaluatePlayer: sl());
}
