part of 'check_login_cubit.dart';

@immutable
sealed class CheckLoginState {}

final class CheckLoginInitial extends CheckLoginState {}
final class CheckLoginLogged extends CheckLoginState {}
final class CheckLoginNotLogged extends CheckLoginState {}
