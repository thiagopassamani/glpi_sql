/* SQL - Dashboard de atendimento do Mês */
SELECT COUNT(gt.id) AS 'News'

	,(SELECT COUNT(gt1.id)
		FROM glpi_tickets AS gt1
		WHERE gt1.is_deleted = 0		
		AND gt1.status IN(2,3,13,15)
	) AS 'In_Progress'
	
	,(SELECT COUNT(gt2.id)
		FROM glpi_tickets AS gt2
		WHERE gt2.is_deleted = 0
		AND gt2.status IN(4,14)
	) AS 'Waiting'
	
	,(SELECT COUNT(gt3.id)
		FROM glpi_tickets AS gt3
		WHERE gt3.is_deleted = 0
		AND (MONTH(gt3.date) AND YEAR(gt3.date))
		AND (MONTH(gt3.solvedate) = MONTH(NOW()) AND YEAR(gt3.solvedate) = YEAR(NOW()))		
		AND gt3.status = 5
	) AS 'Solved'
	
	,(SELECT COUNT(gt4.id)
		FROM glpi_tickets AS gt4
		WHERE gt4.is_deleted = 0
		AND (MONTH(gt4.closedate) = MONTH(NOW()) AND YEAR(gt4.closedate) = YEAR(NOW()))
		AND gt4.status = 6
	) AS 'Closed'

	FROM glpi_tickets AS gt
		
	WHERE gt.is_deleted = 0
	AND (MONTH(gt.date) = MONTH(NOW()) AND YEAR(gt.date) = YEAR(NOW()))
	AND gt.status = 1; 
