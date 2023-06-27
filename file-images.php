<?php

$search = $_POST['search'];

$servername = "";
$username = "";
$password = "";
$dbname = "Aleppo";
$table = "";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
// echo "Connected successfully";

$sql = "select * from images";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
while($row = $result->fetch_assoc() ) {
        echo "title: " . $row["title"]. " - author: " . $row["author"]. " <img src=" .$row["image_pathLocation"]. "
<br>
<br>
<br>";
        
  }

 } else {
   echo "0 results";
 }
$conn->close();
?>