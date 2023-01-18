import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class viewProduct extends StatefulWidget {
  final list;
  const viewProduct({super.key, this.list});

  @override
  State<viewProduct> createState() => _viewProductState();
}

class _viewProductState extends State<viewProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text('product view'),
      ),
      body: Container(
        child: Column(
          children: [
            Column(
              children: [
                Center(
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    height: 310,
                    width: 310,
                    child: Image.network("${widget.list["image"]}",
                        fit: BoxFit.contain),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(" Name:"),
                    Text("${widget.list["flavorName"]}"),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(" Size: "),
                    Text("${widget.list["size"]}"),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(" price:"),
                    Text("${widget.list["cost"]}"),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
