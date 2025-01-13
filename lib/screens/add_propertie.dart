import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prop_olx/base/app_events.dart';
import 'package:prop_olx/src/text_style.dart';
import 'package:prop_olx/utils/getx_storage.dart';
import 'package:prop_olx/utils/preferences_constant.dart';
import 'package:prop_olx/utils/util.dart';

import '../base/app_bloc.dart';
import '../base/app_callbacks.dart';
import '../base/app_states.dart';
import '../custom_widget/custom_loading.dart';
import '../custom_widget/error_screen.dart';
import '../custom_widget/no_internet_screen.dart';

class AddPropertyScreen extends StatefulWidget {
  AddPropertyScreen({super.key});

  @override
  AddPropertyScreenState createState() => AddPropertyScreenState();
}

class AddPropertyScreenState extends State<AddPropertyScreen>
    implements AppErrorCallback, AppNetworkCallback {
  late AppBloc appBloc;
  final _formKey = GlobalKey<FormState>();
  List<String?> _images = [null, null, null]; // Placeholder for 3 images
  final ImagePicker _picker = ImagePicker();
  var box = GetStorageUtil();
  int? userId;

  // Controllers for TextFields
  final TextEditingController _proNameController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  // Pick a single image and assign it to the corresponding ImageView
  Future<void> _pickImage(int index) async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _images[index] = pickedImage.path;
      });
    }
  }

  // Dropdown variables
  String? _selectedPropertyType;
  String? _selectedState;
  String? _selectedCity;

  // Property options
  final List<String> _propertyTypes = [
    "Residential",
    "Commercial",
    "Agricultural"
  ];
  final List<String> _states = ["State1", "State2", "State3", "State4"]; //
  // Replace with actual states
  List<String> _cities = []; // Cities based on selected state

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    userId = box.read(PreferencesConstant.userId);
    MyUtil.printW("user id $userId");

  }

  // Fetch cities when a state is selected
  void _onStateChanged(String? state) {
    setState(() {
      _selectedState = state;
      _cities = fetchCities(state); // Mock API call to populate cities
      _selectedCity = null;
    });
  }

  // Update createProperties to include propertyType, state, and city
  void createProperties() {
    if (_images.length < 4) {
      appBloc.add(CreatePropertiesEvent(
          _proNameController.text.toString().trim(),
          1.toString().trim(),
          1.toString().trim(),
          1.toString().trim(),
          _addressController.text.toString().trim(),
          _budgetController.text.toString().trim(),
          _contactController.text.toString().trim() ,
          _images,
          userId .toString().trim()));
    } else {
      MyUtil.showToast("Add at least 3 images");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop(true);
            },
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
        title:   Text(
          'Add Property Listing',
          style: MyTxtStyle.tittleStyle,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocConsumer<AppBloc, AppStates>(
        bloc: appBloc,
        listener: (context, state) async {
          if (state is SuccessState && state.appEvent is
          CreatePropertiesEvent) {
            MyUtil.showToast(state.serverResponse.message!);
            Navigator.of(context).pop(true);
          }

        },
        builder: (BuildContext context, AppStates state) {
          return getPageState(state);
        },
      ),
    );
  }

  // Helper function for consistent TextFields styling with icons
  Widget _buildTextField(
    TextEditingController controller,
    String labelText, {
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: const TextStyle(
            color: Colors.deepPurple,
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.deepPurple,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $labelText';
          }
          return null;
        },
      ),
    );
  }

  getPageState(AppStates appStates) {
    if (appStates is NeutralState) {
      return getMainView();
    } else if (appStates is NetworkErrorState) {
      return NoInternetScreen(this);
    } else if (appStates is ErrorState) {
      return ErrorScreen(
        this,
        appStates.appError.errorMessage,
        appStates.appError.statusCode,
      );
    } else if (appStates is SuccessState) {
      return getMainView();
    } else if (appStates is LoadingState) {
      return const Center(child: CustomLoading());
    }
  }

  getMainView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Image picker section
              const Text(
                "Property Photos (Up to 3)",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              _buildImageView(index),
                              const SizedBox(height: 5),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.deepPurpleAccent,
                                ),
                                onPressed: () => _pickImage(index),
                                child: Text("Image ${index + 1}"),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal),
              ),
              const SizedBox(height: 20),
              // Property Type Dropdown
              DropdownButtonFormField<String>(
                value: _selectedPropertyType,
                items: _propertyTypes
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _selectedPropertyType = value),
                decoration:   InputDecoration(
                    labelText: "Property Type", border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
                validator: (value) =>
                    value == null ? 'Please select a property type' : null,
              ),
              const SizedBox(height: 20),
              // State Dropdown
              DropdownButtonFormField<String>(
                value: _selectedState,
                items: _states
                    .map((state) =>
                        DropdownMenuItem(value: state, child: Text(state)))
                    .toList(),
                onChanged: _onStateChanged,
                decoration:   InputDecoration(
                    labelText: "State", border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
                validator: (value) =>
                    value == null ? 'Please select a state' : null,
              ),
              const SizedBox(height: 20),
              // City Dropdown
              DropdownButtonFormField<String>(
                value: _selectedCity,
                items: _cities
                    .map((city) =>
                        DropdownMenuItem(value: city, child: Text(city)))
                    .toList(),
                onChanged: (value) => setState(() => _selectedCity = value),
                decoration:   InputDecoration(
                    labelText: "City", border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                )),
                validator: (value) =>
                    value == null ? 'Please select a city' : null,
              ),
              const SizedBox(height: 20),
              // Area TextField with Icon
              _buildTextField(
                _proNameController,
                "Name of Property",
                icon: Icons.landscape,
              ),

              _buildTextField(
                _areaController,
                "Area of Property",
                icon: Icons.landscape,
              ),


              // Budget TextField with Icon
              _buildTextField(
                _budgetController,
                "Budget",
                icon: Icons.money,
                keyboardType: TextInputType.number,
              ),

              // Address TextField with Icon
              _buildTextField(
                _addressController,
                "Address",
                icon: Icons.location_on,
              ),

              // Contact TextField with Icon
              _buildTextField(
                _contactController,
                "Contact Details",
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),

              const SizedBox(height: 30),

              // Submit Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createProperties();
                    }
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build image view for each selected image
  Widget _buildImageView(int index) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        child: _images[index] != null
            ? Image.file(
                File(_images[index]!),
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image, color: Colors.grey),
      ),
    );
  }

  List<String> fetchCities(String? state) {
    // Simulate a list of cities based on the selected state
    switch (state) {
      case "State1":
        return ["City1", "City2", "City3"];
      case "State2":
        return ["City4", "City5", "City6"];
      case "State3":
        return ["City7", "City8", "City9", "City10"];
      case "State4":
        return ["City11", "City12", "City13"];
      case "State5":
        return ["City14", "City15", "City16", "City17"];
      // Add more states and corresponding cities as needed
      default:
        return [];
    }
  }

  @override
  onErrorCall() {
    createProperties();
  }

  @override
  onRetry() {
    createProperties();
  }
}
