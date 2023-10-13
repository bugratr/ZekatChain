<?php
$servername = "localhost";
$username = "your_username";
$password = "your_password";
$dbname = "ZekatChain";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$sql = "SELECT * FROM Applicants";
$result = $conn->query($sql);
$output = [];

if ($result->num_rows > 0) {
    while($row = $result->fetch_assoc()) {
        $output[] = $row;
    }
} 

echo json_encode($output);

$conn->close();
?>
