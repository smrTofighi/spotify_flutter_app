import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify_app/data/auth/model/create_user_req_model.dart';
import 'package:spotify_app/data/auth/model/login_user_req_model.dart';
import 'package:spotify_app/domain/auth/usecase/login_usecase.dart';
import 'package:spotify_app/domain/auth/usecase/signup_usecase.dart';
import 'package:spotify_app/locator.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> signup(String email, String password, String fullName)async{
    emit(AuthLoading());
    CreateUserReqModel user = CreateUserReqModel(email: email, password: password, fullName: fullName);
    var res = await locator<SignUpUseCase>().call(params: user);

    res.fold(
      (l) {
        emit(AuthError(l));
      },
      (r) {
        emit(AuthSuccess(r));
      },
    );
  }

  Future<void> login(String email, String password)async{
    emit(AuthLoading());
    LoginUserReqModel user = LoginUserReqModel(email: email, password: password);
    var res = await locator<LogInUseCase>().call(params: user);

    res.fold(
      (l) {
        emit(AuthError(l));
      },
      (r) {
        emit(AuthSuccess(r));
      },
    );
  }
}
