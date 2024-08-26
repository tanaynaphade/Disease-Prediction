import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  final TextEditingController _docNameController = TextEditingController();
  final TextEditingController _precautionsController = TextEditingController();
  final TextEditingController _symptomsController = TextEditingController();
  final TextEditingController _treatmentController = TextEditingController();

  Future<void> _addDataToFirestore() async {
    int docId = int.parse(_docNameController.text);
    List<String> precautions = _precautionsController.text.split(',');
    List<String> symptoms = _symptomsController.text.split(',');
    List<String> treatment = _treatmentController.text.split(',');

    await FirebaseFirestore.instance.collection('plant_disease_db').doc(docId.toString()).set({
      'precautions': precautions,
      'symptoms': symptoms,
      'treatment': treatment,
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Data added successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Plant Disease Info'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _docNameController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Document Name (int)'),
            ),
            TextField(
              controller: _precautionsController,
              decoration: InputDecoration(labelText: 'Precautions (comma-separated)'),
            ),
            TextField(
              controller: _symptomsController,
              decoration: InputDecoration(labelText: 'Symptoms (comma-separated)'),
            ),
            TextField(
              controller: _treatmentController,
              decoration: InputDecoration(labelText: 'Treatment (comma-separated)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addDataToFirestore,
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
