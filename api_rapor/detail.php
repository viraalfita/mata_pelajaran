<?php
    $connection = new mysqli("localhost","root","","rapor");
    $data = mysqli_query($connection, "select * from mata_pelajaran where id_mapel=".$_GET['id_mapel']);
    $data = mysqli_fetch_array($data, MYSQLI_ASSOC);

    echo json_encode($data);
?>            