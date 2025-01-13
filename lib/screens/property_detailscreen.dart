import 'package:flutter/material.dart';
import 'package:prop_olx/model/properties_list_response.dart';
import 'package:prop_olx/src/text_style.dart';
import 'package:prop_olx/utils/image.dart';
import 'package:prop_olx/utils/util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';


class PropertyDetailScreen extends StatefulWidget {
  final PropertyList property;

  const PropertyDetailScreen({super.key, required this.property});

  @override
  PropertyDetailScreenState createState() => PropertyDetailScreenState();
}

class PropertyDetailScreenState extends State<PropertyDetailScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Build image slider with indicator
  Widget _buildImageSlider(List<String> imageUrls) {
    return Column(
      children: [
        SizedBox(
          height: 300, // Height of the image slider
          child: PageView.builder(
            controller: _pageController,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: MyUtil.showNetworkImageWithLoadingError(
                  imageUrls[index],
                  double.infinity,
                  double.infinity,
                  AppImages.agreement,
                  BoxFit.cover,
                ),
              );
            },
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        const SizedBox(height: 10),
        SmoothPageIndicator(
           controller: _pageController,
          count: imageUrls.length,
          effect: const WormEffect(
            dotHeight: 7,
            dotWidth: 7,
            type: WormType.thinUnderground,
          ),
        ),
      ],
    );
  }

  // Build property details
  Widget _buildPropertyDetails() {
    final property = widget.property;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            property.stateId!.toString(),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Budget: ${property.budget}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Location: ${property.address}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            'Contact: ${property.contactDetails}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 8),
          // Add more details here if needed
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final property = widget.property;
    final List<String> imageUrls = property.photos ?? [];

    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop(true);
            },
            child: const Icon(Icons.arrow_back,color: Colors.white,)),
        title:   Text('Property Details',style: MyTxtStyle.tittleStyle,),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13,vertical: 15),
          child: Column(
            children: <Widget>[
              _buildImageSlider(imageUrls),
              const SizedBox(height: 20),
              _buildPropertyDetails(),
            ],
          ),
        ),
      ),
    );
  }
}
