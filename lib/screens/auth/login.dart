import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:grostore/app_lang.dart';
import 'package:grostore/configs/style_config.dart';
import 'package:grostore/configs/theme_config.dart';
import 'package:grostore/constant/country_code.dart';
import 'package:grostore/custom_ui/Button.dart';
import 'package:grostore/custom_ui/auth_ui.dart';
import 'package:grostore/custom_ui/input_decorations.dart';
import 'package:grostore/helpers/device_info_helper.dart';
import 'package:grostore/helpers/route.dart';
import 'package:grostore/presenters/auth/auth_presenter.dart';
import 'package:grostore/screens/auth/password_forget.dart';
import 'package:grostore/screens/auth/registration.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import '../../custom_ui/BoxDecorations.dart';
import '../../helpers/common_functions.dart';
import '../../helpers/shared_value_helper.dart';
import '../profile.dart';
import 'otp_verification.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //**************  function of the otp via phone number *********
  TextEditingController regPhoneNumberController = TextEditingController();
  void login(String phone) async {
    try{
      var response =await post(Uri.parse('https://new.annapurnamart.shop/api/login'),body:{
        'email': phone.toString(),
        'type':  'newotp'
      });
      if(phone.toString().isNotEmpty){

        print(phone.toString()+'this is phone ');
        print('means your phone isNotEmpty'+phone.toString());
        var data = jsonDecode(response.body.toString());
        print(data);

        // Fluttertoast.showToast(msg: data['message']);
        Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification(mobileNumber: phone.toString(),)));
      }else{

        print('error find this account email or password');
      }
    }catch(e){
      print('this is first time error find in this code ');
    }
  }

  // *********** end the function of the otp via phone number ***************
  bool visible = true;
  bool showPassword = false;
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthPresenter>(context, listen: false).setContext(context);
    return AuthScreen.buildScreen(
        context, buildBody(context, getWidth(context)));
  }

  Widget buildBody(BuildContext context, double screenWidth) {
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
                AppLang.local(context).welcome_to_back,
                style: StyleConfig.fs24fwBold,
                textAlign: TextAlign.center,
              ),
            ),

            //********************* This is your email field **********************

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 4.0),
            //   child: Text(
            //     AppLang.local(context).email,
            //     style: TextStyle(
            //         color: ThemeConfig.fontColor, fontWeight: FontWeight.w600),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 8.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       Container(
            //         height: 36,
            //         child: TextField(
            //           controller: data.loginEmailController,
            //           autofocus: false,
            //           decoration: InputDecorations.basic(
            //               prefixIcon: Icon(
            //                 Icons.email_outlined,
            //                 size: 18,
            //                 color: ThemeConfig.mediumGrey,
            //               ),
            //               hint_text: "user@example.com"),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),

            //********************* This is your email field **********************
            
            // TextButton(onPressed: (){
            //   Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification(mobileNumber: '917786920413',)));
            // }, child: Text("otp")),
            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                AppLang.local(context).phone,
                style: TextStyle(
                    color: ThemeConfig.fontColor, fontWeight: FontWeight.w600),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                  decoration: BoxDecorations.basic(),
                  height: 36,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 14.0),
                            child: Icon(
                              Icons.phone,
                              size: 18,
                              color: ThemeConfig.mediumGrey,
                            ),
                          ),
                          Button(
                            minWidth: 80,
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return buildFilterDialog(data);
                                  });
                            },
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset(
                                      "${getAssetFlag(data.regCountry.code.toLowerCase())}.png"),
                                ),
                                Text(
                                  "${data.regCountry.dial_code}",
                                  style: StyleConfig.fs14fwNormal,
                                )
                              ],
                            ),
                          ),

                          Container(
                            padding: EdgeInsets.only(left: 10),
                            width: getWidth(context) - 255,
                            child: TextField(
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(10),
                              ],
                              keyboardType: TextInputType.phone,
                              style: StyleConfig.fs14fwNormal,
                              decoration: InputDecoration.collapsed(
                                  hintText: "XXX XXX XXX"),
                              controller: data.regPhoneNumberController,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            ),

            // ********************* This is your password field **********************

            //  ..............................  password 88888888888888888888888888888888888888

            // Padding(
            //   padding: const EdgeInsets.only(bottom: 4.0),
            //   child: Text(
            //     AppLang.local(context).password,
            //     style: TextStyle(
            //         color: ThemeConfig.fontColor, fontWeight: FontWeight.w600),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 8.0),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       Container(
            //         height: 36,
            //         child: TextField(
            //           controller: data.loginPasswordController,
            //           autofocus: false,
            //           obscureText: !showPassword,
            //           enableSuggestions: false,
            //           autocorrect: false,
            //           decoration:
            //           InputDecorations.basic(hint_text: "Password • • • • • • • •")
            //               .copyWith(
            //
            //             focusedBorder: OutlineInputBorder(
            //               borderSide: BorderSide(color: ThemeConfig.accentColor),
            //             ),
            //             suffixIcon: InkWell(
            //               onTap: () {
            //                 setState(() {
            //                   showPassword =!showPassword;
            //                 });
            //               },
            //               child: Icon(
            //                 showPassword
            //                     ? Icons.visibility_outlined
            //                     : Icons.visibility_off_outlined,
            //                 color: ThemeConfig.accentColor,
            //               ),
            //             ),
            //           ),
            //           // decoration: InputDecorations.basic(
            //           //     prefixIcon: Icon(
            //           //       Icons.lock,
            //           //       size: 18,
            //           //       color: ThemeConfig.mediumGrey,
            //           //     ),
            //           //     hint_text: "• • • • • • • •"),
            //         ),
            //       ),
            //       Button(
            //         minWidth: 50,
            //         padding: EdgeInsets.zero,
            //         child: Text(
            //           AppLang.local(context).forgot_password_q_ucf,
            //           style: TextStyle(
            //               color: ThemeConfig.blue,
            //               fontStyle: FontStyle.italic),
            //
            //         ),
            //         onPressed: (){
            //           MakeRoute.go(context, PasswordForget());
            //         },
            //       )
            //     ],
            //   ),
            // ),
            //
            // //******************** For the login **************************
            //
            // Padding(
            //   padding: const EdgeInsets.only(top: 30.0),
            //   child: Container(
            //     height: 45,
            //     child: Button.minSize(
            //         width: getWidth(context),
            //         height: 50,
            //         color: ThemeConfig.accentColor,
            //         shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(6.0))),
            //         child: Text(
            //           AppLang.local(context).login,
            //           style: const TextStyle(
            //               color: Colors.white,
            //               fontSize: 14,
            //               fontWeight: FontWeight.w600),
            //         ),
            //         onPressed: () {
            //           data.onPressedLogin();
            //           // Navigator.push(
            //           //   context,
            //           //   MaterialPageRoute(builder: (context) =>  PasswordForget()),
            //           // );
            //         }),
            //   ),
            // ),

            //****************   verify with mobile number *************

            Visibility(
              visible: visible,
              child: Container(
                // margin: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          AppLang.local(context).password,
                          style: TextStyle(
                              color: ThemeConfig.fontColor,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 36,
                              child: TextField(
                                controller: data.loginPasswordController,
                                autofocus: false,
                                obscureText: !showPassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecorations.basic(
                                    hint_text: "Password • • • • • • • •")
                                    .copyWith(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: ThemeConfig.accentColor),
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showPassword = !showPassword;
                                      });
                                    },
                                    child: Icon(
                                      showPassword
                                          ? Icons.visibility_outlined
                                          : Icons.visibility_off_outlined,
                                      color: ThemeConfig.accentColor,
                                    ),
                                  ),
                                ),
                                // decoration: InputDecorations.basic(
                                //     prefixIcon: Icon(
                                //       Icons.lock,
                                //       size: 18,
                                //       color: ThemeConfig.mediumGrey,
                                //     ),
                                //     hint_text: "• • • • • • • •"),
                              ),
                            ),
                            Button(
                              minWidth: 50,
                              padding: EdgeInsets.zero,
                              child: Text(
                                AppLang.local(context).forgot_password_q_ucf,
                                style: TextStyle(
                                    color: ThemeConfig.blue,
                                    fontStyle: FontStyle.italic),
                              ),
                              onPressed: () {
                                MakeRoute.go(context, PasswordForget());
                              },
                            )
                          ],
                        ),
                      ),

                      //******************** For the login **************************

                      Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Container(
                          height: 45,
                          child: Button.minSize(
                              width: getWidth(context),
                              height: 50,
                              color: ThemeConfig.accentColor,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(6.0))),
                              child: Text(
                                AppLang.local(context).login,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              onPressed: () {
                                data.onPressedLogin();
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) =>  PasswordForget()),
                                // );
                              }),
                        ),
                      ),
                    ],
                  )),
            ),

            Visibility(
              visible: !visible,
              child: Padding(
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
                        'Send OTP',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      onPressed: () {
                        Country regCountry = CountryCode().get().first;
                        String regPhone = data.regPhoneNumberController.text.toString();
                        if (regPhone.isNotEmpty) {
                          if(regPhone.length<9){
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  title: Text('Your phone number is not valid',style: TextStyle(
                                      fontSize: 17,color: Colors.red,fontWeight: FontWeight.bold
                                  ),),
                                  content: Text('Please try again',style: TextStyle(
                                      fontSize: 12,color: Colors.green,fontWeight: FontWeight.bold
                                  ),),
                                )
                            );
                          }else{
                            var allPhoneNumber = regCountry.dial_code +regPhone;
                            login(allPhoneNumber.toString());
                          }
                        }else{
                          showDialog(
                              context: context,
                              builder: (_) => AlertDialog(
                                title: Text('Your phone number is Empty',style: TextStyle(
                                    fontSize: 17,color: Colors.red,fontWeight: FontWeight.bold
                                ),),
                                content: Text('Please Enter Your Phone',style: TextStyle(
                                    fontSize: 12,color: Colors.green,fontWeight: FontWeight.bold
                                ),),
                              )
                          );
                        }
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => OtpVerification()
                        //   ),
                        // );
                      }),
                ),
              ),

            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already Registered',
                        style:
                        TextStyle(color: ThemeConfig.fontColor, fontSize: 12),
                      ),

                      SizedBox(width: 15,),
                      GestureDetector(
                          onTap: (){
                            setState(() {
                              // Toggle the visibility of the TextField
                              visible = !visible;
                            });
                          },
                          child: Text("Login", style: TextStyle(
                              color: ThemeConfig.accentColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),))
                    ],
                  )),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    AppLang.local(context).not_a_member,
                    style:
                        TextStyle(color: ThemeConfig.fontColor, fontSize: 12),
                  )),
                  const SizedBox(
                    width: 10,
                  ),
                  Button(
                    minWidth: 20,
                    child: Text(
                      AppLang.local(context).register_now_ucf,
                      style: TextStyle(
                          color: ThemeConfig.accentColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Registration();
                      }));
                    },
                  ),
                ],
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
                child:
                Consumer<AuthPresenter>(
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
                          print(country.dial_code);
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
}


