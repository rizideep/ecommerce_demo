import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prop_olx/base/app_events.dart';
import 'package:prop_olx/screens/add_propertie.dart';
import 'package:prop_olx/screens/property_detailscreen.dart';
import 'package:prop_olx/utils/image.dart';
import 'package:prop_olx/utils/util.dart';

import '../base/app_bloc.dart';
import '../base/app_callbacks.dart';
import '../base/app_states.dart';
import '../custom_widget/custom_loading.dart';
import '../custom_widget/error_screen.dart';
import '../custom_widget/no_internet_screen.dart';
import '../model/properties_list_response.dart';
import '../src/text_style.dart';
import '../utils/app_constant.dart';
import '../utils/getx_storage.dart';
import '../utils/preferences_constant.dart';



class PropertyListScreen extends StatefulWidget {
  const PropertyListScreen({super.key});

  @override
  PropertyListScreenState createState() => PropertyListScreenState();
}

class PropertyListScreenState extends State<PropertyListScreen>
    implements AppErrorCallback, AppNetworkCallback {
  late AppBloc appBloc;
  final List<String> categories = [
    'All',
    'Residential',
    'Commercial',
    'Agriculture'
  ];
  final List<String> locations = ['All', 'City', 'Tehsil'];
  String selectedCategory = 'All';
  String selectedLocation = 'All';

  List<PropertyList> properties = [];

  // Filter properties based on the selected category and location
  List<PropertyList> get filteredProperties {
    return properties.where((property) {
      final matchesCategory =
          selectedCategory == 'All' || property.categoryId == selectedCategory;
      final matchesLocation =
          selectedLocation == 'All' || property.address == selectedLocation;
      return matchesCategory && matchesLocation;
    }).toList();
  }

  var box = GetStorageUtil();
  int? userId;



  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    userId = box.read(PreferencesConstant.userId);
    MyUtil.printW("user id $userId");
    getPropertiesById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Property Listings',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: _showFilterSheet,
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: _logout,
          ),
        ],
      ),
      body: BlocConsumer<AppBloc, AppStates>(
        bloc: appBloc,
        listener: (context, state) async {},
        builder: (BuildContext context, AppStates state) {
          return getPageState(state);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPropertiesListScreen,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Future<void> refreshProperties() async {
      getPropertiesById();
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
      if (appStates is SuccessState &&
          appStates.appEvent is GetAllPropertiesEvent) {
        PropertiesListResponse propertiesListResponse =
        PropertiesListResponse.fromJson(appStates.serverResponse.data);
        properties = propertiesListResponse.propertyList!;
      }
      return getMainView();
    } else if (appStates is LoadingState) {
      return const Center(child: CustomLoading());
    }
  }

  getMainView() {
    return RefreshIndicator(
      onRefresh: refreshProperties,
      child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.deepPurpleAccent.withOpacity(0.9),
                Colors.blueAccent.withOpacity(0.9),
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: getWidget(properties),
          )),
    );
  }

  getWidget(List<PropertyList> properties) {
    if (properties.isNotEmpty) {
      return GridView.builder(
        itemCount: filteredProperties.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1 / 1.4,
        ),
        itemBuilder: (context, index) {
          final property = filteredProperties[index];
          return Hero(
            tag: property.id!,
            child: _buildPropertyCard(context, property),
          );
        },
      );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            SizedBox(
              height: 15,
            ),
            Text(
              AppConstant.dataNotFound,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontFamily: AppConstant.appFontInter,
                  color: Colors.white,
                  fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Please add properties",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  fontFamily: AppConstant.appFontInter,
                  fontSize: 13),
            ),
          ],
        ),
      );
    }
  }

  void _showFilterSheet() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Filter by Category and Location',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Category'),
                      DropdownButton<String>(
                        value: selectedCategory,
                        items: categories.map((String category) {
                          return DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Location'),
                      DropdownButton<String>(
                        value: selectedLocation,
                        items: locations.map((String location) {
                          return DropdownMenuItem<String>(
                            value: location,
                            child: Text(location),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedLocation = value!;
                          });
                        },
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.deepPurple),
                            foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Apply'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((onValue) {
      if (onValue) {
        setState(() {});
      }
    });
  }

  void _logout() {
    // Clear user session data here
    box.eraseAll( );
    // Navigate back to the login screen
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }
  Widget _buildPropertyCard(BuildContext context, PropertyList property) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(15.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PropertyDetailScreen(property: property),
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(

                alignment: Alignment.center,
                child: ClipRRect(
                    borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(15),topRight: Radius.circular(15)),
                    child: MyUtil.showNetworkImageWithLoadingError(
                        property.photos![0],
                        120,
                        400,
                        AppImages.agreement,
                        BoxFit.fitWidth)),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPropertyInfo(
                        Icons.landscape, property.stateId!.toString()),
                    _buildPropertyInfo(Icons.money, property.budget!),
                    _buildPropertyInfo(Icons.location_on, property.address!),
                    _buildPropertyInfo(Icons.phone, property.contactDetails!),
                  ],
                ),
              ),
              const SizedBox(height: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPropertyInfo(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Row(
        children: <Widget>[
          Icon(icon, color: Colors.deepPurple, size: 15),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }


  addPropertiesListScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPropertyScreen()),
    ).then((onValue) {
      if (onValue) {
        getPropertiesById();
      }
    });
  }

  void getPropertiesById() {
    appBloc.add(GetAllPropertiesEvent(userId!.toString()));
  }

  @override
  onErrorCall() {
    getPropertiesById();
  }

  @override
  onRetry() {
    getPropertiesById();
  }
}
