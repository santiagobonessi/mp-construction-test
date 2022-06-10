import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/button.dart';

class NewDiaryPage extends StatefulWidget {
  static const routeName = '/new-diary';

  const NewDiaryPage({Key? key}) : super(key: key);

  @override
  State<NewDiaryPage> createState() => _NewDiaryPageState();
}

class _NewDiaryPageState extends State<NewDiaryPage> {
  List<XFile>? _imageFileList;

  void pickImages() async {
    final ImagePicker _picker = ImagePicker();
    dynamic _pickImageError;

    try {
      final List<XFile>? pickedFileList = await _picker.pickMultiImage(
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 80,
      );
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Widget _previewImages() {
    if (_imageFileList != null) {
      return Container(
        height: 100,
        padding: const EdgeInsets.all(2.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 100,
              margin: const EdgeInsets.only(right: 10),
              child: Image.file(
                fit: BoxFit.cover,
                File(
                  _imageFileList![index].path,
                ),
              ),
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Diary'),
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add to site diary',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Icon(
                    Icons.help,
                    color: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Add Photos to site diary'),
                      const SizedBox(height: 8.0),
                      const Divider(height: 1.0, color: Colors.grey),
                      const SizedBox(height: 8.0),
                      _previewImages(),
                      const SizedBox(height: 8.0),
                      ButtonWidget(
                        onPressed: () => pickImages(),
                        title: 'Add a photo',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
