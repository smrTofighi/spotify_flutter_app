import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify_app/domain/song/usecase/add_remove_favorite_song_usecase.dart';
import 'package:spotify_app/locator.dart';

import 'favorite_button_state.dart';

class FavoriteButtonCubit extends Cubit<FavoriteButtonState> {
  FavoriteButtonCubit() : super(FavoriteButtonInitial());

  void favoriteButtonUpdated(String songId) async{
    var result = await locator<AddOrRemoveFavoriteSongUseCase>().call(params: songId);
    result.fold((l){}, (r){
      emit(FavoriteButtonUpdated(isFavorite: r));
    });
  }
}