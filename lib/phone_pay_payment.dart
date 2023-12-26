import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:phonepe_payment_sdk/phonepe_payment_sdk.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
class PhonePayPayment extends StatefulWidget {
  const PhonePayPayment({
    super.key,
  });

  @override
  State<PhonePayPayment> createState() => _PhonePayPaymentState();

}

class _PhonePayPaymentState extends State<PhonePayPayment> {

  //******** value of the init of flutter sdk
  String environment = "UAT_SIM";
  String appId = '';
  // this is old PGTESTPAYUAT ----------------------
  String merchantId = 'PGTESTPAYUAT143';
  String transactionId = DateTime.now().microsecondsSinceEpoch.toString();
  bool enableLogging = true;
  String checksum = '';
  //  099eb0cd-02cf-4e2a-8aca-3e6c6aff0399
  String saltKey = 'ab3ab177-b468-4791-8071-275c404d8ab0';
  String saltIndex = '1';
  // https://webhook.site/f63d1195-f001-474d-acaa-f7bc4f3b20b1   this fake
  String callBackUrl =
      'https://api-preprod.phonepe.com/apis/pg-sandbox';
  String callBack="https://store.annapurnamart.shop/api/login";
  String body = '';
  Object? result;
  String apiEndPoint = '/pg/v1/pay';

  getCheckSum() {
    final requestData = {
      "merchantId": merchantId,
      "merchantTransactionId": transactionId,
      "merchantUserId": "90223250",
      "amount": 1000,
      "mobileNumber": "9999999999",
      "callbackUrl": callBackUrl,
      "paymentInstrument": {
        "type": "PAY_PAGE",
      },
    };
    String base64Body = base64.encode(utf8.encode(jsonEncode(requestData)));
    checksum =
        '${sha256.convert(utf8.encode(base64Body + apiEndPoint + saltKey)).toString()}###$saltIndex';
    return base64Body;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    phonePayInit();
    body = getCheckSum().toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('this is your phone pay screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // startPgTransaction();
                Get.snackbar(
                  "title",
                  "content",
                );
              },
              child: Text('start tra..'),
            ),
            ElevatedButton(onPressed: (){
              print('shfshdfsdfs');
              Get.snackbar('title', 'message',backgroundColor: Colors.red);
            }, child: Text("sdhfsdhfsef")),
            SizedBox(
              height: 20,
            ),
            Text("resul $result")
          ],
        ),
      ),
    );
  }

  void phonePayInit() {
    PhonePePaymentSdk.init(environment, appId, merchantId, enableLogging)
        .then((val) => {
              setState(() {
                result = 'PhonePe SDK Initialized - $val';
              })
            })
        .catchError((error) {
      handleError(error);
      return <dynamic>{};
    });
  }

  void startPgTransaction() async {
    try {
      var response = PhonePePaymentSdk.startPGTransaction(
          body, callBackUrl, checksum, {}, apiEndPoint, ' ');
      response
          .then((val) async {
                  // print(val.toString() +"llllllllllllllllllllllllllllllllllllllllll");
                  if (val != null) {
                    String status = val['status'].toString();
                    String error = val['error'].toString();
                    if (status == 'SUCCESS') {

                     await checkStatus();
                      result = 'Flow Complete Status : SUCCESS!';
                    } else {
                      result =
                          'Flow Complete Status : $status and error is $error !';
                    }
                  } else {
                    result = 'Flow Incomplete sorry !';
                  }

              })
          .catchError((error) {
        handleError(error);
        return <dynamic>{};
      });
    } catch (error) {
      handleError(error);
    }
  }

  void handleError(error) {
    setState(() {
      result = {'error': error};
    });
  }

  checkStatus() async{
     try{
       String url ='https://api-preprod.phonepe.com/apis/pg-sandbox/pg/v1/status/$merchantId/$transactionId';
       String concatString = '/pg/v1/status/$merchantId/$transactionId$saltKey';
       var bytes = utf8.encode(concatString);
       var digest = sha256.convert(bytes).toString();
       var xVerify = "$digest###$saltIndex";

       Map<String , String> header = {
         'Content-Type': 'application/json',
         'X-VERIFY': xVerify,
         'X-MERCHANT-ID': merchantId
       };
       await http.get(Uri.parse(url),headers: header).then((value) {
         Map<String,dynamic> res = jsonDecode(value.body);
         print('shuendnnnnnnnnnnn  $res');
         try{
           if(res['code'] == 'PAYMENT_SUCCESS' && res['data']['responseCode'] == 'SUCCESS'){
             // Fluttertoast.showToast(msg: res['message']);
             // Fluttertoast.showToast(
             //
             //   msg: res['message'],
             //   toastLength: Toast.LENGTH_SHORT,
             //   gravity: ToastGravity.BOTTOM,
             //   timeInSecForIosWeb: 1,
             //   backgroundColor: Colors.green, // Background color
             //   textColor: Colors.white,      // Text color
             //   fontSize: 16.0,
             // );
             Get.snackbar(res['message'],'done');
           }else{
             Fluttertoast.showToast(msg: 'something went wrong !',backgroundColor: Colors.red);
           }
         }
         catch(e){
           Fluttertoast.showToast(msg: 'function error of the catch and try log',backgroundColor: Colors.red);
         }
       });
     }catch(e){
       Fluttertoast.showToast(msg: 'this is first and main error',backgroundColor: Colors.red);
     }
  }
}
