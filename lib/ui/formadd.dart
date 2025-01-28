import 'dart:io';

import 'package:assignment_app/helper/global_provider.dart';
import 'package:assignment_app/ui/success.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart' as intl;
import 'package:image_picker/image_picker.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  var name = '';
  var nameError = false;
  var nameErrorMsg = '';

  var contact = '';
  var contactError = false;
  var contactErrorMsg = '';

  var desc = '';
  var descError = false;
  var descErrorMsg = '';

  var date = '';
  var dateError = false;
  var dateErrorMsg = '';

  var location = '';
  var locationError = false;
  var locationErrorMsg = '';

  var _imgNames = [];

  var _imgPaths = [];
  var imgError = false;
  var imgErrorMsg = ''; 

  bool isValidName() {
    if (name.isEmpty) {
      setState(() {
        nameError = true;
        nameErrorMsg = 'Name Cannot be Empty';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isValidContact() {
    if (contact.isEmpty) {
      setState(() {
        contactError = true;
        contactErrorMsg = 'Contact Cannot be Empty';
      });
      return false;
    } else if (contact.length<10) {
      setState(() {
        contactError = true;
        contactErrorMsg = 'Enter a valid phone number';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isValidDesc() {
    if (desc.isEmpty) {
      setState(() {
        descError = true;
        descErrorMsg = 'Description Cannot be Empty';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isValidDate() {
    if (date.isEmpty) {
      setState(() {
        dateError = true;
        dateErrorMsg = 'Date Cannot be Empty';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isValidLocation() {
    if (location.isEmpty) {
      setState(() {
        locationError = true;
        locationErrorMsg = 'Location Cannot be Empty';
      });
      return false;
    } else {
      return true;
    }
  }

  bool isValidImage() {
    if (_imgPaths.isEmpty) {
      setState(() {
        imgError = true;
        imgErrorMsg = 'Please upload image';
      });
      return false;
    } else {
      return true;
    }
  }

  final ImagePicker _picker = ImagePicker();

  DateTime? _selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? currentDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        dateError = false;
        dateErrorMsg = '';
        _selectedDate = pickedDate;
        date = intl.DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  void _showImagePickerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Choose Image Source'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _requestPermission(Permission.camera);
                _pickImage(ImageSource.camera);
              },
              child: Text('Camera'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                await _requestPermission(Permission.photos);
                _pickImages();
              },
              child: Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  void _deleteImage(int index) {
    setState(() {
      _imgPaths.removeAt(index);
    });
  }

  Future<void> _requestPermission(Permission permission) async {
    final status = await permission.request();
    if (status.isGranted) {
      print('Permission granted');
    } else {
      print('Permission denied');
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        imgError = false;
        imgErrorMsg = '';
        _imgPaths.add(pickedFile.path);
      });
    }
  }

  Future<void> _pickImages() async {
    // Request permission to access photos

    // Open file picker to select multiple images
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image, // Only image files
      allowMultiple: true, // Allow multiple selection
    );

    if (result != null) {
      setState(() {
        imgError = false;
        imgErrorMsg = '';
        _imgPaths = result.paths;
        _imgNames = result.names;
      });
    } else {
      print('No images selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<GlobalProvider>(context, listen: false);
    globalData.items.clear();

    String formattedDate = _selectedDate == null
        ? 'Pick a Date'
        : intl.DateFormat('yyyy-MM-dd').format(_selectedDate!);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Form Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      autofocus: true,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your name',
                          labelText: 'Name',
                          errorText: nameError ? nameErrorMsg : null),
                      onChanged: (value) {
                        setState(() {
                          nameError = false;
                          nameErrorMsg = '';
                          name = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      autofocus: false,
                      keyboardType: TextInputType.number,
                      maxLength: 10,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your phone',
                          labelText: 'Phone',
                          errorText: contactError ? contactErrorMsg : null),
                      onChanged: (value) {
                        setState(() {
                          contactError = false;
                          contactErrorMsg = '';
                          contact = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      autofocus: false,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter item description',
                          labelText: 'Item Description',
                          errorText: descError ? descErrorMsg : null),
                      onChanged: (value) {
                        setState(() {
                          descError = false;
                          descErrorMsg = '';
                          desc = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.maxFinite,
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer), // Border around button
                        borderRadius: BorderRadius.circular(8),

                        // Rounded corners
                      ),
                      child: Column(
                        children: [
                          TextButton.icon(
                            icon: Icon(Icons.calendar_month),
                            onPressed: () => _selectDate(context),
                            label: Text(
                              formattedDate,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          dateError
                              ? Text(
                                  dateErrorMsg,
                                  style: TextStyle(color: Colors.redAccent),
                                )
                              : Text('')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: TextField(
                      autofocus: false,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter your location',
                          labelText: 'Location',
                          errorText: locationError ? locationErrorMsg : null),
                      onChanged: (value) {
                        setState(() {
                          locationError = false;
                          locationErrorMsg = '';
                          location = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .secondaryContainer), // Border around button
                        borderRadius: BorderRadius.circular(8),

                        // Rounded corners
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Upload Image",
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: ElevatedButton(
                                  onPressed: () =>
                                      _showImagePickerDialog(context),
                                  child: Icon(Icons.image),
                                ),
                              ),
                            ],
                          ),
                          imgError
                              ? Text(
                                  imgErrorMsg,
                                  style: TextStyle(color: Colors.redAccent),
                                )
                              : Text(''),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  _imgPaths.isEmpty
                      ? Text("")
                      : Container(
                          height: 150, // Set the height of the list

                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _imgPaths.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Stack(
                                  children: [
                                    // Image
                                    Image.file(
                                      File(_imgPaths[index]),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    // Delete button
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => _deleteImage(index),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                  ElevatedButton(
                      onPressed: () {
                        if (!isValidName()) {
                        } else if (!isValidContact()) {
                        } else if (!isValidDesc()) {
                        } else if (!isValidDate()) {
                        } else if (!isValidLocation()) {
                        } else if (!isValidImage()) {
                        } else {
                          setState(() {
                            nameError = false;
                            nameErrorMsg = '';
                            contactError = false;
                            contactErrorMsg = '';
                            descError = false;
                            descErrorMsg = '';
                            dateError = false;
                            dateErrorMsg = '';
                          });

                          globalData.addFormData({
                            'name': name,
                            'contact': contact,
                            'desc': desc,
                            'date': date,
                            'location': location,
                          });

                          for (final e in _imgNames) {
                            //
                            globalData.addItem(e);
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SuccessPagState()),
                          );
                        }
                      },
                      child: Text('Submit'))
                ]),
          ),
        ),
      ),
    );
  }
}
