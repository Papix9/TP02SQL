use compta;
-- Pour pouvoir réaliser ce TP vous aurez besoin de désactiver le mode « safe update » qui par défaut bloque les suppressions multiples.
-- ON DELETE CASCADE

SET SQL_SAFE_UPDATES = 0;

-- a Supprimer dans la table compo toutes les lignes concernant les bons de commande d’avril 2019
DELETE C
FROM compo C
JOIN bon B ON C.ID_BON = B.ID
WHERE MONTH(B.DATE_CMDE) = 4
  AND YEAR(B.DATE_CMDE) = 2019;

-- b Supprimer dans la table bon tous les bons de commande d’avril 2019
DELETE
FROM bon
WHERE MONTH(DATE_CMDE) = 4
  AND YEAR(DATE_CMDE) = 2019;

  