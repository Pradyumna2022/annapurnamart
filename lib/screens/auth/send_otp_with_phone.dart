//
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';
// import 'package:http/http.dart';
//
// import '../../configs/style_config.dart';
// import '../../configs/theme_config.dart';
// import '../../custom_ui/BoxDecorations.dart';
// import '../../custom_ui/Button.dart';
// import '../../helpers/common_functions.dart';
// import '../../helpers/device_info_helper.dart';
// import 'otp_verification.dart';
// class LoginWithPhoneNumber extends StatefulWidget {
//   @override
//   _LoginWithPhoneNumberState createState() => _LoginWithPhoneNumberState();
// }
//
// class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
//
//   TextEditingController phoneController = TextEditingController();
//
//   void login(String phone) async {
//     try{
//       var response =await post(Uri.parse('https://new.annapurnamart.shop/api/login'),body:{
//         'email': phone,
//         'type':  'newotp'
//       });
//       if(phone.isNotEmpty){
//         print('means your phone isNotEmpty'+phone);
//         var data = jsonDecode(response.body.toString());
//         print(data);
//         // Fluttertoast.showToast(msg: data['message']);
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>OtpVerification()));
//       }else{
//         print('error find this account email or password');
//       }
//     }catch(e){
//       print('this is first time error find in this code ');
//     }
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Login Screen"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // TextField(
//             //   keyboardType: TextInputType.phone,
//             //   controller: phoneController,
//             //   decoration: InputDecoration(
//             //     contentPadding: EdgeInsets.only(left: 30,top: 35),
//             //     labelText: "     Phone",
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(23),
//             //       borderSide: BorderSide(
//             //           color: Colors.yellow
//             //       ),
//             //     ),
//             //     enabledBorder:  OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(23),
//             //       borderSide: BorderSide(
//             //           color: Colors.deepOrange,width: 2
//             //       ),
//             //     ),
//             //     focusedBorder:  OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(23),
//             //       borderSide: BorderSide(
//             //           color: Colors.redAccent,width: 2
//             //       ),
//             //     ),
//             //   ),
//             // ),
//
//             Padding(
//               padding: const EdgeInsets.only(bottom: 8.0),
//               child: Container(
//                   decoration: BoxDecorations.basic(),
//                   height: 36,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 14.0),
//                             child: Icon(
//                               Icons.phone,
//                               size: 18,
//                               color: ThemeConfig.mediumGrey,
//                             ),
//                           ),
//                           Button(
//                             minWidth: 80,
//                             onPressed: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (context) {
//                                     return buildFilterDialog(data);
//                                   });
//                             },
//                             child: Row(
//                               children: [
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Image.asset(
//                                       "${getAssetFlag(data.regCountry.code.toLowerCase())}.png"),
//                                 ),
//                                 Text(
//                                   "${data.regCountry.dial_code}",
//                                   style: StyleConfig.fs14fwNormal,
//                                 )
//                               ],
//                             ),
//                           ),
//                           Container(
//                             padding: EdgeInsets.only(left: 10),
//                             width: getWidth(context) - 255,
//                             child: TextField(
//                               style: StyleConfig.fs14fwNormal,
//                               decoration: InputDecoration.collapsed(
//                                   hintText: "XXX XXX XXX"),
//                               controller: phoneController,
//                             ),
//                           )
//                         ],
//                       ),
//                     ],
//                   )),
//             ),
//
//
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed:(){
//                 login(phoneController.text.toString());
//               },
//               child: Text("Login"),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
// }
