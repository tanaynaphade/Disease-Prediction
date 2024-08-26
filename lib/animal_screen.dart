import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'predictor_animals.dart';  // Assuming this is the file containing your predictor function
import 'animal_disease_info_page.dart';

class AnimalScreen extends StatefulWidget {
  const AnimalScreen({Key? key}) : super(key: key);

  @override
  _AnimalScreenState createState() => _AnimalScreenState();
}

class _AnimalScreenState extends State<AnimalScreen> {
  String selectedAnimal = "Dog";  // Default value
  List<String> selectedSymptoms = [];

  // Placeholder data, replace these with the actual lists from the CSV parsing
  final List<String> animalNames = ['Dog', 'Cat', 'Rabbit', 'Cow', 'Chicken', 'Horse', 'Sheep', 'Pig'];
  final List<String> symptomsList = ['Fever', 'Ulcers', 'Facial Swelling', 'Swollen lymph nodes', 'Diarrhea', 'Cough'];

  void _predictDisease() async {
    if (selectedAnimal.isNotEmpty && selectedSymptoms.isNotEmpty) {
      var predictedClass = await processAnimalSymptomsAndPredict(context, selectedAnimal, selectedSymptoms);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => DiseaseInfoPage(diseaseIndex: predictedClass),
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
              'Animal Disease Detection',
              style: TextStyle(
                  fontFamily: 'SourceSans3',
                  fontSize: 25,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            )),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.green),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownSearch<String>(
              items: animalNames,
              selectedItem: selectedAnimal,
              onChanged: (String? newValue) {
                setState(() {
                  selectedAnimal = newValue!;
                });
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Select Animal",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
              ),
              popupProps: PopupProps.menu(
                showSearchBox: true,
              ),
            ),
            SizedBox(height: 20),
            DropdownSearch<String>.multiSelection(
              items: symptomsList,
              selectedItems: selectedSymptoms,
              onChanged: (List<String> newValue) {
                setState(() {
                  selectedSymptoms = newValue;
                });
              },
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  labelText: "Select Symptoms",
                  contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                  border: OutlineInputBorder(),
                ),
              ),
              popupProps: PopupPropsMultiSelection.menu(
                showSearchBox: true,
              ),
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
