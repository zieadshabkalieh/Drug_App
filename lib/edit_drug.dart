import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'inherited_provider.dart';
import 'main.dart';
import 'model.dart';
class EditDrug extends StatefulWidget {
  int index;
  EditDrug(this.index);
  @override
  State<EditDrug> createState() => _EditDrugState();
}
class _EditDrugState extends State<EditDrug> {
  File? imagee;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageSelected = File(image.path);
      setState(() => this.imagee = imageSelected);
    } on PlatformException catch (e) {
      print(e);
      print("Failed to Add Photo");
    }
  }
  @override
  Widget build(BuildContext context) {
    final data = InheritedDataProvider.of(context)?.data;
    // File? image = data![widget.index].image;
    TextEditingController textController = data![widget.index].name;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70,),
            Text("Edit Drug",style: TextStyle(fontSize: 25),),
            SizedBox(height: 50,),
            imagee == null
                ? ClipOval(
              child: Image.file(
                data[widget.index].image!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            )
                : ClipOval(
              child: Image.file(
                imagee!,
                width: 160,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  child: Row(children: [
                    Icon(Icons.photo),
                    Text("Add From Gallery"),
                  ]),
                  onPressed: () {
                    pickImage(ImageSource.gallery);
                  },
                ),
                TextButton(
                  child: Row(children: [
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
                      value: data[widget.index].check1,
                      title: Text("Herbs"),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (value) {
                        setState(() {
                          data[widget.index].check1 = value!;

                        });
                      }),
                  CheckboxListTile(
                      value: data[widget.index].check2,
                      title: Text("Cortisone"),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (value) {
                        setState(() {
                          data[widget.index].check2 = value!;
                        });
                      }),
                  CheckboxListTile(
                      value: data[widget.index].check3,
                      title: Text("Aspirin"),
                      controlAffinity: ListTileControlAffinity.platform,
                      onChanged: (value) {
                        setState(() {
                          data[widget.index].check3 = value!;
                        });
                      }),
                ],
              ),
            ),
            TextButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save_outlined),
                  Text("Save"),
                ],
              ),
              onPressed: () {
                data[widget.index]=Model(textController, imagee == null ? data[widget.index].image : imagee, data[widget.index].check1, data[widget.index].check2, data[widget.index].check3);
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
    );
  }
}