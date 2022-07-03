import 'package:flutter/material.dart';
import 'edit_drug.dart';
import 'inherited_provider.dart';
class ListViewer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedDataProvider.of(context)?.data;
    return Expanded(
      child: ListView.builder(
          itemCount: data != null ? data.length : 0,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
              key: UniqueKey(),
              background: Container(color: Colors.red,
              child: Icon(Icons.delete_forever,size: 40,color: Colors.white,),
                alignment: Alignment.centerRight,),
              // onDismissed: data.removeAt(index),
              child: Card(
                elevation: 5.0,
                child: ListTile(
                    trailing: Text(data![index].name.text),
                    leading: Image.file(data[index].image!),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditDrug(index)));
                    }),
                color: Colors.white70,
              ),
            );
          }),
    );
  }
}
