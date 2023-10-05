<?php 
	$connection = new mysqli('localhost','root','','rapor');

	$data = mysqli_query($connection, "select * from mata_pelajaran");
    $data = mysqli_fetch_all($data, MYSQLI_ASSOC);

    echo json_encode($data);
?>