import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseInfoPage extends StatelessWidget {
  final int diseaseIndex;
  static const List<String> diseaseNames = [
    // List of diseases you have in your app.
  ];

  DiseaseInfoPage({required this.diseaseIndex});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(223, 240, 227, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(223, 240, 227, 1),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Disease Information', style: TextStyle(color: Colors.green)),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('animal_disease_db') // Ensure this collection exists in Firestore
            .doc('$diseaseIndex')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('No information available'));
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;
          List<String> symptoms = List<String>.from(data['symptoms'] ?? []);
          List<String> precautions = List<String>.from(data['precautions'] ?? []);
          List<String> treatment = List<String>.from(data['treatment'] ?? []);

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Disease: ${diseaseNames[diseaseIndex]}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                SizedBox(height: 20),
                _buildCard('Symptoms:', symptoms),
                SizedBox(height: 20),
                _buildCard('Precautions:', precautions),
                SizedBox(height: 20),
                _buildCard('Treatment:', treatment),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCard(String title, List<String> content) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            SizedBox(height: 10),
            ...content.map((item) => Text('- $item', style: TextStyle(fontSize: 16, color: Colors.green))),
          ],
        ),
      ),
    );
  }
}
