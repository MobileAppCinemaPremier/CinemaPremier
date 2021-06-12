import 'package:flutter/material.dart';

class PaymentUi extends StatefulWidget {
  PaymentUi({Key key}) : super(key: key);
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<PaymentUi> {
  int value = 0;
  final paymentLabels = [
    'Credit card / Debit Card',
    'Paypal',
    'Google Wallet',
  ];
  final paymentIcons = [
    Icons.credit_card,
    Icons.payment,
    Icons.account_balance_wallet
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: paymentLabels.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Radio(
            activeColor: Colors.yellow[800],
            value: index,
            groupValue: value,
            onChanged: (i) => setState(() => value = i),
          ),
          title: Text(
            paymentLabels[index],
            style: TextStyle(color: Colors.black),
          ),
          trailing: Icon(
            paymentIcons[index],
            color: Colors.yellow[800],
          ),
        );
      },
      separatorBuilder: (context, index) {
        return Divider();
      },
    );
  }
}
