<?php
    $connection = new mysqli('localhost','root','','rapor');
    $id_mapel = $_POST['id_mapel'];

    $result = mysqli_query($connection, "delete from mata_pelajaran where id_mapel=".$id_mapel);

    if ($result) {
        echo json_encode([
            'msg' => 'Berhasil',
            'information' => 'Sudah Terhapus'
        ]);
    } else {
        echo json_encode([
            'msg' => 'Gagal',
            'information' => 'Belum Terhapus'
        ]);
    }
?>