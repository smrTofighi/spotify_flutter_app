class CreateUserReqModel {
  final String fullName;
  final String email;
  final String password;

  CreateUserReqModel({
    required this.fullName,
    required this.email,
    required this.password,
  });
}