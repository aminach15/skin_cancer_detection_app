import 'dart:io';
import 'package:flutter/material.dart';
import 'package:my_skin_cancer_app/utils/constants/colors.dart';
import 'package:my_skin_cancer_app/home.dart';
import 'package:url_launcher/url_launcher.dart';
// Import MyHome widget

class MyResult extends StatelessWidget {
  final File image;
  final List result;

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  MyResult({required this.image, required this.result});

  @override
  Widget build(BuildContext context) {

     final darkMode = isDarkMode(context);
    var maxConfidenceResult = result.reduce((curr, next) => curr['confidence'] > next['confidence'] ? curr : next);
    String label = maxConfidenceResult['label'];
    double confidence = maxConfidenceResult['confidence'] * 100; // Convert to percentage
    String advice = '';
    Color labelColor = Colors.green; // Default green for non-cancer
    String url = ''; // URL for "Learn More" button

    switch (label) {
      case 'mel':
        label = 'Melanoma';
        advice = 'You have cancer. Please contact a doctor.';
        labelColor = Colors.red; // Red for cancer detection
        url = 'https://www.mayoclinic.org/diseases-conditions/melanoma/symptoms-causes/syc-20374884'; // URL for Melanoma
        break;
      case 'nv':
        label = 'Melanocytic nevi';
        advice = "You don't have cancer";
        labelColor = Colors.orange;
        url = 'https://www.yalemedicine.org/conditions/melanocytic-nevi-moles'; // URL for Melanocytic nevi
        break;
      case 'akiec':
        label = 'Actinic keratoses and intraepithelial carcinoma';
        advice = 'You have cancer. Please contact a doctor';
        labelColor = Colors.red;
        url='https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6939186/';
        break;
      case 'bcc':
        label = 'Basal cell carcinoma';
        advice = 'You have cancer. Please contact a doctor.';
        labelColor = Colors.red; // Red for cancer detection
        url = 'https://www.mayoclinic.org/diseases-conditions/basal-cell-carcinoma/symptoms-causes/syc-20354187'; // URL for Basal cell carcinoma
        break;
      case 'bkl':
        label = 'Benign keratosis-like';
        advice = "You don't have cancer";
        labelColor = Colors.orange;
        url = 'https://my.clevelandclinic.org/health/diseases/21721-seborrheic-keratosis'; // URL for Benign keratosis-like
        break;
      case 'df':
        label = 'Dermatofibroma';
        advice = "You don't have cancer";
        labelColor = Colors.orange;
        url = 'https://dermnetnz.org/topics/dermatofibroma'; // URL for Dermatofibroma
        break;
      case 'vasc':
        label = 'Vascular lesions';
        advice = "You don't have cancer";
        labelColor = Colors.orange;
        url = 'https://www.ncbi.nlm.nih.gov/pmc/articles/PMC7007481/'; // URL for Vascular lesions
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title:  Text('Classification Result', style: TextStyle(color: darkMode ? Colors.white : Colors.black,)),
        centerTitle: true,
        backgroundColor: DColors.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
          children: [
            Container( // Wrap image in Container for rectangular shape with rounded corners
              height: 300.0, // Adjust height as needed
              width: 300.0, // Adjust width as needed
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0), // Rounded corners
                image: DecorationImage(
                  image: FileImage(image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20.0), // Add spacing between image and text
            Row( // Arrange label, confidence, and advice horizontally
              mainAxisAlignment: MainAxisAlignment.center, // Center content horizontally
              children: [
                Flexible( // Flexible widget for label with potential wrapping
                  child: Text(
                    label,
                    style: TextStyle(color: labelColor, fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 10.0), // Spacing between label and confidence
                Text(
                  '${confidence.toStringAsFixed(2)}%',
                  style: const TextStyle(color: Colors.blue, fontSize: 16.0),
                ),
              ],
            ),
            const SizedBox(height: 10.0), // Spacing between confidence and advice
            Text(
              advice,
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center, // Center advice text
            ),
            const SizedBox(height: 32.0), // Spacing between advice and button
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Beautiful button shape
                ), backgroundColor: DColors.buttonPrim, // Use your primary button color
                minimumSize: Size(200, 50), // Make button bigger
              ),
              onPressed: () => Navigator.pop(context), // Go back home on press
              child:  Text('Go Back Home',style: TextStyle(color: darkMode ? Colors.white : Colors.black,),),
            ),
            const SizedBox(height: 10.0), // Spacing between buttons
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0), // Beautiful button shape
                ), backgroundColor: DColors.buttonPrim, // Use your primary button color
                minimumSize: Size(200, 50), // Make button bigger
              ),
              onPressed: () => launch(url), // Launch URL on press
              child:  Text('Learn More',style: TextStyle(color: darkMode ? Colors.white : Colors.black,)),
            ),
          ],
        ),
      ),
    );
  }
}
