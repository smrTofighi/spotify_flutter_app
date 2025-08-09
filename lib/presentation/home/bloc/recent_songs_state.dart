import 'package:spotify_app/domain/song/entity/song_entity.dart';

abstract class RecentSongsState {}

class RecentSongsInitial extends RecentSongsState {}

class RecentSongsLoaded extends RecentSongsState {
  final List<SongEntity> songs;

  RecentSongsLoaded({required this.songs});
}

class RecentSongsError extends RecentSongsState {
  final String message;

  RecentSongsError({required this.message});
}

class RecentSongsLoading extends RecentSongsState {}