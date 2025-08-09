import 'package:get_it/get_it.dart';
import 'package:spotify_app/data/auth/repository/auth_repository_impl.dart';
import 'package:spotify_app/data/auth/source/auth_firebase_service.dart';
import 'package:spotify_app/data/song/repository/song_repository_impl.dart';
import 'package:spotify_app/data/song/source/song_firebase_service.dart';
import 'package:spotify_app/domain/auth/repository/auth_repository.dart';
import 'package:spotify_app/domain/auth/usecase/check_login_usecase.dart';
import 'package:spotify_app/domain/auth/usecase/get_user_usecase.dart';
import 'package:spotify_app/domain/auth/usecase/login_usecase.dart';
import 'package:spotify_app/domain/auth/usecase/signup_usecase.dart';
import 'package:spotify_app/domain/song/repository/song_repository.dart';
import 'package:spotify_app/domain/song/usecase/add_remove_favorite_song_usecase.dart';
import 'package:spotify_app/domain/song/usecase/get_news_songs_usecase.dart';
import 'package:spotify_app/domain/song/usecase/get_recent_songs_usecase.dart';
import 'package:spotify_app/domain/song/usecase/is_favorite_song_usecase.dart';
import 'package:spotify_app/domain/song/usecase/user_favorite_songs_usecase.dart';

final locator = GetIt.instance;

Future<void> initLocator() async {
  locator.registerSingleton<AuthFirebaseService>(AuthFirebaseServiceImpl());
  locator.registerSingleton<AuthRepository>(AuthRepositoryImpl());
  locator.registerSingleton<SignUpUseCase>(SignUpUseCase());
  locator.registerSingleton<LogInUseCase>(LogInUseCase());
  locator.registerSingleton<SongFirebaseService>(SongFirebaseServiceImpl());
  locator.registerSingleton<SongRepository>(SongRepositoryImpl());
  locator.registerSingleton<GetNewsSongsUseCase>(GetNewsSongsUseCase());
  locator.registerSingleton<GetRecentSongsUseCase>(GetRecentSongsUseCase());
  locator.registerSingleton<AddOrRemoveFavoriteSongUseCase>(AddOrRemoveFavoriteSongUseCase());
  locator.registerSingleton<IsFavoriteSongUseCase>(IsFavoriteSongUseCase());
  locator.registerSingleton<GetUserUseCase>(GetUserUseCase());
  locator.registerSingleton<UserFavoriteSongsUseCase>(UserFavoriteSongsUseCase());
  locator.registerSingleton<CheckLoginUseCase>(CheckLoginUseCase());
}
