import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_skin_cancer_app/utils/constants/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class Mygrid1 extends StatelessWidget {
  const Mygrid1({super.key});

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = isDarkMode(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: DColors.primary,
            expandedHeight: 130.0,
            elevation: 0.0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
            ),
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding:
              const EdgeInsets.only(top: 72.0, left: 16.0, bottom: 16.0),
              background: Stack(
                children: [
                  Column(
                    children: [
                      const SizedBox(height: 35),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 10),
                          Text(
                            'Why early detection',
                            style: TextStyle(
                              fontSize: 30,
                              color: darkMode ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 10),
                          Text(
                            'matters?',
                            style: TextStyle(
                              fontSize: 30,
                              color: darkMode ? Colors.black : Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Add any additional widgets here
                    ],
                  ),
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                decoration: BoxDecoration(
                  color: darkMode ? Colors.black : Colors.white,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(32.0),
                    topLeft: Radius.circular(32.0),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Text(
                    'Early detection of skin cancer can lead to better outcomes, as it can be easier to treat and may not have spread to other parts of the body. Unlike cancers that develop inside the body, skin cancers form on the outside and are usually visible. That\'s why skin exams, both at home and with a dermatologist, are especially vital.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                        color: darkMode?Colors.black:Colors.teal.shade50,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(22.0),
                          bottomLeft: Radius.circular(22.0),
                          topRight: Radius.circular(22.0),
                          topLeft: Radius.circular(22.0),
                        )
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Image(image: AssetImage('assets/icons/CC_Logo.png'),height: 140,width: 140,),
                            SizedBox(
                              width: 80,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 15,
                                ),
                                Text('Early detection',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                Text('of skin cancer',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                                SizedBox(
                                  height: 10,
                                ),
                                InkWell(
                                  child: Text(
                                    'www.cancer.org',
                                    style: TextStyle(color: Colors.blue),
                                  ),
                                  onTap: () async {
                                    if (await canLaunch('https://www.cancer.org.au/about-us/policy-and-advocacy/position-statements/uv/early-detection')) {
                                      await launch('https://www.cancer.org.au/about-us/policy-and-advocacy/position-statements/uv/early-detection');
                                    } else {
                                      throw 'Could not launch URL';
                                    }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Regular skin examinations, including self-checks and professional evaluations by a dermatologist, are key in identifying skin cancer at an early stage, preventing it from growing or spreading further.',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Examine your skin once a month and learn about the warning signs of skin cancer. If you spot anything that just doesn’t look right, get it checked by your dermatologist as soon as possible.',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
