import 'package:flutter/material.dart';
import 'add_drug.dart';
import 'inherited_provider.dart';
import 'list_viewer.dart';
void main() {
  runApp(MaterialApp(
    home: DrugHome(),
  ));
}
class DrugHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedDataProvider
        .of(context)
        ?.data;
    return MaterialApp(
        home: Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 70,
              ),
              Text(
                "Drugs",
                style: TextStyle(fontSize: 30),
              ),
              ListViewer(),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        InheritedDataProvider(
                          child: AddDrug(), data: data == null ? [] : data,)),
              );
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}