import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';
import 'package:zibma_airpay/model/Transaction.dart';
import 'package:zibma_airpay/model/UserRequest.dart';

typedef void Closure(bool val, Transaction response);

class AirPay extends StatefulWidget {
  final UserRequest user;
  final Closure? closure;

  AirPay({Key? key, required this.user, this.closure}) : super(key: key);

  @override
  _AirPayState createState() => new _AirPayState();
}

class _AirPayState extends State<AirPay> {
  // var URL = 'https://google.com.tr';
  String url = "";
  double progress = 0;
  var postdata = "";
  bool isShow = true;

  String loadData() {
    var date = new DateTime.now();
    var format = DateFormat("yyyy-MM-dd");
    var formattedDate = format.format(date);
    var temp = utf8.encode(
        '${widget.user.secret}@${widget.user.username}:|:${widget.user.password}');
    var privatekey = sha256.convert(temp);
    var setAllData = utf8.encode(
        '${widget.user.email}${widget.user.fname}${widget.user.lname}${widget.user.fulladdress}${widget.user.city}${widget.user.state}${widget.user.country}${widget.user.amount}${widget.user.orderid}$formattedDate$privatekey');
    var checksum = md5.convert(setAllData);
    var protocolDomain = getProtoDomain(widget.user.protoDomain!);
    List<int> bytes = ascii.encode(protocolDomain);
    var encoded = base64.encode(bytes);
    var user = widget.user;

    String productionURL = "https://payments.airpay.co.in/pay/index.php";
    String productionFailedURL = "https://payments.airpay.co.in/error.php";
    // String productionVPAURL = "https://payments.airpay.co.in/upi/v.php";
    String stagingURL = "https://payments.airpay.ninja/pay/index.php";
    String stagingFailedURL = "https://payments.airpay.ninja/error.php";
    // String stagingVPAURL = "https://payments.airpay.ninja/upi/v.php";

    var isGateWay = (user.isStaging != null && user.isStaging == true)
        ? stagingURL
        : productionURL;
    user.failedUrl = (user.isStaging != null && user.isStaging == true)
        ? stagingFailedURL
        : productionFailedURL;

    var url = "<!DOCTYPE html>" +
        "<html>" +
        "<body onload='document.frm1.submit()'>" +
        "<form action='$isGateWay' method='post' name='frm1'>" +
        "  <input type='hidden' name='mer_dom' value='$encoded'><br>" +
        "  <input type='hidden' name='currency' value='${user.currency}'><br>" +
        "  <input type='hidden' name='isocurrency' value='${user.isCurrency}'><br>" +
        "  <input type='hidden' name='orderid' value='${user.orderid}'><br>" +
        "  <input type='hidden' name='privatekey' value='$privatekey'><br>" +
        "  <input type='hidden' name='checksum' value='$checksum'><br>" +
        "  <input type='hidden' name='mercid' value='${user.merchantId}'><br>" +
        "  <input type='hidden' name='buyerEmail' value='${user.email}'><br>" +
        "  <input type='hidden' name='buyerPhone' value='${user.phone}'><br>" +
        "  <input type='hidden' name='buyerFirstName' value='${user.fname}'><br>" +
        "  <input type='hidden' name='buyerLastName' value='${user.lname}'><br>" +
        "  <input type='hidden' name='buyerAddress' value='${user.fulladdress}'><br>" +
        "  <input type='hidden' name='buyerCity' value='${user.city}'><br>" +
        "  <input type='hidden' name='buyerState' value='${user.state}'><br>" +
        "  <input type='hidden' name='buyerCountry' value='${user.country}'><br>" +
        "  <input type='hidden' name='buyerPinCode' value='${user.pincode}'><br>" +
        "  <input type='hidden' name='amount' value='${user.amount}'><br>" +
        "  <input type='hidden' name='chmod' value='${user.chMode}'><br>" +
        "  <input type='hidden' name='customvar' value='${user.customVar}'><br>" +
        "  <input type='hidden' name='txnsubtype' value='${user.txnSubtype}'><br>" +
        "  <input type='hidden' name='token' value=''><br>" +
        "  <input type='hidden' name='txnsubtype' value='${user.txnSubtype}'><br>" +
        "</form>" +
        "</body>" +
        "</html>";
    return url;
  }

