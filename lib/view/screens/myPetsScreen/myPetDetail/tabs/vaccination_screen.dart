import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_pal/core/constants/firebase_constants.dart';
import 'package:pet_pal/core/services/firebaseServices/firebase_crud.dart';
import 'package:pet_pal/core/utils/lists.dart';
import 'package:pet_pal/models/pets_model.dart';

class VaccinationScreen extends StatelessWidget {
  // final List<Map<String, String>> vaccines;
  final PetsModel petsModel;

  const VaccinationScreen({
    super.key,
    required this.petsModel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: vaccinesForDogsInPakistan.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: VaccineTile(
            vaccineName: vaccinesForDogs[index]['name'] ?? '',
            interval: vaccinesForDogs[index]['interval'] ?? '',
            isVaccinated:
                petsModel.vaccinations.contains(vaccinesForDogs[index]['name']),
            onCheckMethod: () async {
              if(!petsModel.vaccinations.contains(vaccinesForDogs[index]['name'])){
                await FirebaseCRUDService.instance.updateDocument(collectionReference: FirebaseConstants.petsCollectionReference, docId: petsModel.petId, data: {
                  'vaccinations': FieldValue.arrayUnion([vaccinesForDogs[index]['name']])
                });
              }
            },
          ),
        );
      },
    );
  }
}

///
class VaccineTile extends StatefulWidget {
  final String vaccineName;
  final String interval;
  final bool isVaccinated;
  final Function() onCheckMethod;

  const VaccineTile({super.key,
    required this.vaccineName,
    required this.interval,
    required this.isVaccinated,
    required this.onCheckMethod,
  });

  @override
  _VaccineTileState createState() => _VaccineTileState();
}

class _VaccineTileState extends State<VaccineTile> {
  bool isVaccinated = false;

  @override
  void initState() {
    super.initState();
    // Set the initial value of isVaccinated based on widget.isVaccinated
    isVaccinated = widget.isVaccinated;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: const Icon(
          Icons.local_hospital,
          color: Colors.blue,
          size: 40,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.vaccineName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Next dose: ${widget.interval}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
        trailing: Checkbox(
          value: isVaccinated,
          onChanged: (newValue) {
            if (widget.isVaccinated == false) {
              setState(() {
                isVaccinated = true;
              });
              widget.onCheckMethod();
            }
          },
        ),
      ),
    );
  }
}

