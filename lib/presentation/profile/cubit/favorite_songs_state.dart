part of 'favorite_songs_cubit.dart';

@immutable
sealed class FavoriteSongsState {}

final class FavoriteSongsLoading extends FavoriteSongsState {}
final class FavoriteSongsLoaded extends FavoriteSongsState {
  final List<SongEntity> songList;
  FavoriteSongsLoaded(this.songList);

}
final class FavoriteSongsError extends FavoriteSongsState {}
