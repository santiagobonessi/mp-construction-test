import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/diaries.dart';
import '../providers/diary.dart';
import '../widgets/app_bar.dart';
import '../widgets/button.dart';
import '../widgets/card.dart';
import '../widgets/dropdown.dart';
import '../widgets/input.dart';

class NewDiaryPage extends StatefulWidget {
  static const routeName = '/new-diary';

  const NewDiaryPage({Key? key}) : super(key: key);

  @override
  State<NewDiaryPage> createState() => _NewDiaryPageState();
}

class _NewDiaryPageState extends State<NewDiaryPage> {
  final diaryForm = GlobalKey<FormState>();
  Diary? diary;
  List<XFile>? _imageFileList;
  TextEditingController comments = TextEditingController();
  List<String> areas = ['Residential', 'Institutional', 'Rural'];
  List<String> categories = ['Design', 'Planning', 'Arrangement'];
  List<String> events = ['Construction', 'Development', 'Collapse', 'Flood'];
  String? selectedArea;
  String? selectedCategory;
  String? selectedEvent;
  bool isPhotoGalleryIncluded = true;
  bool isEventLinked = true;

  @override
  void initState() {
    super.initState();
  }

  void _pickImages() async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile>? pickedFileList = await picker.pickMultiImage(
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 80,
      );
      setState(() {
        _imageFileList = pickedFileList;
      });
    } catch (e) {
      setState(() {
        showErrorDialog();
      });
    }
  }

  Widget _previewImages() {
    if (_imageFileList != null && _imageFileList!.isNotEmpty) {
      return Container(
        height: 100,
        padding: const EdgeInsets.all(2.0),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              children: [
                Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 10),
                  child: Image.file(
                    fit: BoxFit.cover,
                    File(
                      _imageFileList![index].path,
                    ),
                  ),
                ),
                Positioned(
                  right: -2,
                  top: -9,
                  child: IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.black.withOpacity(0.5),
                      size: 22,
                    ),
                    onPressed: () => setState(() {
                      _imageFileList!.removeAt(index);
                    }),
                  ),
                ),
              ],
            );
          },
          itemCount: _imageFileList!.length,
        ),
      );
    } else {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        child: Text('You have not yet add a photo.'),
      );
    }
  }

  List<Widget> _buildDivider() {
    return [
      const SizedBox(height: 4),
      const Divider(height: 1.0, color: Colors.grey),
      const SizedBox(height: 4),
    ];
  }

  void _selectArea(String value) {
    setState(() {
      selectedArea = value;
    });
  }

  void _selectCategory(String value) {
    setState(() {
      selectedCategory = value;
    });
  }

  void _selectEvent(String value) {
    setState(() {
      selectedEvent = value;
    });
  }

  void _createDiary() async {
    // CHECK VALIDATIONS AND CREATE A NEW DIARY
    if (diaryForm.currentState!.validate()) {
      final newDiary = Diary(
        photos: _imageFileList,
        comments: comments.text,
        area: selectedArea,
        category: selectedCategory,
        event: selectedEvent,
        isPhotoGalleryIncluded: isPhotoGalleryIncluded,
      );
      final diariessData = Provider.of<Diaries>(context, listen: false);
      try {
        await diariessData.createDiary(newDiary);
      } catch (error) {
        showErrorDialog();
      }
    }
  }

  void showErrorDialog() async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('An error ocurred!'),
        content: const Text('Something went wrong.'),
        actions: [
          ElevatedButton(
            child: const Text('Okay'),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: 'New Diary',
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: diaryForm,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Add to site diary',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(
                        Icons.help,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),
                CardWidget(
                  children: [
                    const Text('Add Photos to site diary'),
                    ..._buildDivider(),
                    _previewImages(),
                    const SizedBox(height: 8.0),
                    ButtonWidget(
                      onPressed: () => _pickImages(),
                      title: 'Add a photo',
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Include in photo gallery'),
                        Checkbox(
                          value: isPhotoGalleryIncluded,
                          onChanged: (value) => setState(() {
                            isPhotoGalleryIncluded = value!;
                          }),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CardWidget(
                  children: [
                    Text('Comments', style: Theme.of(context).textTheme.subtitle1),
                    ..._buildDivider(),
                    InputWidget(
                      placeholder: 'Comments',
                      controller: comments,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CardWidget(
                  children: [
                    Text('Details', style: Theme.of(context).textTheme.subtitle1),
                    ..._buildDivider(),
                    DropdownWidget(
                      placeholder: 'Select Area',
                      elements: areas,
                      selectedValue: selectedArea,
                      callback: _selectArea,
                    ),
                    DropdownWidget(
                      placeholder: 'Task Category',
                      elements: categories,
                      selectedValue: selectedCategory,
                      callback: _selectCategory,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                CardWidget(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Link to existing event?', style: Theme.of(context).textTheme.subtitle2),
                        Checkbox(
                          value: isEventLinked,
                          onChanged: (value) => setState(() {
                            isEventLinked = value!;
                          }),
                        ),
                      ],
                    ),
                    DropdownWidget(
                      placeholder: 'Select an Event',
                      elements: events,
                      selectedValue: selectedEvent,
                      callback: _selectEvent,
                      isDisabled: !isEventLinked,
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                ButtonWidget(
                  title: 'Next',
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onPressed: _createDiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
