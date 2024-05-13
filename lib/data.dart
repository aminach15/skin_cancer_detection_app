import 'package:flutter/cupertino.dart';
import 'package:my_skin_cancer_app/blogs/blog1.dart';
import 'package:my_skin_cancer_app/blogs/blog3.dart';
import 'package:my_skin_cancer_app/blogs/blog4.dart';
import 'package:my_skin_cancer_app/blogs/blog5.dart';

import 'blogs/blog2.dart';

class AppData{
  AppData._();

  static final List<String> innerStyleImages =[
    'https://static.thcdn.com/images/medium/original/app/uploads/sites/36/2021/08/pexels-ron-lach-8142198-2-1_1627921722.jpg',
    'https://i0.wp.com/theeverydayman.co.uk/wp-content/uploads/2024/05/man-applying-moisturizer-demonstrating-skin-care-for-men-1.jpg?resize=1024%2C688&ssl=1',
    'https://www.reliablerxpharmacy.com/blog/wp-content/uploads/2016/03/skin-cancer1.jpg',
    'https://media-cldnry.s-nbcnews.com/image/upload/t_fit-1240w,f_auto,q_auto:best/newscms/2019_18/1429065/how-to-find-your-skin-type-today-main-002-190424.jpg',
    'https://archziner.com/wp-content/uploads/2022/06/woman-putting-on-sunscreen-on-her-face.webp'
  ];

  static final List<Widget> innerStyleWidgets =[
    MyBlog1(),
    MyBlog2(),
    MyBlog3(),
    MyBlog4(),
    MyBlog5(),

  ];

}