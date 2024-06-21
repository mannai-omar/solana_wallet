import 'dart:convert';

class User {
  String status;
  int balance;
  String username;
  String email;
  String firstName;
  String lastName;
  bool isVerified;
  String role;
  String ownerId;
  String walletAddress;
  bool hasWallet; 
  DateTime lastLogin;
  String profilePictureUrl;
  String token;

  User({
    required this.status,
    required this.balance,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.isVerified,
    required this.role,
    required this.ownerId,
    required this.walletAddress,
    required this.hasWallet, 
    required this.lastLogin,
    required this.profilePictureUrl,
    required this.token, 
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json["status"] ?? '',
      balance: json["balance"] ?? 0,
      username: json["username"] ?? '',
      email: json["email"] ?? '',
      firstName: json["first_name"] ?? '',
      lastName: json["last_name"] ?? '',
      isVerified: json["isVerified"] ?? false,
      role: json["role"] ?? '',
      ownerId: json["owner_id"] ?? '',
      walletAddress: json["wallet_address"] ?? '',
      hasWallet: json["has_wallet"] ?? false,  
      lastLogin: json["last_login"] != null ? DateTime.parse(json["last_login"]) : DateTime.now(),
      profilePictureUrl: json["profile_picture_url"] ?? '',
      token: json["token"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "status": status,
    "balance": balance,
    "username": username,
    "email": email,
    "first_name": firstName,
    "last_name": lastName,
    "isVerified": isVerified,
    "role": role,
    "owner_id": ownerId,
    "wallet_address": walletAddress,
    "has_wallet": hasWallet,  
    "last_login": lastLogin.toIso8601String(),
    "profile_picture_url": profilePictureUrl,
  };
}

