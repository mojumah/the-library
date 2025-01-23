<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="table-style.css">
</head>
<body>

<?php

$search = $_POST['search'];

$servername = "localhost";
$username = "dagan";
$password = getenv('PASSWORD');
$dbname = "library";
$table = "books";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// Check connection
if ($conn->connect_error) {
  die("Connection failed: " . $conn->connect_error);
}
// echo "Connected successfully";

$sql = "select * from books where title like '%$search%'";
$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table><tr><th>Title</th><th>Author</th><th>Cover</th></tr>";
    while($row = $result->fetch_assoc() ) {
        echo "<tr><td>" . $row["title"]. "</td><td>" . $row["author"]. " </td><td><img src=" .$row["image_pathLocation"]. " </td></tr>";       
    }
    echo "</table>";


 } else {
   echo "0 results";
 }
$conn->close();
?>

    <button onclick="history.back()">Back to Search page!</button>
</body>
</html>
