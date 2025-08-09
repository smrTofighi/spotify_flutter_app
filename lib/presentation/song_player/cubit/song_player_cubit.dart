import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:meta/meta.dart';

part 'song_player_state.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      updateSongPlayer();
    });

    audioPlayer.durationStream.listen((position) {
      songDuration = position ?? Duration.zero;
     
    });
  }

  void updateSongPlayer() {
    emit(SongPlayerLoaded());
  }

  AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  Future<void> loadSong(String url) async {
    emit(SongPlayerLoading());
    try {
      await audioPlayer.setUrl(url);
      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerError());
    }
  }

  void updateDurationSong(Duration pisition) {
    audioPlayer.seek(pisition);
    emit(SongPlayerLoaded());
  }

  void playOrPauseSong() {
    if (audioPlayer.playing) {
      audioPlayer.stop();
    } else {
      audioPlayer.play();
    }
    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() {
    audioPlayer.dispose();
    return super.close();
  }
}
