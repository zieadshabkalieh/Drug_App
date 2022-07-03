import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'inherited_provider.dart';
import 'main.dart';
import 'model.dart';
class AddDrug extends StatefulWidget {
  @override
  _AddDrugState createState() => _AddDrugState();
}
class _AddDrugState extends State<AddDrug> {
  final textController = TextEditingController();
  File? image;
  bool _check1 = false;
  bool _check2 = false;
  bool _check3 = false;
  @override
  void initState() {
    super.initState();
    textController.addListener(_updateValue);
  }
  _updateValue() {
    print("Second text field: ${textController.text}");
  }
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageSelected = File(image.path);
      setState(() => this.image = imageSelected);
    } on PlatformException catch (e) {
      print(e);
      print("Failed to Add Photo");
    }
  }
  @override
  Widget build(BuildContext context) {
    final data = InheritedDataProvider.of(context)?.data;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Text(
                "Add Drug",
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(
                height: 50,
              ),
              image != null
                  ? ClipOval(
                      child: Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.add_photo_alternate, size: 160),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Row(children: const [
                      Icon(Icons.photo),
                      Text("Add From Gallery"),
                    ]),
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                  ),
                  TextButton(
                    child: Row(children: const [
                      Icon(Icons.photo_camera),
                      Text("Take Picture"),
                    ]),
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(right: 30, left: 30),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(hintText: "Drug Name"),
                      controller: textController,
                    ),
                    CheckboxListTile(
                        value: _check1,
                        title: Text("Herbs"),
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (value) {
                          setState(() {
                            _check1 = value!;
                          });
                        }),
                    CheckboxListTile(
                        value: _check2,
                        title: Text("Cortisone"),
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (value) {
                          setState(() {
                            _check2 = value!;
                          });
                        }),
                    CheckboxListTile(
                        value: _check3,
                        title: Text("Aspirin"),
                        controlAffinity: ListTileControlAffinity.platform,
                        onChanged: (value) {
                          setState(() {
                            _check3 = value!;
                          });
                        }),
                  ],
                ),
              ),
              TextButton(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.save_outlined),
                    Text("Save"),
                  ],
                ),
                onPressed: () {
                  data!.add(
                      Model(textController, image!, _check1, _check2, _check3));
                  print("raised button : ${data[0].check1}");
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => InheritedDataProvider(
                              child: DrugHome(),
                              data: data,
                            )),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
