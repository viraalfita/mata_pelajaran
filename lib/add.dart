import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final _formKey = GlobalKey<FormState>();

  //inisialisasi field
  var id_mapel = TextEditingController();
  var mata_pelajaran = TextEditingController();
  var guru_mapel = TextEditingController();
  Future _onSubmit() async {
    try {
      return await http.post(
        Uri.parse('http://127.0.0.1/api_rapor/create.php'),
        body: {
          "id_mapel": id_mapel.text,
          "mata_pelajaran": mata_pelajaran.text,
          "guru_mapel": guru_mapel.text,
        },
      ).then((value) {
        //print pesan setelah insert data ke database
        var data = jsonDecode(value.body);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text('Data Berhasil Disimpan'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamedAndRemoveUntil(
                                '/', (Route<dynamic> route) => false),
                        child: Text('OK'))
                  ],
                ));
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tambah Mapel',
          style: TextStyle(
              color: Colors.lightGreen.shade800, fontWeight: FontWeight.bold),
        ),
        leading: BackButton(color: Colors.lightGreen.shade800),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Text(
                'Kode Mata Pelajaran :',
                style: TextStyle(
                    color: Colors.lightGreen.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: id_mapel,
                decoration: InputDecoration(
                    hintText: 'Tuliskan Kode Mata Pelajaran',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Colors.amber.shade100,
                    filled: true),
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 16),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Wajib Diisi';
                  }
                  return null;
                },
              ),
              Text(
                'Mata Pelajaran :',
                style: TextStyle(
                    color: Colors.lightGreen.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: mata_pelajaran,
                decoration: InputDecoration(
                    hintText: 'Tuliskan Mata Pelajaran',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Colors.amber.shade100,
                    filled: true),
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Wajib Diisi';
                  }
                  return null;
                },
              ),
              Text(
                'Guru Mata Pelajaran :',
                style: TextStyle(
                    color: Colors.lightGreen.shade800,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              TextFormField(
                controller: guru_mapel,
                decoration: InputDecoration(
                    hintText: 'Tuliskan Guru Mata Pelajaran',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: Colors.amber.shade100,
                    filled: true),
                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Wajib Diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    //validasi
                    if (_formKey.currentState!.validate()) {
                      //kirim data ke database
                      _onSubmit();
                    }
                  },
                  child: const Text(
                    'Kirim',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
