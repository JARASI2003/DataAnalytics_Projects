use ice2024;

-- Total Seats 

SELECT DISTINCT COUNT(Parliament_Constituency) AS Total_Seats
FROM constituencywise_results;

-- What are the total numbers of seats available for elections in each state

SELECT DISTINCT COUNT(cr.Parliament_Constituency) AS Seats, 
			s.state AS State_Name
		
FROM constituencywise_results cr
JOIN statewise_results sr ON sr.Parliament_Constituency = cr.Parliament_Constituency
JOIN states s ON s.State_ID = sr.State_ID
GROUP BY s.state;

-- Total Seats Won by N.D.A Alliance

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN Won
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    partywise_results;

-- Seats Won by N.D.A Alliance Parties

SELECT Party AS Party_Name, Won AS Seats_Won
FROM partywise_results
WHERE Party IN (
		'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
)
ORDER BY Seats_Won DESC;

-- Total Seats Won by I.N.D.I.A Alliance

SELECT SUM(CASE 
		WHEN Party IN (
				'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
        ) THEN Won
        ELSE 0
END ) AS Total_Seats_Won_By_INDIA
FROM partywise_results;

-- Seats Won by I.N.D.I.A Alliance Parties

SELECT Party AS Party_Name, Won AS Seats_Won
FROM partywise_results
WHERE Party IN (
	'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
)
ORDER BY Seats_Won DESC;

-- Add New Column filed in table partywise_results to get Party Allianz as N.D.A and I.N.D.I.A and Other

SET SQL_SAFE_UPDATES = 0;

ALTER TABLE partywise_results
ADD party_alliance VARCHAR(50);

UPDATE partywise_results
SET party_alliance = 'I.N.D.I.A'
WHERE Party IN (
		 'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

UPDATE partywise_results
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);


UPDATE partywise_results
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;

-- Which party alliance won the most seats across all states ?

SELECT p.party_alliance AS Party_Alliance, COUNT(cr.Parliament_Constituency) AS Seats_Won
FROM partywise_results p
JOIN constituencywise_results cr ON cr.Party_ID = p.Party_ID
GROUP BY p.party_alliance
ORDER BY Seats_Won DESC;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency?

SELECT cr.Winning_Candidate AS Candidate_Name,
	   p.Party AS Party_Name,
       p.party_alliance AS Alliance_Name,
       cr.Total_Votes AS Total_Votes,
       cr.Margin AS Margin,
       cr.Constituency_Name AS Constituency_Name,
       s.state AS State_Name
FROM Constituencywise_results cr 
JOIN partywise_results p ON p.Party_ID = cr.Party_ID
JOIN statewise_results sr ON sr.Parliament_Constituency = cr.Parliament_Constituency
JOIN states s ON s.State_ID = sr.State_ID
WHERE  cr.Constituency_Name = 'DARJEELING';
       
-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency?

SELECT cd.Candidate AS Candidate_Name,
       cd.Party AS Party_Name,
       cd.EVM_Votes AS EVM_Votes,
       cd.Postal_Votes AS Postal_Votes,
       cd.Total_Votes AS Total_Votes,
       cr.Constituency_Name AS Constituency_Name
FROM constituencywise_details cd
JOIN constituencywise_results cr ON cr.Constituency_ID = cd.Constituency_ID
WHERE cr.Constituency_Name = 'AZAMGARH'
ORDER BY Total_Votes;
       
-- Which parties won the most seats in X State, and how many seats did each party win?

SELECT p.Party AS Party,
	   COUNT(cr.constituency_ID) AS Seats_Won
FROM partywise_results p
JOIN constituencywise_results cr ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr ON sr.Parliament_Constituency = cr.Parliament_Constituency
JOIN states s ON s.State_ID = sr.State_ID
WHERE s.state = 'Kerala'
GROUP BY p.Party
ORDER BY Seats_Won DESC;

-- What is the total number of seats won by each party alliance (NDA, I.N.D.I.A, and OTHER) in each state for the India Elections 2024

SELECT 
    s.State AS State_Name,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM 
    constituencywise_results cr
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')  -- Filter for NDA and INDIA alliances
GROUP BY 
    s.State
ORDER BY 
    s.State;

-- Which candidate received the highest number of EVM votes in each constituency (Top 10)?

SELECT 
    cr.Constituency_Name,
    cd.Constituency_ID,
    cd.Candidate,
    cd.EVM_Votes
FROM 
    constituencywise_details cd
JOIN 
    constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
WHERE 
    cd.EVM_Votes = (
        SELECT MAX(cd1.EVM_Votes)
        FROM constituencywise_details cd1
        WHERE cd1.Constituency_ID = cd.Constituency_ID
    )
ORDER BY 
    cd.EVM_Votes DESC
LIMIT 10;

-- For the state of Maharashtra, what are the total number of seats, total number of candidates, total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes?

SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM 
    constituencywise_results cr
JOIN 
    constituencywise_details cd ON cr.Constituency_ID = cd.Constituency_ID
JOIN 
    statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN 
    states s ON sr.State_ID = s.State_ID
JOIN 
    partywise_results p ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Maharashtra';
