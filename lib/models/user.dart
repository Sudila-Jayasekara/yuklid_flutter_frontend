class User {
  final String email;
  final DateTime issuedAt;
  final DateTime expiresAt;

  User({required this.email, required this.issuedAt, required this.expiresAt});

  factory User.fromToken(Map<String, dynamic> decoded) {
    return User(
      email: decoded['sub'],
      issuedAt: DateTime.fromMillisecondsSinceEpoch(decoded['iat'] * 1000),
      expiresAt: DateTime.fromMillisecondsSinceEpoch(decoded['exp'] * 1000),
    );
  }
}
