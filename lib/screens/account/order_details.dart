import 'package:flutter/material.dart';

import '../../utils/image.dart';

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Order Summary
            const Text('Order Summary', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order ID:'),
                Text('SDG1345KJD'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order Date:'),
                Text('August 1, 2021'),
              ],
            ),
            const SizedBox(height: 20),
            // Product Details
            const Text('Product', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ListTile(
              leading: Image.asset(
                AppImages.ghar,

                width: 50,
                height: 50,
              ),
              title: const Text('Nike Air Zoom Pegasus'),
              subtitle: const Text('Size: 36, Color: Miami'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Image.asset(
                AppImages.gh,

                width: 50,
                height: 50,
              ),
              title: const Text('Nike Air Zoom Pegasus'),
              subtitle: const Text('Size: 36, Color: Miami'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.favorite_border),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.shopping_cart),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Shipping Details
            const Text('Shipping Details', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Method:'),
                Text('Duse Shipping'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping Address:'),
                Text('2721 New Owen Owenl, \nIme State 78410'),
              ],
            ),
            const SizedBox(height: 20),
            // Payment Details
            const Text('Payment Details', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Subtotal:'),
                Text('\$299.43'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Shipping:'),
                Text('\$40.00'),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tax:'),
                Text('\$128.00'),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Price:'),
                Text('\$128.00'),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement notify me functionality
              },
              child: const Text('Notify Me'),
            ),
          ],
        ),
      ),
    );
  }
}