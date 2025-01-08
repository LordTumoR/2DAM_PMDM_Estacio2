import 'package:flutter_twitter_copy/data/datasources/tweet_remote_datasource.dart';
import 'package:flutter_twitter_copy/data/datasources/user_remote_datasource.dart';
import 'package:flutter_twitter_copy/data/repositories/tweet_repository_impl.dart';
import 'package:flutter_twitter_copy/data/repositories/user_repository_impl.dart';
import 'package:flutter_twitter_copy/domain/repositories/tweet_repository.dart';
import 'package:flutter_twitter_copy/domain/repositories/user_repository.dart';
import 'package:flutter_twitter_copy/domain/usercases/create_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usercases/delete_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_followers_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_tweet_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_user_info_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/get_users_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/like_tweet_usecase.dart';
import 'package:flutter_twitter_copy/domain/usercases/login_user_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/updateUser_usercase.dart';
import 'package:flutter_twitter_copy/domain/usercases/update_tweet_usecase.dart';
import 'package:flutter_twitter_copy/presentations/bloc/Tweeter/TweetBloc.dart';
import 'package:flutter_twitter_copy/presentations/bloc/login/Login_block.dart';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  // DataSource
  sl.registerLazySingleton(() => UserRemoteDatasource());
  sl.registerLazySingleton(() => TweetRemoteDataSource());

  // Repositories
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<TweetRepository>(
    () => TweetRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => GetUserInfo(sl()));
  sl.registerLazySingleton(() => UpdateUserInfoUseCase(sl()));
  sl.registerLazySingleton(() => GetTweetsUseCase(sl()));
  sl.registerLazySingleton(() => CreateTweetUseCase(sl()));
  sl.registerLazySingleton(() => DeleteTweetUseCase(sl()));
  sl.registerLazySingleton(() => LikeTweetUseCase(sl()));
  sl.registerLazySingleton(() => UpdateTweetUseCase(sl()));
  sl.registerLazySingleton(() => GetFollowUsersTweetsUseCase(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));

  // Blocs
  sl.registerFactory(() => LoginBloc(
        loginUser: sl(),
        getUserInfo: sl(),
        getUsers: sl(),
        updateUserInfoUseCase: sl(),
      ));

  sl.registerLazySingleton(() => TweetBloc(
        getTweetsUseCase: sl(),
        createTweetUseCase: sl(),
        deleteTweetUseCase: sl(),
        likeTweetUseCase: sl(),
        updateTweetUseCase: sl(),
        getFollowUsersTweetUseCase: sl(),
      ));
}
