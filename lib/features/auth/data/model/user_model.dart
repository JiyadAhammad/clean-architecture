import '../../domain/entities/profile.dart';

class UserModel extends Profile {
  UserModel({required super.id, required super.email, required super.name});

  factory UserModel.formJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
    );
  }
}
