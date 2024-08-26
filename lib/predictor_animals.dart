import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

// Mapping from strings to indices (use your actual mappings from the model)
Map<String, int> animalNameLookup = {
  "Dog": 0,
  "Cat": 1,
  // Add other animals as used in your model
};

List<Map<String, int>> symptomLookups = [
  {"Symptom1": 0, "Symptom2": 1}, // Symptom 1 lookup table
  {"Symptom3": 0, "Symptom4": 1}, // Symptom 2 lookup table
  {"Symptom5": 0, "Symptom6": 1}, // Symptom 3 lookup table
  {"Symptom7": 0, "Symptom8": 1}, // Symptom 4 lookup table
  {"Symptom9": 0, "Symptom10": 1}, // Symptom 5 lookup table
];

List<int> encodeInput(String animalName, List<String> symptoms) {
  int animalEncoded = animalNameLookup[animalName] ?? -1;
  List<int> symptomsEncoded = List.generate(5, (index) {
    return symptomLookups[index][symptoms[index]] ?? -1;
  });

  return [animalEncoded, ...symptomsEncoded];
}

Future<int> processAnimalSymptomsAndPredict(BuildContext context, String animalName, List<String> symptoms) async {
  // Encode input
  var input = encodeInput(animalName, symptoms);

  // Create input tensor (shape and type should match model requirements)
  var inputTensor = [input];  // Adjust the shape if needed

  // Load the model
  final interpreter = await Interpreter.fromAsset('assets/animal_disease_model_quantized.tflite');

  // Prepare output tensor
  var output = List.filled(1, 0);

  // Run inference
  interpreter.run(inputTensor, output);

  // Close the interpreter
  interpreter.close();

  // Return the predicted disease index
  return output[0];
}
