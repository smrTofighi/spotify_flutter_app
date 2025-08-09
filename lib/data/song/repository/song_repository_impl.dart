import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/song/source/song_firebase_service.dart';
import 'package:spotify_app/domain/song/repository/song_repository.dart';
import 'package:spotify_app/locator.dart';

class SongRepositoryImpl  extends SongRepository{
  @override
  Future<Either> getNewsSongs()async {
      return await locator<SongFirebaseService>().getNewsSongs();
  }
  
  @override
  Future<Either> getRecentSongs()async {
    return await locator<SongFirebaseService>().getRecentSongs();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async{
    return await locator<SongFirebaseService>().addOrRemoveFavoriteSongs(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    return await locator<SongFirebaseService>().isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async{
    return await locator<SongFirebaseService>().getUserFavoriteSongs();
  }
}