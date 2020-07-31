import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import "dart:async";
import "dart:io";

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<File> _images = [];
  final picker = ImagePicker();
  
  Future<void> getImage() async {
    var pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _images.add(File(pickedFile.path));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Image Picker'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: _images.length == 0 ? Text('No image selected.') : GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
         children: _images.map((image) {
           return ListView(
             children: <Widget>[
               Container(
                 child: Image.file(
                   image,
                 ),
//                 fit: BoxFit.fill,
//                 width: screensize.width,
                 height: 120,
               ),
               FlatButton(
                   onPressed: () {
                     setState(() {
                       _images.remove(image);
                     });
                   },
                   child: Icon(
                       Icons.delete,
                     color: Colors.white,
                   ),
                 color: Colors.deepPurpleAccent,
               )
             ],
           );
         }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getImage,
        backgroundColor: Colors.deepPurple,
        tooltip: 'Add an Image',
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}



