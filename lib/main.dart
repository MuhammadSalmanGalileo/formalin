import 'package:flutter/material.dart';
import 'package:http/http.dart' show get;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'Formalin';

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  final pbController = TextEditingController();
  final namaController = TextEditingController();
  final nimController = TextEditingController();
  final afiliasiController = TextEditingController();
  final kontenController = TextEditingController();

  var responseText = "Ayo formalin...";
  var result;

  void fetchData(var url) async {
    result = await get(url);
    setState((){
      responseText = result.body;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    pbController.dispose();
    namaController.dispose();
    nimController.dispose();
    afiliasiController.dispose();
    kontenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Divider(),
          Text("Pak atau Bu?"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Pak/Bu"
            ),
            controller: pbController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Tolong diisi dengan Pak/Bu';
              }
              return null;
            },
          ),
          Divider(),
          Text("Nama Pengirim Pesan :"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Muhammad Salman Galileo"
            ),
            controller: namaController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Tolong diisi dengan nama';
              }
              return null;
            },
          ),
          Divider(),
          Text("NIM Pengirim Pesan :"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "23219XXX"
            ),
            controller: nimController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Tolong diisi dengan nim';
              }
              return null;
            },
          ),
          Divider(),
          Text("Afiliasi dengan penerima pesan :"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Mahasiswa kelas ELXXXX"
            ),
            controller: afiliasiController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Tolong diisi dengan afiliasi';
              }
              return null;
            },
          ),
          Divider(),
          Text("Konten :"),
          TextFormField(
            decoration: InputDecoration(
              hintText: "Lorem Ipsum"
            ),
            controller: kontenController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Tolong diisi dengan konten pesan';
              }
              return null;
            },
          ),
          Text(responseText, textDirection: TextDirection.ltr),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false
                // otherwise.
                if (_formKey.currentState.validate()) {
                  // If the form is valid, display a Snackbar.
                  Scaffold.of(context)
                      .showSnackBar(SnackBar(content: Text("Formalin...")));
                  var url = "http://3.136.85.208/salman/formalin.php?pb=" + pbController.text + "&nama=" + namaController.text + "&nim=" + nimController.text + "&afiliasi=" + afiliasiController.text + "&konten=" + kontenController.text;
                  fetchData(url);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}