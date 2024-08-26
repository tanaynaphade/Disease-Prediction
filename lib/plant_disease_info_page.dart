import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseInfoPage extends StatelessWidget {
  final int diseaseIndex;
  static const List<String> diseaseNames = [
    'Tomato Late Blight', 'Tomato healthy', 'Grape healthy', 'Orange Haunglongbing (Citrus greening)',
    'Soybean healthy', 'Squash Powdery mildew', 'Potato healthy', 'Corn (maize) Northern Leaf Blight',
    'Tomato Early blight', 'Tomato Septoria leaf spot', 'Corn (maize) Cercospora leaf spot Gray leaf spot',
    'Strawberry Leaf scorch', 'Peach healthy', 'Apple Apple scab', 'Tomato Tomato Yellow Leaf Curl Virus',
    'Tomato Bacterial spot', 'Apple Black rot', 'Blueberry healthy', 'Cherry (including sour) Powdery mildew',
    'Peach Bacterial spot', 'Apple Cedar apple rust', 'Tomato Target Spot', 'Pepper bell healthy',
    'Grape Leaf blight (Isariopsis Leaf Spot)', 'Potato Late blight', 'Tomato Tomato mosaic virus',
    'Strawberry healthy', 'Apple healthy', 'Grape Black rot', 'Potato Early blight',
    'Cherry (including sour) healthy', 'Corn (maize) Common rust', 'Grape Esca (Black Measles)',
    'Raspberry healthy', 'Tomato Leaf Mold', 'Tomato Spider mites Two-spotted spider mite',
    'Pepper bell Bacterial spot', 'Corn (maize) healthy'
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
            .collection('plant_disease_db')
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
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Symptoms:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        SizedBox(height: 10),
                        ...symptoms.map((s) => Text('- $s', style: TextStyle(fontSize: 16, color: Colors.green))),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Precautions:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        SizedBox(height: 10),
                        ...precautions.map((p) => Text('- $p', style: TextStyle(fontSize: 16, color: Colors.green))),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Treatment:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        SizedBox(height: 10),
                        ...treatment.map((t) => Text('- $t', style: TextStyle(fontSize: 16, color: Colors.green))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
