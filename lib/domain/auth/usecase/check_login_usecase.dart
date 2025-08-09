import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/domain/auth/repository/auth_repository.dart';
import 'package:spotify_app/locator.dart';

class CheckLoginUseCase implements UseCase<bool,dynamic> {
  @override
  Future<bool> call({params}) async{
    return await locator<AuthRepository>().checkLogin(); 
  }
}