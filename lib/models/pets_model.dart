import 'package:cloud_firestore/cloud_firestore.dart';

class PetsModel {
  final String petName;
  final String petAge;
  final String petAddress;
  final String petDescription;
  final String petId;
  final String petImage;
  final String breed;
  final String gender;
  final List<String> vaccinations;
  final String petOwnerId;

  PetsModel({
    required this.petDescription,
    required this.petName,
    required this.petAge,
    required this.petAddress,
    required this.petId,
    required this.petImage,
    required this.petOwnerId,
    required this.breed,
    required this.gender,
    this.vaccinations = const [], // List of strings initially empty
  });

  factory PetsModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return PetsModel(
      petId: data['petId'] ,
      petImage: data['petImage'],
      petName: data['petName'],
      petAge: data['petAge'],
      petAddress: data['petAddress'],
      breed: data['breed'],
      gender: data['gender'],
      petOwnerId: data['petOwnerId'], // Added petOwnerId field
      vaccinations: List<String>.from(data['vaccinations'] ?? []), petDescription: data['petDescription'], // Convert to List<String> or use empty list if null
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'petImage': petImage,
      'petId': petId,
      'petName': petName,
      'petAge': petAge,
      'petAddress': petAddress,
      'breed': breed,
      'gender': gender,
      'petOwnerId': petOwnerId, // Added petOwnerId field
      'vaccinations': vaccinations,
      'petDescription': petDescription,
    };
  }
}
