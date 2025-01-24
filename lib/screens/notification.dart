import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'The Best Title',
      'description':
      'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',
      'date': 'April 30, 2014 1:01 PM',
    },
    {
      'title': 'SUMMER OFFER 98% Cashback',
      'description':
      'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',
      'date': 'April 30, 2014 1:01 PM',
    },
    {
      'title': 'Special Offer 25% OFF',
      'description':
      'Culpa cillum consectetur labore nulla nulla magna irure. Id veniam culpa officia aute dolor amet deserunt ex proident commodo',
      'date': 'April 30, 2014 1:01 PM',
    },
  ];

    NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Notification',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
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
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = notifications[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.local_offer_outlined,
                    color: Colors.blue,
                    size: 24,
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification['title']!,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          notification['description']!,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          notification['date']!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

