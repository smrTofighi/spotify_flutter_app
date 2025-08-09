// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class SongEntity {
  final String songId;
  final String title;
  final String artist;
  final String imageUrl;
  final String songUrl;
  final String duration;
  final Timestamp releaseDate;
  final bool isFavorite;
  SongEntity({
    required this.songId,
    required this.title,
    required this.artist,
    required this.duration,
    required this.releaseDate,
    required this.imageUrl,
    required this.songUrl,
    required this.isFavorite
  });
  
}
