import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prop_olx/base/app_events.dart';
import 'package:prop_olx/model/otp_response.dart';
import 'package:prop_olx/screens/dash_board.dart';
import 'package:prop_olx/utils/util.dart';
import 'package:shimmer/shimmer.dart';

import '../base/app_bloc.dart';
import '../base/app_callbacks.dart';
import '../base/app_states.dart';
import '../custom_widget/custom_loading.dart';
import '../custom_widget/error_screen.dart';
import '../custom_widget/no_internet_screen.dart';
import '../utils/getx_storage.dart';
import '../utils/preferences_constant.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  OtpVerificationScreenState createState() => OtpVerificationScreenState();
}

class OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin
    implements AppErrorCallback, AppNetworkCallback {
  late AppBloc appBloc;
  final _formKey = GlobalKey<FormState>();
  String? userId, otp;
  final TextEditingController userIdController = TextEditingController();
  final TextEditingController _otpController1 = TextEditingController();
  final TextEditingController _otpController2 = TextEditingController();
  final TextEditingController _otpController3 = TextEditingController();
  final TextEditingController _otpController4 = TextEditingController();
  final box = GetStorageUtil();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    appBloc = AppBloc();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    int userIdPref = box.read(PreferencesConstant.userId);
    userId = userIdPref.toString();
    userIdController.text = userId!;
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _otpController1.dispose();
    _otpController2.dispose();
    _otpController3.dispose();
    _otpController4.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<AppBloc, AppStates>(
        bloc: appBloc,
        listener: (context, state) async {
          if (state is SuccessState && state.appEvent is VerifyOtpEvent) {
            MyUtil.showToast("OTP Verified Successfully");
            OtpResponse otpResponse =
                OtpResponse.fromJson(state.serverResponse.data);
            box.wrightBox(PreferencesConstant.accessToken, otpResponse.token);
            getPropertyListScreen();
          }
        },
        builder: (BuildContext context, AppStates state) {
          return getPageState(state);
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
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 1),
            curve: Curves.fastOutSlowIn,
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(100),
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Shimmer.fromColors(
                  baseColor: Colors.white,
                  highlightColor: Colors.purple[300]!,
                  child: const Text(
                    "OTP Verification",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: userIdController,
                    decoration: InputDecoration(
                      labelText: "User ID",
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.deepPurple,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    onSaved: (value) => userId = value,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildOtpField(_otpController1),
                      _buildOtpField(_otpController2),
                      _buildOtpField(_otpController3),
                      _buildOtpField(_otpController4),
                    ],
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        otp = _otpController1.text +
                            _otpController2.text +
                            _otpController3.text +
                            _otpController4.text;
                        performOtpVerification();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: Colors.deepPurple,
                    ),
                    child: const Text(
                      "Verify OTP",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOtpField(TextEditingController controller) {
    return SizedBox(
      width: 50,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        decoration: InputDecoration(
          counterText: "",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Enter OTP';
          }
          return null;
        },
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          } else {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }

  void performOtpVerification() {
    appBloc.add(VerifyOtpEvent(userId!, otp!));
  }

  getPropertyListScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) =>   DashBoard()),
    );
  }

  @override
  onErrorCall() {
    performOtpVerification();
  }

  @override
  onRetry() {
    performOtpVerification();
  }
}
