import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/song/usecase/get_recent_songs_usecase.dart';
import 'package:spotify_app/locator.dart';
import 'package:spotify_app/presentation/home/bloc/recent_songs_state.dart';

class RecentSongsCubit extends Cubit<RecentSongsState>{
  RecentSongsCubit() : super(RecentSongsLoading());

  Future<void> getNewsSongs()async{
    var returnedSongs = await locator<GetRecentSongsUseCase>().call();

    returnedSongs.fold((l){
      emit(RecentSongsError(message: l));
    }, (r){
     
      emit(RecentSongsLoaded(songs: r));
    });
  }
}