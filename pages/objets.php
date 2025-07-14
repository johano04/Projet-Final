<?php
session_start();
require_once 'db.php';

// Récupérer toutes les catégories
$categories = $pdo->query("SELECT * FROM categorie_objet")->fetchAll();

// Filtre
$filtre = isset($_GET['categorie']) ? $_GET['categorie'] : '';

// Requête principale
$sql = "SELECT o.*, c.nom_categorie, m.nom AS proprio,
        (SELECT date_retour FROM emprunt WHERE id_objet = o.id_objet ORDER BY id_emprunt DESC LIMIT 1) AS date_retour
        FROM objet o
        JOIN categorie_objet c ON o.id_categorie = c.id_categorie
        JOIN membre m ON o.id_membre = m.id_membre";

if ($filtre) {
    $sql .= " WHERE c.id_categorie = ?";
    $stmt = $pdo->prepare($sql);
    $stmt->execute([$filtre]);
} else {
    $stmt = $pdo->query($sql);
}
$objets = $stmt->fetchAll();
?>

<h2>Liste des objets</h2>

<form method="get">
    <label>Filtrer par catégorie :</label>
    <select name="categorie" onchange="this.form.submit()">
        <option value="">-- Toutes --</option>
        <?php foreach ($categories as $cat): ?>
            <option value="<?= $cat['id_categorie'] ?>" <?= $filtre == $cat['id_categorie'] ? 'selected' : '' ?>>
                <?= htmlspecialchars($cat['nom_categorie']) ?>
            </option>
        <?php endforeach; ?>
    </select>
</form>

<div style="display: flex; flex-wrap: wrap; gap: 10px;">
<?php foreach ($objets as $obj): ?>
    <div style="border: 1px solid #ccc; padding: 10px; width: 200px;">
        <img src="images/objet_<?= $obj['id_objet'] ?>.jpg" alt="<?= $obj['nom_objet'] ?>" width="180"><br>
        <strong><?= htmlspecialchars($obj['nom_objet']) ?></strong><br>
        Catégorie : <?= htmlspecialchars($obj['nom_categorie']) ?><br>
        Propriétaire : <?= htmlspecialchars($obj['proprio']) ?><br>
        <?php if ($obj['date_retour']): ?>
            <small style="color:red;">🔒 Emprunté jusqu’au <?= $obj['date_retour'] ?></small>
        <?php else: ?>
            <small style="color:green;">✅ Disponible</small>
        <?php endif; ?>
    </div>
<?php endforeach; ?>
</div>
