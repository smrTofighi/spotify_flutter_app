// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify_app/domain/song/entity/song_entity.dart';

class SongModel {
  String? songId;
  String? title;
  String? artist;
  String? duration;
  String? imageUrl;
  String? songUrl;
  Timestamp? releaseDate;
  bool ? isFavorite;
  SongModel({
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.imageUrl,
    required this.songUrl,
    required this.isFavorite,
    required this.songId,
  });

  SongModel.fromJson(Map<String, dynamic> song) {
    title = song['title'];
    artist = song['artist'];
    duration = song['duration'];
    releaseDate = song['releaseDate'];
    imageUrl = song['imageUrl'];
    songUrl = song['songUrl'];
  }
}

extension SongModelX on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title!,
      artist: artist!,
      duration: duration!,
      releaseDate: releaseDate!,
      imageUrl: imageUrl!,
      songUrl: songUrl!,
      isFavorite: isFavorite!,
      songId: songId!,
    );
  }
}
