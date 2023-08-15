-- Exemplo de Cross Aplly
WITH    q (id, prodname) AS
(
SELECT  1, 'X'
UNION ALL
SELECT  1, 'Y'
UNION ALL
SELECT  1, 'Z'
UNION ALL
SELECT  2, 'A'
UNION ALL
SELECT  2, 'B'
UNION ALL
SELECT  2, 'C'
)

SELECT  *
FROM    (
SELECT  DISTINCT id
FROM    q
) qo
CROSS APPLY
(
SELECT  CASE ROW_NUMBER() OVER(ORDER BY prodname) WHEN 1 THEN '' ELSE ', ' END + qi.prodname
FROM    q qi
WHERE   qi.id = qo.id
ORDER BY
prodname
FOR XML PATH ('')
) qi(r);