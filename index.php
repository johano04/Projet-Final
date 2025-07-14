<?php
session_start();
require_once 'db.php';

if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $email = $_POST["email"];
    $mdp = $_POST["mdp"];

    $stmt = $pdo->prepare("SELECT * FROM membre WHERE email = ?");
    $stmt->execute([$email]);
    $user = $stmt->fetch();

    if ($user && password_verify($mdp, $user["mdp"])) {
        $_SESSION["user_id"] = $user["id_membre"];
        header("Location: pages/objets.php");
        exit();
    } else {
        echo "Identifiants incorrects";
    }
}
?>

<h2>Connexion</h2>
<form method="post">
    <input type="email" name="email" placeholder="Email" required><br>
    <input type="password" name="mdp" placeholder="Mot de passe" required><br>
    <button type="submit">Se connecter</button>
</form>
<a href="pages/register.php">S'inscrire</a>
