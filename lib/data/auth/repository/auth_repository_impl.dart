import 'package:dartz/dartz.dart';
import 'package:spotify_app/data/auth/model/create_user_req_model.dart';
import 'package:spotify_app/data/auth/model/login_user_req_model.dart';
import 'package:spotify_app/data/auth/source/auth_firebase_service.dart';
import 'package:spotify_app/domain/auth/repository/auth_repository.dart';
import 'package:spotify_app/locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> login(LoginUserReqModel user) async {
    return await locator<AuthFirebaseService>().signIn(user); 
  }

  @override
  Future<Either> signup(CreateUserReqModel user) async {
    return await locator<AuthFirebaseService>().signUp(user);
  }
  
  @override
  Future<Either> getUser()async {
    return await locator<AuthFirebaseService>().getUser();
  }
  
  @override
  Future<bool> checkLogin()async {
    return await locator<AuthFirebaseService>().checkLogin();
  }
}
