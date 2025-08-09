import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/domain/song/repository/song_repository.dart';
import 'package:spotify_app/locator.dart';

class GetRecentSongsUseCase implements UseCase<Either, dynamic> {
  @override
  Future<Either> call({params}) async{
    return await locator<SongRepository>().getRecentSongs();
  }
}