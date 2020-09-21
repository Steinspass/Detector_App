import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:detector_app/provider/tflite_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool _laoding = true;
  File _image;
  List<dynamic> _output;

  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value){
      setState(() {});
    });
  }


  @override
  void dispose() {
    super.dispose();
    closeTFlite();
  }

  pickImagePhoto() async {

    var image = await picker.getImage(source: ImageSource.camera);

    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    _output = await classifyImage(_image);
    _laoding = false;

    setState(() {});


  }  


  pickImageGallery() async {

    var image = await picker.getImage(source: ImageSource.gallery);

    if(image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    _output = await classifyImage(_image);
    _laoding = false;
    
    setState(() {});


  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101010),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 80.0,),
            _titleOfPage(),
            SizedBox(height: 6.0,),
            _subtitleOfPage(),
            SizedBox(height: 50.0,),
            _centerImage(),
            _columnOfButtons()
          ],
        ),
      ),
    );
  }

  Widget _titleOfPage() {
    return ColorizeAnimatedTextKit(
      text: ['TeachableMachine.com with ConvNet'],
      textStyle: TextStyle(
        fontSize: 18.0
      ),
      colors: [
        Colors.amberAccent[400],
        Colors.orangeAccent[700],
        Colors.pinkAccent
      ],
      repeatForever: true,
      speed: Duration(milliseconds: 400),
    );
  }

  Widget _subtitleOfPage() {
    return ColorizeAnimatedTextKit(
      text: ['Detect Dog & Cat'],
      textStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w400
      ),
      colors: [
        Colors.amberAccent[400],
        Colors.orangeAccent[700],
        Colors.pinkAccent
      ], 
      
      repeatForever: true,
      speed: Duration(milliseconds: 400),
    );
  }

  Widget _centerImage() {

    return Center(
      child: _laoding ? _imagePlaceholder() : _imagePhoto(),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      width: 250.0,
      child: Column(
        children: [
          Image.asset('assets/cat.png'),
          SizedBox(height: 40.0,)
        ],
      ),
    );
  }

  Widget _columnOfButtons() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          _buttonTakePhoto(),
          SizedBox(height: 25.0,),
          _buttonOpenGallery()
        ],
      ),
    );
  }

  Widget _buttonTakePhoto() {
    return GestureDetector(
      onTap: pickImagePhoto,
      child: Container(
        width: MediaQuery.of(context).size.width - 200,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 18.0
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.amberAccent[400],
              Colors.orangeAccent[700],
              Colors.pinkAccent
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Text(
          'Take a photo',
          style: TextStyle(
            color: Colors.blueGrey[50],
            fontSize:  18.0,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }

  Widget _buttonOpenGallery() {
    return GestureDetector(
      onTap: pickImageGallery,
      child: Container(
        width: MediaQuery.of(context).size.width - 200,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 18.0
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          gradient: new LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.pinkAccent,
              Colors.orangeAccent[700],
              Colors.amberAccent[400],
            ], // whitish to gray
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: Text(
          'Open Gallery',
          style: TextStyle(
            color: Colors.blueGrey[50],
            fontSize:  18.0,
            fontWeight: FontWeight.w400
          ),
        ),
      ),
    );
  }

  Widget _imagePhoto() {
    return Container(
      child: Column(
        children: [
           Container(
             height: 250.0,
             child: Image.file(_image),
           ),
           SizedBox(
             height: 20.0,
           ),
           _output != null 
            ? _textWhatIs() 
            : Container(),
            SizedBox(height: 20.0,)
        ],
      ),
    );
  }

  Widget _textWhatIs() {
    String whatIs = 'Is a ${_output[0]['label']}';

    return Text(
      whatIs,
      style: TextStyle(
        color: Colors.white,
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic
      ),
    );
  }
}