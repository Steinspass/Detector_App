import 'dart:io';

import 'package:tflite/tflite.dart';


 Future<List<dynamic>> classifyImage(File image) async {
  List<dynamic> output = await Tflite.runModelOnImage(
    path: image.path, 
    numResults: 2,
    threshold: 0.5,
    imageMean: 127.5,
    imageStd: 127.5
  );

  return output;
}

 loadModel() async {

  await Tflite.loadModel(
    model: 'assets/model_unquant.tflite', 
    labels: 'assets/labels.txt'
  );
}

closeTFlite(){
  Tflite.close();
}