import 'package:flutter/material.dart';

import '../../utils/image.dart';
import '../notification.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const TextField(
          decoration: InputDecoration(
            hintText: 'Search Product',
            prefixIcon: Icon(Icons.search),
            border: InputBorder.none,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              getNotificationScreen();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Man Fashion',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildCategoryRow([
                _buildCategoryItem('Office Bag',   AppImages.ghar,),
                _buildCategoryItem('Shirt',   AppImages.ghar,),
                _buildCategoryItem('T-Shirt',   AppImages.ghar,),
                _buildCategoryItem('Shoes',   AppImages.ghar,),
              ]),
              const SizedBox(height: 16.0),
              _buildCategoryRow([
                _buildCategoryItem('Pants',   AppImages.ghar,),
                _buildCategoryItem('Underwear' , AppImages.ghar),
              ]),
              const SizedBox(height: 24.0),
              const Text(
                'Woman Fashion',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              _buildCategoryRow([
                _buildCategoryItem('T-Shirt',   AppImages.ghar,),
                _buildCategoryItem('Dress',   AppImages.ghar,),
                _buildCategoryItem('Pants',   AppImages.ghar,),
                _buildCategoryItem('Skirt',  AppImages.ghar,),
              ]),
              const SizedBox(height: 16.0),
              _buildCategoryRow([
                _buildCategoryItem('Bag',   AppImages.ghar,),
                _buildCategoryItem('Heels',   AppImages.ghar,),
                _buildCategoryItem('Bikini',   AppImages.ghar,),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryRow(List<Widget> items) {
    return Wrap(
      spacing: 16.0,
      runSpacing: 16.0,
      children: items,
    );
  }

  Widget _buildCategoryItem(String title, String iconPath) {
    return Container(
      width: 80.0,
      height: 80.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue[50],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            iconPath,
            width: 32.0,
            height: 32.0,
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  getNotificationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    );
  }
}