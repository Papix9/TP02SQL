use compta;

-- a Listez toutes les données concernant les articles
SELECT * FROM article;

-- b. Listez uniquement les références et désignations des articles de plus de 2 euros
SELECT REF,DESIGNATION 
FROM article 
WHERE PRIX > 2;

-- c. En utilisant les opérateurs de comparaison, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
SELECT * 
FROM article 
WHERE PRIX > 2 AND PRIX <= 6.25;

-- d. En utilisant l’opérateur BETWEEN, listez tous les articles dont le prix est compris entre 2 et 6.25 euros
SELECT * 
FROM article
WHERE PRIX BETWEEN 2 AND 6.25;

-- e. Listez tous les articles, dans l’ordre des prix descendants, et dont le prix n’est pas compris entre 2 et 6.25 euros et dont le fournisseur est Française d’Imports.
SELECT article.*
FROM article
JOIN fournisseur ON article.ID_FOU = fournisseur.ID
WHERE article.PRIX NOT BETWEEN 2 AND 6.25
  AND fournisseur.NOM = 'Française d’Imports'
ORDER BY article.PRIX DESC;

-- f. En utilisant un opérateur logique, listez tous les articles dont les fournisseurs sont la Française d’imports ou Dubois et Fils
SELECT article.*
FROM article
JOIN fournisseur ON article.ID_FOU = fournisseur.ID
WHERE fournisseur.NOM = 'Française d’Imports'
  OR fournisseur.NOM = 'Dubois & Fils';

-- g. En utilisant l’opérateur IN, réalisez la même requête que précédemment
SELECT article.*
FROM article
JOIN fournisseur ON article.ID_FOU = fournisseur.ID
WHERE fournisseur.NOM IN ('Française d’Imports', 'Dubois & Fils');

-- h. En utilisant les opérateurs NOT et IN, listez tous les articles dont les fournisseurs ne sont ni Française d’Imports, ni Dubois et Fils.
SELECT article.*
FROM article
JOIN fournisseur ON article.ID_FOU = fournisseur.ID
WHERE fournisseur.NOM NOT IN ('Française d’Imports', 'Dubois & Fils');

-- i. Listez tous les bons de commande dont la date de commande est entre le 01/02/2019 et le 30/04/2019 
SELECT *
FROM BON
WHERE DATE_CMDE BETWEEN '2019-02-01' AND '2019-04-30';
