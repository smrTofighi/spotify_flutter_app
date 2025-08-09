import 'package:dartz/dartz.dart';
import 'package:spotify_app/core/usecase/usecase.dart';
import 'package:spotify_app/data/auth/model/login_user_req_model.dart';
import 'package:spotify_app/domain/auth/repository/auth_repository.dart';
import 'package:spotify_app/locator.dart';

class LogInUseCase implements UseCase<Either, LoginUserReqModel> {
  @override
  Future<Either> call({LoginUserReqModel? params}) async {
    return await locator<AuthRepository>().login(params!);
  }
}
