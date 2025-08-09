import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/domain/song/repository/song_repository.dart';
import 'package:spotify_app/locator.dart';

class AddOrRemoveFavoriteSongUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String ?params})async {
    return await locator<SongRepository>().addOrRemoveFavoriteSongs(params!);
  }
}