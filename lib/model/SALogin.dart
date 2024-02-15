class LoginRequest {
  final String username;
  final String password;
  final String role;

  LoginRequest({
    required this.username,
    required this.password,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'role': role,
    };
  }
}

class LoginResponse {
  final String message;
  final int statusCode;
  final String role;
  final String token;

  LoginResponse({
    required this.message,
    required this.statusCode,
    required this.role,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      message: json['message'],
      statusCode: json['statusCode'],
      role: json['role'],
      token: json['token'],
    );
  }
}
