use compta;
-- Pour pouvoir réaliser ce TP vous aurez besoin de désactiver le mode « safe update » qui par défaut bloque les modifications de masse
-- ON UPDATE CASCADE


SET SQL_SAFE_UPDATES = 0;

-- a. Mettez en minuscules la désignation de l’article dont l’identifiant est 2
UPDATE article
SET DESIGNATION = LOWER(DESIGNATION)
WHERE ID = 2;

-- b. Mettez en majuscules les désignations de tous les articles dont le prix est strictement supérieur à 10€
UPDATE article
SET DESIGNATION = UPPER(DESIGNATION)
WHERE PRIX > 10;

-- c. Baissez de 10% le prix de tous les articles qui n’ont pas fait l’objet d’une commande.
-- ajout en premier lieu d'un article qui n'a pas fait l'objet d'une commande
-- INSERT INTO article (
-- id, REF, DESIGNATION, PRIX, ID_FOU)
--  VALUES ('11', 'G01', 'Un objet en bois', '10', 2); -- qui passera a un prix de '9' apres la requete suivante
 
UPDATE article
SET PRIX = PRIX * 0.90
WHERE ID NOT IN (SELECT ID_ART FROM compo);

-- d. Une erreur s’est glissée dans les commandes concernant Française d’imports. Les chiffres en base ne sont pas bons. Il faut doubler les quantités de tous les articles commandés à cette société.
UPDATE compo C
JOIN bon B ON C.ID_BON = B.ID
JOIN fournisseur F ON B.ID_FOU = F.ID
SET C.QTE = C.QTE * 2
WHERE F.NOM = 'Française d’Imports';

-- e. Mettez au point une requête update qui permette de supprimer les éléments entre parenthèses dans les désignations. Il vous faudra utiliser des fonctions comme substring et position
UPDATE article
SET DESIGNATION = TRIM(
    SUBSTR(DESIGNATION, 1, POSITION('(' IN DESIGNATION) - 1)
)
WHERE DESIGNATION LIKE '%(%';
