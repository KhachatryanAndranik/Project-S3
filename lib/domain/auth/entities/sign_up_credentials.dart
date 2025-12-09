import 'package:library_app/domain/auth/entities.dart';

class SignUpCredentials extends BaseOnboardingCredentials {
  const SignUpCredentials({
    required super.username,
    required super.password,
    required this.email,
    required this.name,
    required this.surname,
  });

  final String name;
  final String surname;
  final String email;

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();

    json.addAll({
      'name': name,
      'surname': surname,
      'email': email,
    });
    
    return json;
  }
}
