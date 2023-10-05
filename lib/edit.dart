import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Edit extends StatefulWidget {
  Edit({required this.id_mapel});

  String id_mapel;

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
  final _formKey = GlobalKey<FormState>();

  //inisialisasi field
  var id_mapel = TextEditingController();
  var mata_pelajaran = TextEditingController();
  var guru_mapel = TextEditingController();

  @override
  void initState() {
    super.initState();
    //method ini akan dieksekusi pertama kali
    _getData();
  }

  //http untuk mengambil data detail
  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          'http://127.0.0.1/api_rapor/detail.php?id_mapel="${widget.id_mapel}"'));

      //if respon sukses
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        setState(() {
          id_mapel = TextEditingController(text: data['id_mapel']);
          mata_pelajaran = TextEditingController(text: data['mata_pelajaran']);
          guru_mapel = TextEditingController(text: data['guru_mapel']);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _onUpdate(context) async {
    try {
      return await http.post(
        Uri.parse('http://127.0.0.1/api_rapor/update.php'),
        body: {
          "id_mapel": id_mapel.text,
          "mata_pelajaran": mata_pelajaran.text,
          "guru_mapel": guru_mapel.text,
        },
      ).then((value) {
        //print setelah menyimpan ke database
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

  Future _onDelete(context) async {
    try {
      return await http.post(
        Uri.parse('http://127.0.0.1/api_rapor/delete.php'),
        body: {
          'id_mapel': '"${widget.id_mapel}"',
        },
      ).then((value) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
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
          'Ubah Mapel',
          style: TextStyle(
              color: Colors.lightGreen.shade800, fontWeight: FontWeight.bold),
        ),
        leading: BackButton(color: Colors.lightGreen.shade800),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 20),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.lightGreen.shade800),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      //alert untuk hapus data
                      return AlertDialog(
                        content:
                            Text('Apakah anda yakin akan menghapus data ini?'),
                        actions: <Widget>[
                          ElevatedButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Icon(Icons.cancel)),
                          ElevatedButton(
                              onPressed: () => _onDelete(context),
                              child: Icon(Icons.check_circle))
                        ],
                      );
                    });
              },
            ),
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: Container(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
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
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
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
                          _onUpdate(context);
                        }
                      },
                      child: const Text(
                        'Kirim',
                        style: TextStyle(color: Colors.white),
                      ))
                ],
              ),
            ),
          )),
    );
  }
}
