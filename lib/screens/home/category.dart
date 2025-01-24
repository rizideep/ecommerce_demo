import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {'icon': Icons.checkroom, 'label': 'Shirt'},
    {'icon': Icons.beach_access, 'label': 'Bikini'},
    {'icon': Icons.work_outline, 'label': 'Work Equipment'},
    {'icon': Icons.man, 'label': 'Man Pants'},
    {'icon': Icons.hiking, 'label': 'Man Shoes'},
    {'icon': Icons.checkroom_outlined, 'label': 'Man Underwear'},
    {'icon': Icons.woman, 'label': 'Woman Pants'},

  ];

    CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Category',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                categories[index]['icon'],
                color: Colors.blue,
                size: 24,
              ),
              title: Text(
                categories[index]['label'],
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}


