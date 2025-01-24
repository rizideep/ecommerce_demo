import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  String _oldPassword = '';
  String _newPassword = '';
  String _newPasswordAgain = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Old Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your old password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your old password';
                  }
                  return null;
                },
                onSaved: (value) => _oldPassword = value!,
              ),
              const SizedBox(height: 20),
              const Text(
                'New Password',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Enter your new password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your new password';
                  }
                  return null;
                },
                onSaved: (value) => _newPassword = value!,
              ),
              const SizedBox(height: 20),
              const Text(
                'New Password Again',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Re-enter your new password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm your new password';
                  }
                  if (value != _newPassword) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // TODO: Handle password change logic here
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}