class UserDto {
  const UserDto({
    required this.id,
    required this.username,
    required this.name,
    required this.surname,
    required this.email,
  });

  final String id;
  final String username;
  final String name;
  final String surname;
  final String email;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: json['id'].toString(),
      username: json['username'].toString(),
      name: json['name'].toString(),
      surname: json['surname'].toString(),
      email: json['email'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'surname': surname,
      'email': email,
    };
  }
}
