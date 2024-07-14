import 'dart:io';
import 'package:eyx3/services/db_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'dart:developer' as devtools;
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import '../key/key.dart';
import '../components/app_bar.dart';
import '../components/common_button_style.dart';
import '../constants/colors.dart';
import '../constants/diseases.dart';
import '../constants/font_styles.dart';
import '../constants/size.dart';

class DiagnosisPage extends StatefulWidget {
  final File? image;

  const DiagnosisPage({super.key, required this.image});

  @override
  State<DiagnosisPage> createState() => _DiagnosisPageState();
}

class _DiagnosisPageState extends State<DiagnosisPage> {
  String detectedDisease = "Loading...";
  String link = '';
  double confidence = 0.0;
  int? index;
  String description = " ";

  final StellarSDK stellar = StellarSDK.TESTNET;
  final KeyPair keyPair = KeyPair.fromSecretSeed(privateKey);

  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  @override
  void initState() {
    super.initState();
    _tfliteinit(context);
  }

  Future<void> _tfliteinit(BuildContext context) async {
    String? res = await Tflite.loadModel(
        model: "assets/model/model.tflite",
        labels: "assets/model/labels.txt",
        numThreads: 1,
        isAsset: true,
        useGpuDelegate: false);

    if (res != null) {
      var recognitions = await Tflite.runModelOnImage(
          path: widget.image!.path,
          imageMean: 0.0,
          imageStd: 224.0,
          numResults: 2,
          threshold: 0.2,
          asynch: true);

      if (recognitions == null) {
        devtools.log("recognitions null");
        return;
      }

      devtools.log(recognitions.toString());

      setState(() {
        detectedDisease = recognitions[0]['label'];
        link = SeeHow[recognitions[0]['index']];
        confidence = (recognitions[0]['confidence'] * 100);
        index = recognitions[0]['index'];
        if (index == 3) {
          description = "\nCongrats You Have Normal Eye";
        } else {
          description =
              "\nIts better to visit an ophthalmologist for a comprehensive eye examination";
        }
      });

      // Call the Stellar function to handle transaction
      await _sendStellarTransaction();
    }
  }

  Future<void> _sendStellarTransaction() async {
    try {
      devtools.log("Account ID: ${keyPair.accountId}");
      AccountResponse account =
          await stellar.accounts.account(keyPair.accountId);
      devtools.log("Account loaded: $account");

      Transaction transaction = TransactionBuilder(account)
          .addOperation(
              PaymentOperationBuilder(keyPair.accountId, AssetTypeNative(), "1")
                  .build())
          .addMemo(MemoText('Eye Disease Detection Transaction'))
          .build();

      transaction.sign(
          keyPair, Network.TESTNET); // Change to Network.PUBLIC for mainnet

      SubmitTransactionResponse response =
          await stellar.submitTransaction(transaction);
      devtools.log("Transaction response: ${response.success}");
    } catch (e) {
      devtools.log("Error in Stellar transaction: $e");
    }
  }

  Future<void> _handlePeriodicCheck() async {
    // Create and upload the smart contract here
    await _sendStellarTransaction();

    // Add data to the database
    DbHelper dbhelper = DbHelper();
    await dbhelper.addData("Periodic Check", "id");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(
        title: 'eyX3',
      ),
      body: Column(
        children: [
          const SizedBox(height: 30),
          Center(
            child: Container(
              height: 232,
              width: 340,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: widget.image != null
                    ? DecorationImage(
                        image: FileImage(widget.image!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
            ),
          ),
          const SizedBox(height: large / 4),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Center(
              child: Container(
                height: 232,
                width: 340,
                decoration: BoxDecoration(
                  color: background2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Result', style: h1),
                      Text('You likely have : $detectedDisease', style: h3),
                      Text(
                        description,
                        style: descriptionStyle,
                      ),
                      InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              index == 3 ? ' ' : 'Contact Doctor',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          onTap: () async {
                            DbHelper dbhelper = DbHelper();
                            await dbhelper.addData("User Diagnosed", "id");

                            // Call Stellar function here if needed
                            await _sendStellarTransaction();
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () async {
              if (index == 3) {
                await _handlePeriodicCheck();
              }
              Navigator.pop(context);
              dispose();
            },
            style: CommonButtonStyle.getButtonStyle(),
            child: Text('Try Another', style: button),
          ),
          const SizedBox(height: 100),
          Text('*The results of the eye disease detection may be inaccurate',
              style: p)
        ],
      ),
    );
  }
}
