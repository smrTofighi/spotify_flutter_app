import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/auth/model/create_user_req_model.dart';
import 'package:spotify_app/data/auth/model/login_user_req_model.dart';

abstract class AuthRepository {
  Future<Either> signup(CreateUserReqModel user);
  Future<Either> login(LoginUserReqModel user);
  Future<Either> getUser();
  Future<bool> checkLogin();
}
