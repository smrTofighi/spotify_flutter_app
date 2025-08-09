part of 'profile_info_cubit.dart';

@immutable
sealed class ProfileInfoState {}

final class ProfileInfoLoading extends ProfileInfoState {}
final class ProfileInfoLoaded extends ProfileInfoState {
  final UserEntity userEntity;
  ProfileInfoLoaded(this.userEntity);
}
final class ProfileInfoError extends ProfileInfoState {}
