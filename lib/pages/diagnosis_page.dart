import 'dart:io';
import 'package:flutter/material.dart';

import '../components/app_bar.dart';
import '../components/common_button_style.dart';
import '../constants/colors.dart';
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


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBarWidget(title: 'eyX3',),
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
                              index != 3 ? 'Know More' : '',
                              style: const TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              dispose();
              Navigator.pop(context);
            },
            style: CommonButtonStyle.getButtonStyle(),
            child: Text('Try Another', style: button),
          ),
          SizedBox(height: 100),
          Text('*The results of the eye disease detection may be inaccurate', style: p)
        ],
      ),
    );
  }
}