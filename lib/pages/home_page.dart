import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;

import '../components/app_bar.dart';
import '../constants/colors.dart';
import '../constants/font_styles.dart';
import '../constants/size.dart';
import 'diagnosis_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      final imageTemp = File(pickedImage.path);
      setState(() => image = imageTemp);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DiagnosisPage(image: image)),
      );
    } on PlatformException catch (e) {
      devtools.log('Failed to pick image: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(title: 'eyX3',),
      body: Column(
        children: [
          Column(
            children: [
              const SizedBox(height: large),
              Center(child: Text('Upload Image for Detection', style: h2)),
              const SizedBox(height: large / 2),
              Card(
                elevation: xsmall,
                child: DottedBorder(
                  dashPattern: const [xsmall, xsmall/2],
                  strokeWidth: 2,
                  child: Container(
                    height: 260,
                    width: 320,
                    decoration: const BoxDecoration(
                      color: white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(35.0),
                      child: Column(
                        children: [
                          const Icon(Icons.file_upload_outlined, size: 75),
                          const Spacer(),
                          Row(
                            children: [
                              SizedBox(
                                width : 121,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(background),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                  ),
                                  child: Text('Camera', style: button),
                                ),
                              ),
                              const Spacer(),
                              SizedBox(
                                width: 121,
                                child: ElevatedButton(
                                  onPressed: () {
                                    pickImage(ImageSource.gallery);
                                  },
                                  style: ButtonStyle(

                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(background),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                  ),
                                  child: Text('Upload', style: button),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
