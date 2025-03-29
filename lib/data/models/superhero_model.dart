import 'package:cloud_firestore/cloud_firestore.dart';

class SuperheroModel{
  final String? id;
  final String? username;
  final String? fullName;
  final int? energyLevel;
  final String email;
  final String? password;

  SuperheroModel({
    this.id,
    this.username,
    this.fullName,
    required this.email,
    this.energyLevel,
    this.password,
  });

  SuperheroModel copyWith({
    String? id,
    String? username,
    String? fullName,
    int? energyLevel,
    String? email,
    String? password,
    Map<String, dynamic>? plansToDo,
  }) {
    return SuperheroModel(
      id: id ?? this.id,
      username: username ?? this.username,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      energyLevel: energyLevel ?? this.energyLevel,
      password: password ?? this.password,
    );
  }

  factory SuperheroModel.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return SuperheroModel(
      id: doc.id,
      username: data['username'],
      fullName: data['fullName'],
      email: data['email'],
      energyLevel: data['energyLevel'],
      password: data['password'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'fullName': fullName,
      'email': email,
      'energyLevel': energyLevel,
      'password': password,
    };
  }
}