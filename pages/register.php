<?php
require_once 'db.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nom = $_POST["nom"];
    $date = $_POST["date_naissance"];
    $genre = $_POST["genre"];
    $email = $_POST["email"];
    $ville = $_POST["ville"];
    $mdp = password_hash($_POST["mdp"], PASSWORD_DEFAULT);
    $image = $_FILES["image_profil"]["name"];
    move_uploaded_file($_FILES["image_profil"]["tmp_name"], "images/" . $image);

    $stmt = $pdo->prepare("INSERT INTO membre (nom, date_naissance, genre, email, ville, mdp, image_profil) VALUES (?, ?, ?, ?, ?, ?, ?)");
    $stmt->execute([$nom, $date, $genre, $email, $ville, $mdp, $image]);

    header("Location: login.php");
    exit();
}
?>

<h2>Inscription</h2>
<form method="post" enctype="multipart/form-data">
    <input type="text" name="nom" placeholder="Nom" required><br>
    <input type="date" name="date_naissance" required><br>
    <select name="genre">
        <option value="Homme">Homme</option>
        <option value="Femme">Femme</option>
        <option value="Autre">Autre</option>
    </select><br>
    <input type="email" name="email" placeholder="Email" required><br>
    <input type="text" name="ville" placeholder="Ville" required><br>
    <input type="password" name="mdp" placeholder="Mot de passe" required><br>
    <input type="file" name="image_profil" required><br>
    <button type="submit">S'inscrire</button>
</form>
