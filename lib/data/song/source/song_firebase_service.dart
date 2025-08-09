import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify_app/data/song/model/song_model.dart';
import 'package:spotify_app/domain/song/entity/song_entity.dart';
import 'package:spotify_app/domain/song/usecase/is_favorite_song_usecase.dart';
import 'package:spotify_app/locator.dart';

abstract class SongFirebaseService {
  Future<Either> getNewsSongs();
  Future<Either> getRecentSongs();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseServiceImpl extends SongFirebaseService {
  @override
  Future<Either> getNewsSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var song in data.docs) {
        var songModel = SongModel.fromJson(song.data());
        bool isFavorite = await locator<IsFavoriteSongUseCase>().call(params: song.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = song.reference.id;
        log(songModel.title!);
        songs.add(songModel.toEntity());
      }

      return Right(songs);
    } catch (e) {
      return Left('Something went wrong');
    }
  }

  @override
  Future<Either> getRecentSongs() async {
    try {
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: false)
          .limit(8)
          .get();

      for (var song in data.docs) {
        var songModel = SongModel.fromJson(song.data());
        bool isFavorite = await locator<IsFavoriteSongUseCase>().call(params: song.reference.id);
        songModel.isFavorite = isFavorite;
        songModel.songId = song.reference.id;
        songs.add(songModel.toEntity());
      }
      return Right(songs);
    } catch (e) {
      return Left('Something went wrong');
    }
  }

  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      late bool isFavorite;
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
        await favoriteSongs.docs.first.reference.delete();
        isFavorite = false;
      } else {
        await firebaseFirestore
            .collection('Users')
            .doc(uId)
            .collection('Favorites')
            .add({'songId': songId, 'addedDate': Timestamp.now()});
        isFavorite = true;
      }
     return Right(isFavorite);
    } catch (e) {
      return Left('Something went wrong');
    }
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    try {
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          .where('songId', isEqualTo: songId)
          .get();

      if (favoriteSongs.docs.isNotEmpty) {
      return true;
      } else {
       return false;
      }
    } catch (e) {
      return false;
    }
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async{
    try {
       final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      final List<SongEntity> songList = [];
      var user = firebaseAuth.currentUser;
      String uId = user!.uid;

      QuerySnapshot favoriteSongs = await firebaseFirestore
          .collection('Users')
          .doc(uId)
          .collection('Favorites')
          
          .get();


      for (var element in favoriteSongs.docs){
        String songId = element['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite=true;
        songModel.songId = songId;
        songList.add(songModel.toEntity());
      }

      return Right(songList);
    
    } catch (e) {
      return Left('Something went wrong');
    }
  }
}
