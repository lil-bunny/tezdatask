class UserModel {
  String name;
  String email;
  String password;
  String filePath = '';
  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      this.filePath = ''});
}
