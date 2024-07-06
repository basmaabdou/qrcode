import 'dart:convert';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../shared/constants.dart';
import '../widget/basic.dart';
import '../widget/default_text_form_field..dart';
import 'cubit_profile/cubit.dart';
import 'cubit_profile/states.dart';

class HomeScreen extends StatelessWidget {
  var amountController = TextEditingController();
  var userIdController = TextEditingController();
  var coinsValueController = TextEditingController();

  HomeScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileCubit(),
      child: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (BuildContext context, state) {
          if (state is SuccessExchangeCoinsStates) {
            if (state.exchangeCoins.success == true) {
              Get.snackbar("Success", "The discount was successful",
                  backgroundColor: Colors.green, colorText: Colors.white);
              messageToast(msg: 'The discount was successful', state: ToastStates.SUCCESS);
            } else {
              Get.snackbar("Failed", "The number of coins is not available",
                  backgroundColor: Colors.red, colorText: Colors.white);
            }
          } else if (state is ErrorExchangeCoinsStates) {
            Get.snackbar("Error", "An error occurred while exchanging coins",
                backgroundColor: Colors.red, colorText: Colors.white);
          }
        },
        builder: (BuildContext context, state) {
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
                          borderSide: BorderSide(color: controller2.app),
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
                          borderSide: BorderSide(color: controller2.app),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _scanBarcode(context),
                      child: Text('Scan QR Code'),
                      style: ElevatedButton.styleFrom(backgroundColor: controller2.app),
                    ),
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
                          borderSide: BorderSide(color: controller2.app),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ConditionalBuilder(
                      condition: state is! LoadingExchangeCoinsStates,
                      builder: (context) => ElevatedButton(
                        onPressed: () {
                          if (amountController.text.isNotEmpty && userIdController.text.isNotEmpty) {
                            ProfileCubit.get(context).getExchangeCoins(
                              amount: amountController.text,
                              id: userIdController.text,
                            );
                          } else {
                            Get.snackbar("Error", "Please fill all fields",
                                backgroundColor: Colors.red, colorText: Colors.white);
                          }
                        },
                        child: Text('Exchange Coins'),
                        style: ElevatedButton.styleFrom(backgroundColor: controller2.app),
                      ),
                      fallback: (context) => Center(
                        child: CircularProgressIndicator(color: controller2.app),
                      ),
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
