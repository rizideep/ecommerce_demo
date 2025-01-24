import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  String _country = '';
  String _firstName = '';
  String _lastName = '';
  String _streetAddress = '';
  String _streetAddress2 = '';
  String _city = '';
  String _state = '';
  String _zipCode = '';
  String _phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Address'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Country or Region',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your country/region';
                    }
                    return null;
                  },
                  onSaved: (value) => _country = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                  onSaved: (value) => _firstName = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onSaved: (value) => _lastName = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Street Address',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your street address';
                    }
                    return null;
                  },
                  onSaved: (value) => _streetAddress = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Street Address 2 (Optional)',
                  ),
                  onSaved: (value) => _streetAddress2 = value ?? '',
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'City',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your city';
                    }
                    return null;
                  },
                  onSaved: (value) => _city = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'State/Province/Region',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your state/province/region';
                    }
                    return null;
                  },
                  onSaved: (value) => _state = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Zip Code',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your zip code';
                    }
                    return null;
                  },
                  onSaved: (value) => _zipCode = value!,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone Number';
                    }
                    return null;
                  },
                  onSaved: (value) => _phoneNumber = value!,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Implement notify me functionality
                  },
                  child: const Text('Add Address'),
                ),
              ],
            ),
          ),
        ));
  }
}
