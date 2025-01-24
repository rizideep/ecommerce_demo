import 'package:flutter/material.dart';
import 'package:prop_olx/screens/account/address_list.dart';
import 'package:prop_olx/screens/account/orders.dart';
import 'package:prop_olx/screens/account/payment.dart';
import 'package:prop_olx/screens/account/profile.dart';

import '../notification.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {
              getNotificationScreen();
            },
            icon: const Icon(
              Icons.notifications_none,
              color: Colors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person_outline, color: Colors.blue),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                getProfileScreenScreen();

              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading:
                  const Icon(Icons.shopping_bag_outlined, color: Colors.blue),
              title: const Text(
                'Order',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                getOrderListScreen();
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading:
                  const Icon(Icons.location_on_outlined, color: Colors.blue),
              title: const Text(
                'Address',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                getAddressListScreen();
              },
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.payment_outlined, color: Colors.blue),
              title: const Text(
                'Payment',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              onTap: () {
                getPaymentScreen();
              },
            ),
          ],
        ),
      ),
    );
  }


  getProfileScreenScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ProfileScreen()),
    );
  }

  getAddressListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddressListScreen()),
    );
  }

  getPaymentScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PaymentScreen()),
    );
  }
  getOrderListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OrderListScreen()),
    );
  }

  getNotificationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NotificationScreen()),
    );
  }
}
