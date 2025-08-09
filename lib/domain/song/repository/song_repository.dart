import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getNewsSongs();
  Future<Either> getRecentSongs();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}