import 'package:flutter/material.dart';

import 'change_password.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150', // Replace with your image URL
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Dominic Ovo',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '@dominic_ovo',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 30),
              ProfileItem(
                icon: Icons.male,
                title: 'Gender',
                value: 'Male',
                onTap: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => GenderScreen()),
                // );
                },
              ),
              ProfileItem(
                icon: Icons.cake,
                title: 'Birthday',
                value: '12-12-2000',
                onTap: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => BirthdayScreen()),
                // );
                },
              ),
              ProfileItem(
                icon: Icons.email,
                title: 'Email',
                value: 'rex4dom@gmail.com',
                onTap: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => EmailScreen()),
                // );
                },
              ),
              ProfileItem(
                icon: Icons.phone,
                title: 'Phone Number',
                value: '(307) 555-0133',
                onTap: () {
                //   Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => PhoneNumberScreen()),
                // );
                },
              ),
              ProfileItem(
                icon: Icons.lock,
                title: 'Change Password',
                value: '************',
                onTap: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final VoidCallback onTap;

  const ProfileItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, color: Colors.blue),
          title: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            value,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          onTap: onTap,
        ),
        const Divider(),
      ],
    );
  }
}
