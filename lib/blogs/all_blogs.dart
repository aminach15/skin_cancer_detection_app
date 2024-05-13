import 'package:flutter/material.dart';
class AllBlogs extends StatefulWidget {
  const AllBlogs({super.key});

  @override
  State<AllBlogs> createState() => _AllBlogsState();
}

class _AllBlogsState extends State<AllBlogs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('All blogs'),
    );
  }
}
