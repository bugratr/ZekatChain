<?php
$servername = "localhost";
$username = "your_username";
$password = "your_password";
$dbname = "ZekatChain";

// Veritabanı bağlantısı oluştur
$conn = new mysqli($servername, $username, $password, $dbname);

// Bağlantı kontrolü
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

$name = $_POST["name"];
$tc = $_POST["tc"];
$email = $_POST["email"];
$phone = $_POST["phone"];

$target_dir = "uploads/";
$target_file = $target_dir . basename($_FILES["document"]["name"]);

if(move_uploaded_file($_FILES["document"]["tmp_name"], $target_file)) {
    $sql = "INSERT INTO Applicants (name, tc_kimlik, email, phone, document_path)
    VALUES ('$name', '$tc', '$email', '$phone', '$target_file')";

    if ($conn->query($sql) === TRUE) {
        echo "Başvuru başarıyla kaydedildi!";
    } else {
        echo "Error: " . $sql . "<br>" . $conn->error;
    }
} else {
    echo "Dosya yükleme hatası!";
}

$conn->close();
?>
