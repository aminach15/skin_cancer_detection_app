import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_skin_cancer_app/home.dart';
import 'package:my_skin_cancer_app/profile.dart';
import 'package:my_skin_cancer_app/results.dart';
import 'package:my_skin_cancer_app/utils/constants/colors.dart';
import 'package:my_skin_cancer_app/utils/constants/sizes.dart';
import 'package:tflite_v2/tflite_v2.dart';
class MyNavBar extends StatefulWidget {
  const MyNavBar({super.key});

  @override
  State<MyNavBar> createState() => _MyNavBarState();
}

class _MyNavBarState extends State<MyNavBar> {

  late File _image;
  late List _result;
  bool imageSelected = false;

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  Future loadModel() async {
    Tflite.close();
    String? res;
    res = await Tflite.loadModel(
        model: 'assets/model/model_skin_detection.tflite',
        labels: 'assets/model/labels.txt');
    print('Models loading status : $res ');
  }

  Future imageClassification(File image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );

    setState(() {
      _result = recognitions!;
      _image = image;
      imageSelected = true;
    });

    // Navigate to MyResult page after classification
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyResult(image: image, result: recognitions!),
      ),
    );

  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  int currentTab=0;
  final List <Widget> screens=[
    MyHome(),
    const MySettings(),
  ];

  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen=const MyHome();



  @override
  Widget build(BuildContext context) {

    final darkMode = isDarkMode(context);


    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkMode ? DColors.dark : DColors.buttonPrim,
        elevation: 0,
        shape: const CircleBorder(),
        onPressed: pickImage,
        tooltip: "Pick Image",
        child: Image.asset(
          'assets/icons/camera.png',
          color: darkMode ? Colors.white : Colors.black,
          height: DSizes.iconLg,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: darkMode ? DColors.dark : DColors.light,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const MyHome();
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/home.png',
                      height: DSizes.iconMd,
                      color: currentTab == 0
                          ? DColors.buttonPrim
                          : DColors.buttonSec,
                    ),
                    Text(
                      'Home',
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: DSizes.fontsizeSm,
                      ),
                    ),
                  ],
                ),
              ),
              MaterialButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const MySettings(); // Corrected here
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/icons/settings.png',
                      height: DSizes.iconMd,
                      color: currentTab == 1
                          ? DColors.buttonPrim
                          : DColors.buttonSec,
                    ),
                    Text(
                      'Settings',
                      style: TextStyle(
                        color: darkMode ? Colors.white : Colors.black,
                        fontSize: DSizes.fontsizeSm,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }
  Future pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    File image = File(pickedFile!.path);
    imageClassification(image);
  }

}

