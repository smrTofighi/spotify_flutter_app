import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/domain/song/repository/song_repository.dart';
import 'package:spotify_app/locator.dart';

class IsFavoriteSongUseCase implements UseCase<bool,String> {
  @override
  Future<bool> call({String ?params})async {
    return await locator<SongRepository>().isFavoriteSong(params!);
  }
}