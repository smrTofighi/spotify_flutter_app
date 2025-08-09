import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/domain/auth/repository/auth_repository.dart';
import 'package:spotify_app/locator.dart';

class GetUserUseCase implements UseCase<Either, dynamic>{
  @override
  Future<Either> call({params}) async{
    return await locator<AuthRepository>().getUser();
  }

}