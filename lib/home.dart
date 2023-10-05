import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:rapor_siswa/add.dart';
import 'package:rapor_siswa/edit.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  //membuat variable untuk mengakomodasi semua data dari database
  List _get = [];

  //membuat warna yang berbeda untuk setiap card
  final _lightColors = [
    Colors.amber.shade300,
    Colors.lightGreen.shade300,
    Colors.lightBlue.shade300,
    Colors.orange.shade300,
    Colors.pinkAccent.shade100,
    Colors.tealAccent.shade100
  ];

  @override
  void initState() {
    super.initState();
    //method akan dieksekusi pertama kali
    _getData();
  }

  Future _getData() async {
    try {
      final response = await http.get(Uri.parse(
          //harus menggunakan ip host device masing2
          'http://127.0.0.1/api_rapor/list.php'));

      //jika berhasil ter respon
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        //masukkan data untuk variabel list _get

        setState(() {
          _get = data;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mata Pelajaran',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.lightGreen.shade900),
        ),
        leading: const Icon(
          Icons.school,
          color: Colors.black,
        ),
      ),
      //if tidak sama dengan 0, maka tampilkan data
      //else tampilkan pesan "data tidak tersedia"
      body: _get.length != 0
          //menggunakan mansory grid untuk membuat mansory card style
          ? MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: _get.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Edit(
                                  id_mapel: _get[index]['id_mapel'],
                                )));
                  },
                  child: Card(
                    //membuat warna random untuk setiap card
                    color: _lightColors[index % _lightColors.length],
                    child: Container(
                      //buat 2 tinggi yang berbeda
                      constraints:
                          BoxConstraints(minHeight: (index % 2 + 1) * 85),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${_get[index]['id_mapel']}',
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_get[index]['mata_pelajaran']}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '${_get[index]['guru_mapel']}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })
          : Center(
              child: Text(
                'Tidak ada data yang tersedia',
                style: TextStyle(
                    color: Colors.lightGreen.shade700,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Add()));
        },
      ),
    );
  }
}
