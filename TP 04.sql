use compta;

-- a. Listez les articDESIGNATIONles dans l’ordre alphabétique des désignations
SELECT *
FROM article
ORDER BY DESIGNATION ASC;

-- b. Listez les articles dans l’ordre des prix du plus élevé au moins élevé
SELECT *
FROM article
ORDER BY PRIX DESC;

-- c. Listez tous les articles qui sont des « boulons » et triez les résultats par ordre de prix ascendant
SELECT *
FROM article
WHERE DESIGNATION LIKE '%boulon%'
ORDER BY PRIX ASC;

-- d. Listez tous les articles dont la désignation contient le mot « sachet ».
SELECT *
FROM article
WHERE DESIGNATION LIKE '%sachet%';

-- e. Listez tous les articles dont la désignation contient le mot « sachet » indépendamment de la casse !
SELECT *
FROM article
WHERE LOWER(DESIGNATION) LIKE '%sachet%';

-- f. Listez les articles avec les informations fournisseur correspondantes.
--  Les résultats doivent être triées dans l’ordre alphabétique des fournisseurs et
--  par article du prix le plus élevé au moins élevé.
SELECT A.*, F.NOM
FROM article A
JOIN fournisseur F ON A.ID_FOU = F.ID
ORDER BY F.NOM ASC, A.PRIX DESC;


-- g. Listez les articles de la société « Dubois & Fils »
SELECT A.*
FROM article A
JOIN fournisseur F ON A.ID_FOU = F.ID
WHERE F.NOM = 'Dubois & Fils';

-- h. Calculez la moyenne des prix des articles de la société « Dubois & Fils »
SELECT AVG(A.PRIX) AS moyenne_prix
FROM article A
JOIN FOURNISSEUR F ON A.ID_FOU = F.ID
WHERE F.NOM = 'Dubois & Fils';

-- i. Calculez la moyenne des prix des articles de chaque fournisseur
SELECT F.NOM, AVG(A.PRIX) AS moyenne_prix
FROM article A
JOIN fournisseur F ON A.ID_FOU = F.ID
GROUP BY F.NOM;

-- j. Sélectionnez tous les bons de commandes émis entre le 01/03/2019 et le 05/04/2019 à 12h00.
SELECT *
FROM bon
WHERE DATE_CMDE BETWEEN '2019-03-01' AND '2019-04-05 12:00:00';

-- k. Sélectionnez les divers bons de commande qui contiennent des boulons
SELECT DISTINCT B.*
FROM bon B
JOIN compo C ON B.ID = C.ID_BON
JOIN article A ON A.ID = C.ID_ART
WHERE A.DESIGNATION LIKE '%boulon%';

-- l. Sélectionnez les divers bons de commande qui contiennent des boulons avec le nom du fournisseur associé.
SELECT DISTINCT B.*, F.NOM AS fournisseur
FROM bon B
JOIN fournisseur F ON B.ID_FOU = F.ID
JOIN compo C ON B.ID = C.ID_BON
JOIN article A ON A.ID = C.ID_ART
WHERE A.DESIGNATION LIKE '%boulon%';

-- m. Calculez le prix total de chaque bon de commande
SELECT B.ID AS bon,
       SUM(C.QTE * A.PRIX) AS total
FROM bon B
JOIN compo C ON B.ID = C.ID_BON
JOIN article A ON A.ID = C.ID_ART
GROUP BY B.ID;

-- n. Comptez le nombre d’articles de chaque bon de commande
SELECT B.ID AS bon,
       SUM(C.QTE) AS total_articles
FROM bon B
JOIN compo C ON B.ID = C.ID_BON
GROUP BY B.ID;

-- o. Affichez les numéros de bons de commande qui contiennent plus de 25 articles et affichez le nombre d’articles de chacun de ces bons de commande
SELECT B.ID AS bon,
       SUM(C.QTE) AS total_articles
FROM bon B
JOIN compo C ON B.ID = C.ID_BON
GROUP BY B.ID
HAVING SUM(C.QTE) > 25;

-- p. Calculez le coût total des commandes effectuées sur le mois d’avril
SELECT SUM(C.QTE * A.PRIX) AS cout_total_avril
FROM bon B
JOIN compo C ON B.ID = C.ID_BON
JOIN article A ON A.ID = C.ID_ART
WHERE MONTH(B.DATE_CMDE) = 4;

--           3) Requêtes plus difficiles (facultatives) :
-- a. Sélectionnez les articles qui ont une désignation identique mais des fournisseurs différents (indice : réaliser une auto-jointure i.e. de la table avec elle-même)
SELECT A1.ID, A1.DESIGNATION, A1.ID_FOU AS fournisseur1,
       A2.ID AS autre_article, A2.ID_FOU AS fournisseur2
FROM article A1
JOIN article A2 ON A1.DESIGNATION = A2.DESIGNATION
               AND A1.ID_FOU <> A2.ID_FOU;

-- b. Calculez les dépenses en commandes mois par mois (indice : utilisation des fonctions MONTH et YEAR)
SELECT YEAR(B.DATE_CMDE) AS annee,
       MONTH(B.DATE_CMDE) AS mois,
       SUM(C.QTE * A.PRIX) AS total_depenses
FROM bon B
JOIN compo C ON B.ID = C.ID_BON
JOIN article A ON A.ID = C.ID_ART
GROUP BY YEAR(B.DATE_CMDE), MONTH(B.DATE_CMDE)
ORDER BY annee, mois;

-- c. Sélectionnez les bons de commandes sans article (indice : utilisation de EXISTS)
SELECT B.*
FROM bon B
WHERE NOT EXISTS (
    SELECT 1
    FROM compo C
    WHERE C.ID_BON = B.ID
);

-- d. Calculez le prix moyen des bons de commande par fournisseur.
SELECT F.NOM,
       AVG(total_bon) AS prix_moyen_par_bon
FROM (
    SELECT B.ID_FOU, SUM(C.QTE * A.PRIX) AS total_bon
    FROM bon B
    JOIN compo C ON B.ID = C.ID_BON
    JOIN article A ON A.ID = C.ID_ART
    GROUP BY B.ID
) AS totals
JOIN fournisseur F ON F.ID = totals.ID_FOU
GROUP BY F.NOM;
