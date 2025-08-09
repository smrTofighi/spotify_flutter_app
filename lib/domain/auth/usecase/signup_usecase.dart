import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/auth/model/create_user_req_model.dart';
import 'package:spotify_app/domain/auth/repository/auth_repository.dart';
import 'package:spotify_app/locator.dart';

class SignUpUseCase implements UseCase<Either,CreateUserReqModel>{
  @override
  Future<Either> call({CreateUserReqModel? params}) async{
    return await locator<AuthRepository>().signup(params!);
  }
}