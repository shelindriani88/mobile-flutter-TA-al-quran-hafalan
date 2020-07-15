<?php

    include 'conn.php';

    $username = $_POST['username'];
    $password = $_POST['password'];
    //get data db
    //https://www.youtube.com/watch?v=yIB4bEFoxyU&t=176s
    $queryResult=$connect->query("SELECT * FROM admin WHERE username='".$username."' and password='".$password."'");

    $result=array();

    while($fetchData=$queryResult->fetch_assoc()){
        $result[]=$fetchData;
    }

    echo json_encode($result);

?>