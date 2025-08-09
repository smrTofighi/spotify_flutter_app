import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:spotify_app/domain/auth/entity/user_entity.dart';
import 'package:spotify_app/domain/auth/usecase/get_user_usecase.dart';
import 'package:spotify_app/locator.dart';

part 'profile_info_state.dart';

class ProfileInfoCubit extends Cubit<ProfileInfoState> {
  ProfileInfoCubit() : super(ProfileInfoLoading());

  Future<void> getUser() async {
    var res = await locator<GetUserUseCase>().call();
    
    res.fold(
      (l) {
        emit(ProfileInfoError());
      },
      (r) {
        emit(ProfileInfoLoaded(r));
      },
    );
  }
}