  String getProtoDomain(String sDomain) {
    int slashslash = sDomain.indexOf("//") + 2;
    return sDomain.substring(0, sDomain.indexOf("/", slashslash));
  }

  fetchDetails() async {
    var user = widget.user;

    String stagingDataURL = "https://payments.airpay.ninja/sdk/a.php";
    String productionDataURL = "https://payments.airpay.co.in/sdk/a.php";
    var isGateWay = (user.isStaging != null && user.isStaging == true)
        ? stagingDataURL
        : productionDataURL;

    String urlString = isGateWay;
    var date = new DateTime.now();
    var format = DateFormat("dd/MM/yyyy HH:mm:ss");
    var formattedDate = format.format(date);
    format = DateFormat("yyyy HH:mm:ss");
    var formattedDate2 = format.format(date);

    var temp = utf8.encode(
        '${widget.user.secret}@${widget.user.username}:|:${widget.user.password}');
    var privatekey = sha256.convert(temp);

    var setAllData = utf8.encode(
        '$privatekey${widget.user.orderid}${widget.user.merchantId}$formattedDate2');
    var checksum = md5.convert(setAllData);

    FormData formData = new FormData.fromMap({
      'privatekey': privatekey,
      'orderid': widget.user.orderid,
      'mercid': widget.user.merchantId,
      'checksum': checksum,
      'datetime': formattedDate,
    });
    Dio dio = new Dio();
    dio.options.headers['Accept'] =
        'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';

    var response = await dio.post(urlString, data: formData);
    print(response);
    final myTransformer = Xml2Json();
    var stingDAta = response.data.toString();
    stingDAta = stingDAta.replaceAll("<![CDATA[", "").replaceAll("]]>", "");
    myTransformer.parse(stingDAta);
    var document = myTransformer.toParker();
    var data = json.decode(document);
    Transaction transaction = Transaction();
    transaction.sTATUS = '500';
    if (data != null && data['RESPONSE'] != null) {
      if (data['RESPONSE']['TRANSACTION'] != null) {
        transaction = Transaction.fromJson(data['RESPONSE']['TRANSACTION']);
      }
    }
    // print("Transaction $data");
    if (transaction.sTATUS != null) {
      if (transaction.sTATUS == '200') {
        widget.closure!(true, transaction);
        Navigator.pop(context);
      } else {
        widget.closure!(false, transaction);
        Navigator.pop(context);
      }
    }
  }

  userCancel(String withMessage) {
    var trans = Transaction();
    trans.sTATUS = '500';
    trans.tRANSACTIONREASON = withMessage;
    widget.closure!(false, trans);
  }

