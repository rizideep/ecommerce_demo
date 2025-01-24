import 'package:flutter/material.dart';
import 'package:prop_olx/src/app_colors.dart';
import 'package:prop_olx/utils/image.dart';

import '../notification.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  int _itemQuantity1 = 1;
  int _itemQuantity2 = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Your Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              getNotificationScreen();
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCartItem(
              'Nike Air Zoom Pegasus 36 Miami',
              AppImages.h, // Replace with actual image path
              299.43,
              _itemQuantity1,
              (value) => setState(() => _itemQuantity1 = value),
            ),
            const SizedBox(height: 10,),
            _buildCartItem(
              'Nike Air Zoom Pegasus 36 Miami',
              AppImages.ghar, // Replace with actual image path
              299.43,
              _itemQuantity2,
              (value) => setState(() => _itemQuantity2 = value),
            ),
            const SizedBox(height: 10,),
              Row(
                children: [
                  const Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: 'Enter Coupon Code',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5,),
                  ElevatedButton(
                    onPressed: () {
                      // Handle coupon code application
                    },
                    child: const Text('Apply'),
                  ),
                ],
              ),
           
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Items (2)',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8.0),
                  Text('Shipping'),
                  SizedBox(height: 8.0),
                  Text('Import Charges'),
                  SizedBox(height: 16.0),
                  Text(
                    'Total Price: \$766.86',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Handle checkout
              },
              child: const Text('Check Out'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(
    String title,
    String imagePath,
    double price,
    int quantity,
    void Function(int) onQuantityChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
       border: Border.all(color: gray400),
        borderRadius: BorderRadius.circular(16),

      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 80.0,
            height: 80.0,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(title),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            child: const Icon(Icons.favorite),
                            onTap: () {
                              // Handle favorite tap
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: InkWell(
                            child: const Icon(Icons.delete),
                            onTap: () {
                              // Handle delete tap
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(child: Text('\$${price.toStringAsFixed(2)}')),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: gray400),
                        borderRadius: BorderRadius.circular(8),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0,
                            ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap:
                                    () {
                                  if (quantity > 1) {
                                    onQuantityChanged(quantity - 1);
                                  }
                                },
                              child: const Icon(Icons.remove),

                            ),
                            Text('$quantity'),
                            InkWell(
                              onTap: () {
                                onQuantityChanged(quantity + 1);
                              },
                              child:
                             const Icon(Icons.add),

                              ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
