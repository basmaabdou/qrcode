
import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../shared/constants.dart';
import 'cubit_profile/cubit.dart';
import 'cubit_profile/states.dart';



class HomeScreen extends StatelessWidget {

  var amountController = TextEditingController();

  var userIdController = TextEditingController();
  var coinsValueController = TextEditingController();

  Future<void> _scanBarcode(BuildContext context) async {
    try {
      String barcodeResult = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.QR,
      );
      if (barcodeResult != '-1' && barcodeResult.isNotEmpty) {
        var decodedData = jsonDecode(barcodeResult);
        userIdController.text = decodedData['id'].toString();
        coinsValueController.text = decodedData['coins'].toString();
      }
    } catch (e) {
      print('Error decoding barcode: $e');
      userIdController.text = 'Failed to get the user ID';
      coinsValueController.text = 'Failed to get the coins value';
    }
  }

  void clearInputs() {
    userIdController.clear();
    coinsValueController.clear();
    amountController.clear();
  }
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  =>ProfileCubit(),
      child: BlocConsumer<ProfileCubit,ProfileStates>(
        listener: (BuildContext context,  state) {  },
        builder: (BuildContext context,  state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: userIdController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'User ID',
                        labelStyle: TextStyle(
                            color: Color(0xff777A95),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:defaultColor)
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: coinsValueController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Coins Value',
                        labelStyle: TextStyle(
                          color: Color(0xff777A95),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:defaultColor)
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _scanBarcode(context),
                      child: Text('Scan QR Code'),
                      style: ElevatedButton.styleFrom(backgroundColor: defaultColor),
                    ),
                    SizedBox(height: 10),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: amountController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Amount to Exchange',
                        labelStyle: TextStyle(
                          color: Color(0xff777A95),
                        ),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color:defaultColor)
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ConditionalBuilder(
                      condition: state is! LoadingExchangeCoinsStates,
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                           ProfileCubit.get(context).getExchangeCoins(
                               amount: amountController.text);
                        },
                        child: Text('Exchange Coins'),
                        style: ElevatedButton.styleFrom(backgroundColor: defaultColor),
                      ),
                      fallback: (context) =>
                          Center(child: CircularProgressIndicator(color: defaultColor,)),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
