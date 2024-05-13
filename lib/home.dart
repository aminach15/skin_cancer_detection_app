import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_skin_cancer_app/grid1.dart';
import 'package:my_skin_cancer_app/image_viewer_helper.dart';
import 'package:my_skin_cancer_app/profile.dart';
import 'package:my_skin_cancer_app/results.dart';
import 'package:my_skin_cancer_app/utils/constants/colors.dart';
import 'package:my_skin_cancer_app/utils/constants/sizes.dart';
import 'package:tflite_v2/tflite_v2.dart';

import 'blogs/all_blogs.dart';
import 'data.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {

  late CarouselController innerCarouselController;
  int innerCurrentPage = 0;

  late File _image;
  late List _result;
  bool imageSelected = false;

  @override
  void initState() {
    super.initState();
    loadModel();
    innerCarouselController = CarouselController();

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

  int currentTab = 0;
  final List<Widget> screens = [
    const MyHome(),
    const MySettings(),
  ];
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const MyHome();

  @override
  Widget build(BuildContext context) {
    final darkMode = isDarkMode(context);
    return Scaffold(
      body:  CustomScrollView(
        slivers: [
            SliverAppBar(
            backgroundColor: DColors.primary,
            expandedHeight: 333.0,
            elevation: 0.0,
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark,
              ),
              pinned: true,

              flexibleSpace: FlexibleSpaceBar(

                background:
                Stack(  // Use Stack instead of Column to allow overlaying of widgets
                  children: [
                     Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Your personal',style: TextStyle(fontSize: 35,
                                color: darkMode? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold),),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('dermatologist',style: TextStyle(fontSize: 35,
                                color: darkMode? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [


                        Image.asset(
                          'assets/icons/doctor.png',
                          fit: BoxFit.contain,
                          height: 230,
                          width: 350,
                        ),



                      ]
                    ),




                  ],
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0.0),
                child: Container(
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: darkMode?Colors.black:Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(32.0),
                      topLeft: Radius.circular(32.0)
                    )
                  ),

                ),
              ),



            ),
          const SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Blogs',style: TextStyle(fontSize: 30),),

              ],
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),
          // SliverToBoxAdapter(
          //   child: Padding(
          //     padding:const  EdgeInsets.all(20.0),
          //     child: ClipRRect(
          //       borderRadius: BorderRadius.circular(20),
          //       child: Container(
          //         height: 400,
          //         color: darkMode ? const Color.fromRGBO(35, 35, 35, 100) : Colors.teal.shade50,
          //       ),
          //     ),
          //   ),
          // ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 250,
              width: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: CarouselSlider(
                      carouselController: innerCarouselController,
                      items: AppData.innerStyleImages.asMap().entries.map((entry){
                        int index = entry.key;
                        String imagePath = entry.value;
                        return Builder(builder: (BuildContext context){
                          return GestureDetector(
                            onTap: () {
                              // Navigate to the corresponding widget in the innerStyleWidgets list
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AppData.innerStyleWidgets[index]));
                            },
                            child: ImageViewerHelper.show(
                              context: context,
                              url: imagePath,
                            ),
                          );
                        });
                      }).toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        autoPlay: true,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.8,
                        onPageChanged: (index ,reason){
                          setState(() {
                            innerCurrentPage = index;
                          });
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    child: Row(
                      children:List.generate(
                        AppData.innerStyleImages.length,
                            (index) {
                          bool isSelected = innerCurrentPage == index;
                          return GestureDetector(
                            onTap: (){
                              innerCarouselController.animateToPage(index);
                            },
                            child: AnimatedContainer(
                              width: isSelected? 55 : 17,
                              margin: EdgeInsets.symmetric(
                                  horizontal: isSelected? 6:3
                              ),
                              height: 10,
                              decoration: BoxDecoration(
                                color: isSelected? Colors.white : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(40),
                              ),
                              duration: Duration(
                                milliseconds: 300,
                              ),
                              curve: Curves.ease,
                            ),
                          );
                        },
                      ),
                    ),
                  )],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 15,
            ),
          ),
          SliverToBoxAdapter(
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0), // Beautiful button shape
                  ),
                  backgroundColor: DColors.buttonPrim, // Use your primary button color
                  minimumSize: Size(200, 50), // Make button bigger
                ),
                onPressed: () {
                  // Navigate to AllBlogs() widget on press
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllBlogs()));
                },
                child: Text('See all blogs', style: TextStyle(color: darkMode ? Colors.white : Colors.white,fontSize:23,fontFamily: 'Popins'),),
              ),
            ),
          ),


          SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 275,
                  color: darkMode ? const Color.fromRGBO(35, 35, 35, 100) : Colors.teal.shade50,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 30,
                              ),
                              Text(
                                'Early detection matters ',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Popins',
                                ),
                              ),
                            ],
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                'Protect your skin ',
                                style: TextStyle(
                                  fontSize: 25,
                                  fontFamily: 'Popins',
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Image.asset(
                              'assets/icons/Medical_record.png',
                              fit: BoxFit.contain,
                              height: 200,
                              width: 200,
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Mygrid1()),
                              );
                            },
                            child: Container(
                              width: 90,  // Increased size
                              height: 90,  // Increased size
                              decoration:  BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.teal.shade50,
                              ),
                              child: Image(
                                image: AssetImage('assets/icons/forward.png'),
                                height: 50,
                                width: 50,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),





        


        ],
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

