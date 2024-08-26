import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:new_app/home_page.dart';
import 'plant_disease_info_page.dart';
import 'predictor_plants.dart';

class PlantsScreen extends StatefulWidget {
  const PlantsScreen({Key? key}) : super(key: key);

  @override
  _PlantsScreenState createState() => _PlantsScreenState();
}

class _PlantsScreenState extends State<PlantsScreen> {
  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _predictDisease() async {
    if (_image != null) {
      var predictedClass = await processImageAndPredict(context, _image!);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DiseaseInfoPage(diseaseIndex: predictedClass - 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(223, 240, 227, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(223, 240, 227, 1),
        title: const Center(
            child: Text(
              'Plant Disease Detection',
              style: TextStyle(
                  fontFamily: 'SourceSans3',
                  fontSize: 25,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: (){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()),);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _image == null ? Text('No image selected.') : Image.file(_image!),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Color.fromRGBO(223, 240, 227, 1),
              ),
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Color.fromRGBO(223, 240, 227, 1),
              ),
              onPressed: _predictDisease,
              child: Text('Predict Disease'),
            ),
          ],
        ),
      ),
    );
  }
}
