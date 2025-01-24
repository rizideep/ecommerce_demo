import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:prop_olx/screens/notification.dart';

import '../../utils/image.dart';
import '../home/category.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Flash Sale Banner
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              image: const DecorationImage(
                image: AssetImage(AppImages.ghar),
                fit: BoxFit.cover,
              ),
            ),
            height: 150,
            child: Stack(
              children: [
                const Positioned(
                  left: 16,
                  top: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Super Flash Sale',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '50% Off',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: Row(
                    children: [
                      _buildCountdownBox('08'),
                      const SizedBox(width: 4),
                      _buildCountdownBox('34'),
                      const SizedBox(width: 4),
                      _buildCountdownBox('52'),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Categories Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Category',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  getMoreCategoryScreen();
                },
                child: const Text('More Category'),
              ),
            ],
          ),
          SizedBox(
            height: 100,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              children: [
                _buildCategoryItem(Icons.man, 'Man Shirt'),
                _buildCategoryItem(Icons.work, 'Office Bag'),
                _buildCategoryItem(Icons.event_busy, 'Dress'),
                _buildCategoryItem(Icons.shopping_bag, 'Woman Bag'),
              ],
            ),
          ),

          // Flash Sale Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Flash Sale',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text('See More'),
              ),
            ],
          ),
          SizedBox(
            height: 250,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.zero,
              children: [
                _buildProductCard(
                    'Nike Air Max', 'https://via.placeholder.com/100', 299.43),
                _buildProductCard(
                    'Quilted Bag', 'https://via.placeholder.com/100', 99.99),
                _buildProductCard(
                    'Nike Air Max', 'https://via.placeholder.com/100', 299.43),
                _buildProductCard(
                    'Quilted Bag', 'https://via.placeholder.com/100', 99.99),
              ],
            ),
          ),
          const SizedBox(height: 20.0),

          GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: 4,
            physics: const NeverScrollableScrollPhysics(),
            // Disable scrolling
            shrinkWrap: true,
            // Let the grid expand according to the children
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              crossAxisSpacing: 15, // Horizontal space between items
              mainAxisSpacing: 12, // Vertical space between items
              childAspectRatio: .6, // Aspect ratio of the items
            ),
            itemBuilder: (context, index) {
              return _buildProductCardBottom(
                AppImages.gh,
                'Nike Air Max 270 React ENG',
                4,
                299.43,
                534.33,
              );
            },
          )
        ]),
      ),
    );
  }

  Widget _buildCountdownBox(String value) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoryItem(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(icon, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(String name, String imageUrl, double price) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: Image.asset(
              AppImages.gh,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '\$${price.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCardBottom(
    String imagePath,
    String title,
    double rating,
    double price,
    double originalPrice,
  ) {
    return Expanded(
      child: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagePath,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemSize: 16,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {
                      // Handle rating update
                    },
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '\$${price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '\$${originalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      color: Colors.grey,
                    ),
                  ),
                  const Text('24% Off'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getMoreCategoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CategoryScreen()),
    );
  }

  getNotificationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    );
  }
}
