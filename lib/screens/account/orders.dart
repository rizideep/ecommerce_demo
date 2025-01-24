import 'package:flutter/material.dart';

import '../../src/app_colors.dart';
import 'order_details.dart';

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return buildOrderItem();
          },
        ),
      ),
    );
  }

  Widget buildOrderItem() {
    return InkWell(
      onTap: () {
        getOrderDetailsScreen();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          border: Border.all(color: gray400),
          borderRadius: BorderRadius.circular(16),

        ),
        child: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SDG1345KJD',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text('Order at: August 1, 2021'),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order Status'),
                  Text('Shipping'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Items'),
                  Text('1 items purchased'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Price'),
                  Text('\$238.43'),
                ],
              ),
              SizedBox(height: 20),
              // Add more order details here (e.g., shipping address, order items)
            ],
          ),
        ),
      ),
    );
  }

  getOrderDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderDetailsScreen()),
    );
  }
}
