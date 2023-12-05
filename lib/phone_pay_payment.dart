
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:grostore/screens/check_out.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';


class PhonePayPayment extends StatefulWidget {
  const PhonePayPayment({super.key, });

  @override
  State<PhonePayPayment> createState() => _PhonePayPaymentState();
}

class _PhonePayPaymentState extends State<PhonePayPayment> {



  // ******** value of the init of flutter sdk
  // String environment =  "UAT_SIM";
  //     String appId = '';
  // String merchantId = 'PGTESTPAYUAT';
  //     bool enableLogging = true;
  //     String checksum = '';
  //     String saltKey = '099eb0cd-02cf-4e2a-8aca-3e6c6aff0399';
  //     String saltIndex = '1';
  // // https://webhook.site/f63d1195-f001-474d-acaa-f7bc4f3b20b1   this fake
  //     String callBackUrl = 'https://webhook.site/f63d1195-f001-474d-acaa-f7bc4f3b20b1';
  //     String body = '';
  //     Object? result;
  //     String apiEndPoint = '/pg/v1/pay';
  //
  //
  //     getCheckSum(){
  //      final requestData = {
  //         "merchantId": merchantId,
  //       "merchantTransactionId": "transaction_123",
  //       "merchantUserId": "90223250",
  //       "amount": 1000,
  //       "mobileNumber": "9999999999",
  //       "callbackUrl": callBackUrl,
  //       "paymentInstrument": {"type": "PAY_PAGE",},
  //     };
  //      String base64Body = base64.encode(utf8.encode(jsonEncode(requestData)));
  //      checksum = '${sha256.convert(utf8.encode(base64Body+apiEndPoint+saltKey)).toString()}###$saltIndex';
  //      return base64Body;
  //
  //     }

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   phonePayInit();
  //   body = getCheckSum().toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'this is your phone pay screen'
        ),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){

                // startPgTransaction();
              },child: Text('start tra..'),
            ),
            SizedBox(height: 20,),
            Text("resul $result")
          ],
        ),
      ),
    );
  }

  // void phonePayInit() {
  //   PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
  //       .then((val) => {
  //     setState(() {
  //       result = 'PhonePe SDK Initialized - $val';
  //     })
  //   })
  //       .catchError((error) {
  //     handleError(error);
  //     return <dynamic>{};
  //   });
  // }
  //
  // void startPgTransaction()async{
  //   try {
  //     var response = PhonePePaymentSdk.startPGTransaction(
  //         body, callBackUrl, checksum, {}, apiEndPoint, ' ');
  //     response
  //         .then((val) => {
  //       setState(() {
  //
  //         if(val != null){
  //           String status = val['status'].toString();
  //           String error = val['error'].toString();
  //           if(status == 'SUCCESS'){
  //             result = 'Flow Complete Status : SUCCESS!';
  //           }else{
  //             result = 'Flow Complete Status : $status and error is $error !';
  //           }
  //         }else{
  //           result = 'Flow Incomplete sorry !';
  //         }
  //
  //       })
  //     })
  //         .catchError((error) {
  //       handleError(error);
  //       return <dynamic>{};
  //     });
  //   } catch (error) {
  //     handleError(error);
  //   }
  // }
  //
  // void handleError(error) {
  //    setState(() {
  //      result = {'error': error};
  //    });
  // }
}
