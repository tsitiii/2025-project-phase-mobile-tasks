import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Addproduct extends StatefulWidget {
  const Addproduct({super.key});

  @override
  State<Addproduct> createState() => _AddproductState();
}

class _AddproductState extends State<Addproduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text("Add Product"),
        actions: [],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: GestureDetector(
                onTap: () => pickImage(),
                child: Container(
                  width: 300,
                  height: 150,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child:
                      _image == null
                          ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.cloud_upload_outlined,
                                size: 70,
                                color: Colors.grey,
                              ),
                              const SizedBox(height: 10),
                              Text("Upload image"),
                            ],
                          )
                          : ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.file(
                              _image!,
                              width: 300,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                ),
              ),
            ),
            Form(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text("name"),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Text("Category"),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Text("Price"),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Column(
                      children: [
                        Text("Description", style: TextStyle()),
                        const SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            fillColor: const Color.fromARGB(255, 207, 206, 206),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  File? _image;
  pickImage() async {
    final _picker = ImagePicker();
    final PickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      _image = File(PickedFile.path); // changing the picked file to path
      setState(() {});
    }
  }
}
