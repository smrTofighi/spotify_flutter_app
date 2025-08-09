import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify_app/domain/song/entity/song_entity.dart';
import 'package:spotify_app/domain/song/usecase/user_favorite_songs_usecase.dart';
import 'package:spotify_app/locator.dart';

part 'favorite_songs_state.dart';

class FavoriteSongsCubit extends Cubit<FavoriteSongsState> {
  FavoriteSongsCubit() : super(FavoriteSongsLoading());

  List<SongEntity> favoriteSongs = [];
  Future<void> getFavoriteSongs() async {
    var res = await locator<UserFavoriteSongsUseCase>().call();
    res.fold((l) => emit(FavoriteSongsError()), (r) {
      favoriteSongs = r;
      emit(FavoriteSongsLoaded(favoriteSongs));
    });
  }

  void removeSongFromFavorite(int index){
    favoriteSongs.removeAt(index);
    emit(FavoriteSongsLoaded(favoriteSongs));
  }
}
