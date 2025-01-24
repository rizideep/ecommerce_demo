import 'package:flutter/material.dart';

import 'add_address.dart';

class AddressListScreen extends StatelessWidget {
  const AddressListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Address Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prisceklia',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text('2721 New Owen Owenl, Ime State 78410'),
                    Text('Nevado 53374, United States'),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {
                            // Implement edit functionality
                          },
                          child: Text('Edit'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Implement delete functionality
                          },
                          child: Text('Delete'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Add Address Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAddressScreen()),
                  );
                },
                child: Text('Add Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}