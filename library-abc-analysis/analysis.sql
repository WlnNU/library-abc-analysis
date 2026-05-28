WITH reader_loans AS (
    SELECT
        r.id,
        r.name,
        COUNT(l.id) AS loan_count
    FROM readers r
    LEFT JOIN loans l ON r.id = l.reader_id
    GROUP BY r.id, r.name
),
loans_ranked AS (
    SELECT
        id,
        name,
        loan_count,
        SUM(loan_count) OVER ()                          AS total_loans,
        SUM(loan_count) OVER (ORDER BY loan_count DESC)  AS cumulative_loans
    FROM reader_loans
)
SELECT
    name,
    loan_count,
    ROUND(cumulative_loans * 1.0 / total_loans * 100, 2) AS cumulative_percent,
    CASE
        WHEN cumulative_loans * 1.0 / total_loans <= 0.8  THEN 'A'
        WHEN cumulative_loans * 1.0 / total_loans <= 0.95 THEN 'B'
        ELSE 'C'
    END AS abc_category
FROM loans_ranked
ORDER BY loan_count DESC;
