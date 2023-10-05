<?php
    $connection = new mysqli('localhost','root','','rapor');
    $id_mapel = $_POST['id_mapel'];
    $mata_pelajaran = $_POST['mata_pelajaran'];
    $guru_mapel = $_POST['guru_mapel'];

    $result = mysqli_query($connection, "UPDATE mata_pelajaran SET id_mapel='$id_mapel', mata_pelajaran='$mata_pelajaran', guru_mapel='$guru_mapel' WHERE id_mapel='$id_mapel'");


    if ($result) {
        echo json_encode([
            'msg' => 'Berhasil',
            'information' => 'Sudah Terupdate'
        ]);
    } else {
        echo json_encode([
            'msg' => 'Gagal',
            'information' => 'Belum Terupdate'
        ]);
    }
?>