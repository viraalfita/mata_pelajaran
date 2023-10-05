<?php
    $connection = new mysqli('localhost','root','','rapor');

    $id = $_POST['id'];
    $nama = $_POST['nama'];
    $kelas = $_POST['kelas'];

    $result = mysqli_query($connection, "insert into mata_pelajaran set id='$id', nama='$nama', kelas='$kelas'");

    if ($result) {
        echo json_encode([
            'msg' => 'Berhasil',
            'information' => 'Sudah Tersimpan'
        ]);
    } else {
        echo json_encode([
            'msg' => 'Gagal',
            'information' => 'Belum Tersimpan'
        ]);
    }


?>