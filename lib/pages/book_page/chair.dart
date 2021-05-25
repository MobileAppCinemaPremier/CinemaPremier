import 'package:flutter/material.dart';

class Chair {
  static Widget selectedChair() {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          color: Color(0xffF9B015), borderRadius: BorderRadius.circular(6.0)),
    );
  }

  static Widget availableChair() {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(6.0)),
    );
  }

  static Widget reservedChair() {
    return Container(
      height: 10.0,
      width: 10.0,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(6.0)),
    );
  }
}
