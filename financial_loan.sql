CREATE DATABASE LOAN;
USE LOAN;

CREATE TABLE BANK_LOAN_DATA4(
id	INT NOT NULL,
address_state VARCHAR(30) NOT NULL,
application_type VARCHAR(30) NOT NULL,
emp_length VARCHAR(30) NOT NULL,
emp_title VARCHAR(100) NOT NULL,	
grade VARCHAR(30) NOT NULL,	
home_ownership VARCHAR(50) NOT NULL,	
issue_date varchar(20)  NOT NULL,	
last_credit_pull_date varchar(20) NOT NULL,
last_payment_date varchar(20) NOT NULL,	
loan_status VARCHAR(30) NOT NULL,	
next_payment_date varchar(20) NOT NULL,	
member_id INT NOT NULL,	
purpose VARCHAR(30) NOT NULL,
sub_grade VARCHAR(30) NOT NULL,	
term VARCHAR(30) NOT NULL,	
verification_status VARCHAR(30) NOT NULL,	
annual_income INT NOT NULL,	
dti DECIMAL(10,2) NOT NULL,
installment DECIMAL(10,2) NOT NULL,	
int_rate DECIMAL(10,4) NOT NULL,		
loan_amount	INT NOT NULL,
total_acc INT NOT NULL,
total_payment INT NOT NULL
);

SELECT * FROM BANK_LOAN_DATA4;

LOAD DATA INFILE 
'D:\financial_loan.csv'
INTO TABLE BANK_LOAN_DATA4
FIELDS terminated by ','
enclosed by '"'
LINES terminated by '\n'
ignore 1 ROWS





UPDATE bank_loan_data4
SET ISSUE_DATE = STR_TO_DATE(issue_date,'%d-%m-%Y');


#1--Total Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data4;

#2--MTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data4
WHERE MONTH(issue_date) = 12;

#3--PMTD Loan Applications
SELECT COUNT(id) AS Total_Applications FROM bank_loan_data4
WHERE MONTH(issue_date) = 11;

#4--Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data4;

#5--MTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount FROM bank_loan_data4
WHERE MONTH(issue_date) = 12;

#6--PMTD Total Funded Amount
SELECT SUM(loan_amount) AS Total_Funded_Amount1 FROM bank_loan_data4
WHERE MONTH(issue_date) = 11;

#7--Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data4;

#8--MTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data4
WHERE MONTH(issue_date) = 12;
 
#9--PMTD Total Amount Received
SELECT SUM(total_payment) AS Total_Amount_Collected FROM bank_loan_data4
WHERE MONTH(issue_date) = 11;

#10--Average Interest Rate
SELECT AVG(int_rate) AS Avg_Int_Rate FROM bank_loan_data4;
 
#11--MTD Average Interest
SELECT AVG(int_rate) AS MTD_Avg_Int_Rate FROM bank_loan_data4
WHERE MONTH(issue_date) = 12;
 
#12--PMTD Average Interest
SELECT AVG(int_rate) AS PMTD_Avg_Int_Rate FROM bank_loan_data4
WHERE MONTH(issue_date) = 11;


#13--Avg DTI
SELECT AVG(dti) AS Avg_DTI FROM bank_loan_data4;
 
#14--MTD Avg DTI
SELECT AVG(dti) AS MTD_Avg_DTI FROM bank_loan_data4
WHERE MONTH(issue_date) = 12;
 
#15--PMTD Avg DTI
SELECT AVG(dti) AS PMTD_Avg_DTI FROM bank_loan_data4
WHERE MONTH(issue_date) = 11;

 #16--Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) /
COUNT(id) AS Good_Loan_Percentage
FROM bank_loan_data4;


#17--Good Loan Applications
SELECT COUNT(id) AS Good_Loan_Applications FROM bank_loan_data4
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current' ;

#18--Good Loan Funded Amount
SELECT SUM(loan_amount) AS Good_Loan_Funded_amount FROM bank_loan_data4
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

#19--Good Loan Amount Received
SELECT SUM(total_payment) AS Good_Loan_amount_received FROM bank_loan_data4
WHERE loan_status = 'Fully Paid' OR loan_status = 'Current';

#20--Bad Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Charged Off' THEN id END) * 100.0) /
COUNT(id) AS Bad_Loan_Percentage
FROM bank_loan_data4;

#21--Bad Loan Applications
SELECT COUNT(id) AS Bad_Loan_Applications FROM bank_loan_data4
WHERE loan_status = 'Charged Off';
 
#22--Bad Loan Funded Amount
SELECT SUM(loan_amount) AS Bad_Loan_Funded_amount FROM bank_loan_data4
WHERE loan_status = 'Charged Off';
 
#23--Bad Loan Amount Received
SELECT SUM(total_payment) AS Bad_Loan_amount_received FROM bank_loan_data4
WHERE loan_status = 'Charged Off';

#24-- loan status
SELECT
        loan_status,
        COUNT(id) AS LoanCount,
        SUM(total_payment) AS Total_Amount_Received,
        SUM(loan_amount) AS Total_Funded_Amount,
        AVG(int_rate ) AS Interest_Rate,
        AVG(dti ) AS DTI
    FROM bank_loan_data4 GROUP BY loan_status;
    
  #25--Terms (Tenure)
SELECT
term AS Term,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data4
GROUP BY term
ORDER BY term;

#26--EMPLOYEE LENGTH
SELECT
emp_length AS Employee_Length,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data4
GROUP BY emp_length
ORDER BY emp_length;

#27--HOME OWNERSHIP
SELECT
home_ownership AS Home_Ownership,
COUNT(id) AS Total_Loan_Applications,
SUM(loan_amount) AS Total_Funded_Amount,
SUM(total_payment) AS Total_Amount_Received
FROM bank_loan_data4
GROUP BY home_ownership
ORDER BY home_ownership;