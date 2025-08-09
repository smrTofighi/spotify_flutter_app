import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify_app/domain/auth/usecase/check_login_usecase.dart';
import 'package:spotify_app/locator.dart';

part 'check_login_state.dart';

class CheckLoginCubit extends Cubit<CheckLoginState> {
  CheckLoginCubit() : super(CheckLoginInitial());

  void checkLogin()async{
    var status = await locator<CheckLoginUseCase>().call();
    if(status){
      emit(CheckLoginLogged());
    }else {
      emit(CheckLoginNotLogged());
    }
  }
}
