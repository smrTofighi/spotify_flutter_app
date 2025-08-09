import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/song/usecase/get_news_songs_usecase.dart';
import 'package:spotify_app/locator.dart';
import 'package:spotify_app/presentation/home/bloc/news_songs_state.dart';

class NewsSongsCubit extends Cubit<NewsSongsState>{
  NewsSongsCubit() : super(NewsSongsLoading());

  Future<void> getNewsSongs()async{
    var returnedSongs = await locator<GetNewsSongsUseCase>().call();

    returnedSongs.fold((l){
      emit(NewsSongsError(message: l));
    }, (r){
      log(r[0].imageUrl.toString());
      emit(NewsSongsLoaded(songs: r));
    });
  }
}