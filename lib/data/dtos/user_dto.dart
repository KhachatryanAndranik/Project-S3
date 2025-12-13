class UserDto {
  const UserDto({
    required this.id,
    required this.username,
    required this.name,
    required this.surname,
    required this.email,
  });

  final int id;
  final String username;
  final String name;
  final String surname;
  final String email;

  factory UserDto.fromJson(Map<String, dynamic> json) {
    return UserDto(
      id: num.tryParse(json['id'].toString())?.toInt() ?? 0,
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

  UserDto copyWith({
    int? id,
    String? username,
    String? name,
    String? surname,
    String? email,
  }) {
    return UserDto(
      id: id ?? this.id,
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
    );
  }
}
