import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/auth_ui.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/auth/auth_presenter.dart';
import 'package:grostore/screens/auth/password_forget.dart';
import 'package:grostore/screens/auth/registration.dart';
import 'package:http/http.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import '../../constant/country_code.dart';
import '../../custom_ui/BoxDecorations.dart';
import '../../helpers/common_functions.dart';
import '../home.dart';
import '../main.dart';
import '../profile.dart';

class OtpVerification extends StatefulWidget {
  final mobileNumber;

  const OtpVerification({super.key, required this.mobileNumber});

  @override
  _OtpVerificationState createState() => _OtpVerificationState();
}

class _OtpVerificationState extends State<OtpVerification> {

  final FocusNode _pinPutFocusNode = FocusNode();
  TextEditingController otpController = TextEditingController();
  void verificationMethod(String otp) async {
    try{
      var response =await post(Uri.parse('https://new.annapurnamart.shop/api/login'),body:{
        'email': widget.mobileNumber.toString(),
        'type':  'verifyotpcustomer',
        'password':otp
      });
      if(otp.isNotEmpty){
        print( widget.mobileNumber.toString()+' this  is your phone number from your phone');
        var data = jsonDecode(response.body.toString());
        print(data);
        // Fluttertoast.showToast(msg: data['message']);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Main()));
      }else{
        print('error find this account email or password');
      }
    }catch(e){
      print('this is first time error find in this code ');
    }
  }

  bool showPassword = false;
  @override

  Widget build(BuildContext context) {
    Provider.of<AuthPresenter>(context, listen: false).setContext(context);
    return AuthScreen.buildScreen(
        context, buildBody(context, getWidth(context))
    );
  }

  Widget buildBody(BuildContext context, double screenWidth) {
    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green.withOpacity(0.7)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color:ThemeConfig.green),
      borderRadius: BorderRadius.circular(15),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.green,borderRadius: BorderRadius.circular(15),
      ),
    );
    return Consumer<AuthPresenter>(builder: (context, data, child) {
      return Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: StyleConfig.padding),
        width: screenWidth * (3 / 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: getWidth(context),
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                'Otp Verification',
                style: StyleConfig.fs24fwBold,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 30,),
            Text(widget.mobileNumber.toString()),
            // Pinput(
            //   controller: otpController,
            //   length: 6,
            //   defaultPinTheme: defaultPinTheme,
            //   focusedPinTheme: focusedPinTheme,
            //   submittedPinTheme: submittedPinTheme,
            //   validator: (s) {
            //
            //   },
            //   pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
            //   showCursor: true,
            //   onCompleted: (pin) => print(pin),
            // ),
            Pinput(
              controller: otpController,
              validator: (value) {
                if (value!.isEmpty && value.length != 6) {
                  return "Please enter your 6 digit pin";
                } else {
                  return null;
                }
              },
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              length: 6,
              autofocus: false,
              useNativeKeyboard: true,
              keyboardType: TextInputType.number,
              defaultPinTheme: defaultPinTheme,
              onSubmitted: (String pin) => _showSnackBar(pin, context),
              focusNode: _pinPutFocusNode,
              submittedPinTheme: PinTheme(
                  height: 56,
                  width: 56,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40.0),
                      border: Border.all(color: Color(0xffFE0091)),
                      color: Color(0xffFe0091))),
              focusedPinTheme: defaultPinTheme,
              followingPinTheme: defaultPinTheme,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                height: 45,
                child: Button.minSize(
                    width: getWidth(context),
                    height: 50,
                    color: ThemeConfig.accentColor,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(6.0))),
                    child: Text(
                      'Verify OTP',
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      verificationMethod(otpController.text.toString());
                      // print('sdhfhsdfsdf');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) =>  Main()),
                      // );
                    }),
              ),
            ),

          ],
        ),
      );
    });
  }
  AlertDialog buildFilterDialog(AuthPresenter data) {
    return AlertDialog(
      title: const Text('Search Country'),
      content: Container(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              onChanged: data.filterCountry,
              decoration: InputDecoration(
                hintText: 'Search',
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: SingleChildScrollView(
                child: Consumer<AuthPresenter>(
                    builder: (context, filterData, child) {
                      return Column(
                        children: List.generate(filterData.filteredCountry.length,
                                (index) {
                              final country = filterData.filteredCountry[index];
                              return ListTile(
                                leading: Image.asset(
                                  getAssetFlag("${country.code.toLowerCase()}.png"),
                                  height: 30,
                                  width: 30,
                                ),
                                title: Text(country.name),
                                onTap: () {
                                  data.onChangeCountry(country);
                                  Navigator.of(context).pop();
                                  filterData.filteredCountry = filterData.country;
                                },
                              );
                            }),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void _showSnackBar(String pin, BuildContext context) {
    final snackBar = SnackBar(
      content: Container(
        height: 80.0,
        child: Center(
          child: Text(
            'Pin Submitted. Value: $pin',
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
      ),
      backgroundColor: Theme.of(context).highlightColor,
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
