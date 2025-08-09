import 'package:spotify_app/domain/song/entity/song_entity.dart';

abstract class NewsSongsState {}

class NewsSongsInitial extends NewsSongsState {}

class NewsSongsLoaded extends NewsSongsState {
  final List<SongEntity> songs;

  NewsSongsLoaded({required this.songs});
}

class NewsSongsError extends NewsSongsState {
  final String message;

  NewsSongsError({required this.message});
}

class NewsSongsLoading extends NewsSongsState {}