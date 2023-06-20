<?php

$search = $_POST['search'];

$servername = "aleppo-library.cmi2lvxsw6oz.eu-west-2.rds.amazonaws.com";
$username = "admin";
$password = "";
$dbname = "Aleppo";
$table = "quotes";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
// echo "Connected successfully";

$sql = "select * from quotes where title like '%$search%'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
while($row = $result->fetch_assoc() ) {
        echo "title: " . $row["title"]. " - author: " . $row["author"]. "
<br>";
  }
 } else {
   echo "0 results";
 }
$conn->close();
?>