  _showConfirmation(context, message) async {
    await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        String title = "Airpay";
        String message1 = message;
        return Platform.isIOS
            ? new CupertinoAlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        Navigator.pop(context);
                        userCancel('User canceled');
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(8.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  )
                ],
              )
            : new AlertDialog(
                title: Text(title),
                content: Text(message1),
                actions: <Widget>[
                  new Container(
                    margin: EdgeInsets.all(0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(2.0),
                      onPressed: () {
                        Navigator.pop(context);
                        userCancel('User canceled');
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  ),
                  new Container(
                    margin: EdgeInsets.all(0),
                    child: RaisedButton(
                      padding: EdgeInsets.all(2.0),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: Colors.blue[900],
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white, fontSize: 24.0),
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }

  // InAppWebViewController _webViewController;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () =>  _showConfirmation(
            context, "Did you want to cancel this transaction ?"),
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Image.asset(
              'assets/airpays.png',
              height: 40,
              color: Colors.white,
              width: 200,
            ),
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => {
                _showConfirmation(
                    context, "Did you want to cancel this transaction ?")
              },
            ),
            backgroundColor: Colors.blue[900],
            actions: <Widget>[],
          ),
          body: Container(
              child: Column(children: <Widget>[
            Container(
                // padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? SpinKitCircle(
                        color: Colors.blue[900],
                        size: 50.0,
                      )
                    : Container()),
            (isShow
                ? Expanded(
                    child: InAppWebView(
                      //initialUrl: URL,
                      initialData: InAppWebViewInitialData(
                        data: loadData(),
                      ),
                      initialOptions: InAppWebViewGroupOptions(
                          crossPlatform: InAppWebViewOptions(
                        // debuggingEnabled: true,
                        javaScriptEnabled: true,
                      )),
                      // onTitleChanged:
                      //     (InAppWebViewController controller, String? url) {
                      //   setState(() {
                      //     print("onTitleChanged : $url");
                      //   });
                      // },
                      onTitleChanged: (controller, title) {
                        setState(() {
                          print("onTitleChanged : $title");
                        });
                      },
                      onWebViewCreated: (InAppWebViewController controller) {},
                      // onLoadStart:
                      //     (InAppWebViewController controller, String url) {
                      //   setState(() {
                      //     print("onLoadStart : $url");
                      //     var succesPath = getProtoDomain(widget.user.successUrl);
                      //     var webURLPath = getProtoDomain(url);
                      //     if (succesPath.contains("http://") &&
                      //         webURLPath.contains("https://")) {
                      //       webURLPath =
                      //           webURLPath.replaceAll("https://", "http://");
                      //     } else if (succesPath.contains("https://") &&
                      //         webURLPath.contains("http://")) {
                      //       webURLPath =
                      //           webURLPath.replaceAll("http://", "https://");
                      //     }
                      //
                      //     if (succesPath == webURLPath) {
                      //       isShow = false;
                      //       fetchDetails();
                      //       // print("onLoadStart : Success");
                      //     } else if (widget.user.failedUrl == webURLPath) {
                      //       userCancel('Transaction failed');
                      //       print("onLoadStart : Failed");
                      //     }
                      //   });
                      // },
                      onLoadStart: (controller, url) {
                        setState(() {
                          print("onLoadStart : $url");
                          var succesPath =
                              getProtoDomain(widget.user.successUrl!);
                          var webURLPath = getProtoDomain(url.toString());
                          if (succesPath.contains("http://") &&
                              webURLPath.contains("https://")) {
                            webURLPath =
                                webURLPath.replaceAll("https://", "http://");
                          } else if (succesPath.contains("https://") &&
                              webURLPath.contains("http://")) {
                            webURLPath =
                                webURLPath.replaceAll("http://", "https://");
                          }

                          if (succesPath == webURLPath) {
                            isShow = false;
                            fetchDetails();
                            // print("onLoadStart : Success");
                          } else if (widget.user.failedUrl == webURLPath) {
                            userCancel('Transaction failed');
                            print("onLoadStart : Failed");
                          }
                        });
                      },
                      // onLoadStop:
                      //     (InAppWebViewController controller, String url) async {
                      //   String ht = await controller.evaluateJavascript(
                      //       source:
                      //           "javascript:window.droid.print(document.getElementsByClassName('alert')[0].innerHTML);");
                      //
                      //   setState(() {
                      //     this.url = url;
                      //     var failurePath = widget.user
                      //         .failedUrl; //getProtoDomain(widget.user.failedUrl);
                      //
                      //     if (url.startsWith(failurePath)) {
                      //       setState(() {
                      //         // controller.loadUrl(url: ht);
                      //         // print('ht: $url');
                      //         userCancel('Transaction failed');
                      //         print('onLoad Stop in - $url');
                      //       });
                      //     } else {
                      //       print('on Load Stop: not error URL: $url');
                      //     }
                      //   });
                      // },
                      onLoadStop: (controller, url) async {
                        // String ht = await controller.evaluateJavascript(
                        //     source:
                        //         "javascript:window.droid.print(document.getElementsByClassName('alert')[0].innerHTML);");

                        setState(() {
                          this.url = url.toString();
                          var failurePath = widget.user
                              .failedUrl; //getProtoDomain(widget.user.failedUrl);

                          if (url.toString().startsWith(failurePath!)) {
                            setState(() {
                              userCancel('Transaction failed');
                              print('onLoad Stop in - $url');
                            });
                          } else {
                            print('on Load Stop: not error URL: $url');
                          }
                        });
                      },
                      onProgressChanged:
                          (InAppWebViewController controller, int progress) {
                        setState(() {
                          this.progress = progress / 100;
                        });
                      },
                    ),
                  )
                : Container()),
          ])),
        ),
      ),
    );
  }
}
