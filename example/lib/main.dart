
import 'package:flutter/material.dart';
import 'package:zibma_airpay/model/Transaction.dart';
import 'package:zibma_airpay/model/UserRequest.dart';
import 'package:zibma_airpay/screens/inappwebview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AirPay Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'AirPay Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String username = '5926256';
  String password = 'me65Pf2K';
  String secret = 'A3brM5V9wjMWZh29';
  String merchantId = '40594';
  String protoDomain =
      'https://school.zibma.com/School5/OnlinePayResponse.aspx';
  String currency = '356';
  String isCurrency = 'INR';
  String chMode = '';
  String customVar = '';
  String txnSubtype = '';
  String wallet = '0';
  bool isStaging = false;
  String successUrl = 'https://school.zibma.com/School5/OnlinePayResponse.aspx';

  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _fullAddressController = TextEditingController();
  final _pincodeController = TextEditingController();
  final _orderidController = TextEditingController();
  final _amountController = TextEditingController();
  final _cityController = TextEditingController();
  final _stateController = TextEditingController();
  final _countryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fnameController.text = 'Rajnik';
    _lnameController.text = 'Patel';
    _emailController.text = 'rajnikpatel74044@gmail.com';
    _phoneController.text = '8511895785';
    _fullAddressController.text = '';
    _pincodeController.text = '';
    _orderidController.text = '3322';
    _amountController.text = '1000';
    _cityController.text = '';
    _stateController.text = '';
    _countryController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0.0, 16, 0, 0),
        child: ListView(children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              FnameFiled(),
              LnameFiled(),
              emailFiled(),
              phoneFiled(),
              fullAddressFiled(),
              pincodeFiled(),
              orderidFiled(),
              amountFiled(),
              cityFiled(),
              stateFiled(),
              countryFiled(),
              SubmitFiled(),
            ],
          ),
        ]),
      ),
    );
  }

  Widget FnameFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _fnameController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'fname *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter fname Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget LnameFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _lnameController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'lname *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter lname Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget emailFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _emailController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'email *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter email Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget phoneFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _phoneController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'phone *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter phone Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fullAddressFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  maxLines: 5,
                  minLines: 3,
                  controller: _fullAddressController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'full Address *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter full Address Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pincodeFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _pincodeController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'pincode *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter pincode Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget orderidFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _orderidController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'orderid *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter orderid Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget amountFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _amountController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'amount *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter amount Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget cityFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _cityController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'city *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter city Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget stateFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _stateController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'state *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter State Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget countryFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(1.1, 1.1),
            ),
          ],
        ),
        padding: EdgeInsets.fromLTRB(20, 0, 12, 0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                child: TextField(
                  controller: _countryController,
                  style: TextStyle(
                    color: Colors.black.withOpacity(.9),
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: new InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Country *',
                    labelStyle: TextStyle(
                      color: Colors.black.withOpacity(.7),
                    ),
                    hintText: 'Enter Country Here',
                    hintStyle: TextStyle(
                        color: Colors.grey.withOpacity(.5),
                        fontWeight: FontWeight.w700,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getProtoDomain(String sDomain) {
    int slashslash = sDomain.indexOf("//") + 2;
    return sDomain.substring(0, sDomain.indexOf("/", slashslash));
  }

  Widget SubmitFiled() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0, 16, 16),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          debugPrint('StudentLeave->jsonData: ${getProtoDomain(successUrl)}');
          UserRequest user = UserRequest(
              username: username,
              password: password,
              secret: secret,
              merchantId: merchantId,
              protoDomain: successUrl,
              fname: _fnameController.text,
              lname: _lnameController.text,
              email: _emailController.text,
              phone: _phoneController.text,
              fulladdress: _fullAddressController.text,
              pincode: _pincodeController.text,
              orderid: _orderidController.text,
              amount: _amountController.text,
              city: _cityController.text,
              state: _stateController.text,
              country: _countryController.text,
              currency: currency,
              isCurrency: isCurrency,
              chMode: chMode,
              customVar: customVar,
              txnSubtype: txnSubtype,
              wallet: wallet,
              isStaging: isStaging,
              successUrl: successUrl);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => new AirPay(
                  user: user,
                  closure: (status, response) =>
                      {onComplete(status, response)}),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blueAccent,
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.blueAccent.withOpacity(0.80),
                blurRadius: 10,
                offset: Offset(1.5, 1.5),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(14, 20, 12, 20),
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Text(
              'Submit',
              style: TextStyle(
                letterSpacing: 1,
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  onComplete(bool status, Transaction response) {
    debugPrint('status: ${status}');
    debugPrint('sTATUS: ${response.sTATUS}');

    debugPrint('response: ${response.toJson()}');
  }
}
