import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String username;
  final String email;
  final String phoneNumber;
  final String profileUrl;
  final String address;
  final String dob;
  final bool emailVerified;
  final List<String> savedPets;
  final int? totalPets; // Added field

  UserModel( {
    required this.userId,
    this.address='',
    required this.name,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.profileUrl,
    required this.dob,
    this.emailVerified = false,
    this.savedPets = const [],
    this.totalPets=0, // Updated constructor
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      name: json['name'],
      address: json['address']??'',
      username: json['username']??'',
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profileUrl: json['profileUrl'],
      dob: json['dob'],
      emailVerified: json['emailVerified'],
      totalPets: json['totalPets'], // Updated field
      savedPets: List<String>.from(json['savedPets'])??[], // Updated field
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'username': username,
      'address': address,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileUrl': profileUrl,
      'dob': dob,
      'emailVerified': emailVerified,
      'totalPets': totalPets, // Updated field
      'savedPets': savedPets ??[], // Updated field
    };
  }
}
