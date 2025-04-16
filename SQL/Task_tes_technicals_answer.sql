
#1. Total Transaksi id user : 12476
SELECT  SUM(total) AS total_transactions
FROM    newtransaction_final
WHERE   user_id = 12476;



#2. Number of transaction and total transaction value per month since Jan 2020
SELECT MONTH(created_at) as month, COUNT(total) AS number_transactions, SUM(total) AS total_transactions_value
FROM newtransaction_final
WHERE YEAR(created_at) >= 2020
GROUP BY MONTH(created_at) ORDER BY MONTH(created_at) ASC;



#3 Buyers with the highest number of transactions in January 2020 and average transaction value
SELECT user_id AS ID, nama_user AS nama, SUM(total) AS total_transactions_value, AVG(total) AS average_transaction
FROM newtransaction_final
WHERE   YEAR(created_at) = 2020
        and MONTH(created_at) = 1
GROUP BY user_id, nama_user ORDER BY SUM(total) DESC
LIMIT 3;



#4 Show Big Transaction in Dec 2019 and transaction >=20 Million
SELECT      user_id AS id, nama_user AS nama, SUM(total) AS transaction
FROM        newtransaction_final
WHERE       created_at BETWEEN '2019-12-01' and '2019-12-31'
GROUP BY    user_id, nama_user
HAVING      SUM(total) >= 20000000 ORDER BY SUM(total);



#5 Best Selling Product Category in 2020
SELECT      category, SUM(quantity) AS quantity, SUM(total) AS transaction
FROM        newtransaction_final
WHERE       YEAR(created_at) = 2020
GROUP BY    category
ORDER BY    SUM(quantity) DESC
LIMIT       10;



#6 Creat and search for buyers with high value
SELECT      user_id AS id, nama_user AS nama, SUM(quantity) AS quantity, SUM(total) AS transaction
FROM        newtransaction_final
GROUP BY    user_id, nama_user
ORDER BY    SUM(total) DESC
LIMIT       10;



#7 buyers at least 10 transactions with different zip codes in each transaction, and what is the total and average value of the transactions
SELECT          user_id AS id, 
                nama_user AS nama, 
                COUNT(DISTINCT kodepos) AS total_zipcodes,
                SUM(total) AS transaction, 
                AVG(total) AS average_transaction
FROM        newtransaction_final
GROUP BY    user_id, nama_user
HAVING      COUNT(DISTINCT kodepos) >=10
ORDER BY    COUNT(DISTINCT kodepos) DESC;



#8. the users with at least 7 purchase transactions and how many purchase and sales transactions have they made?
SELECT      user_id AS id, nama_user AS nama, COUNT(total) AS total_transaction, SUM(total) AS transaction
FROM        newtransaction_final
GROUP BY    user_id, nama_user
HAVING      COUNT(total) >=7
ORDER BY    COUNT(total) DESC;



#9 the buyers With at least 8 transactions, an average quantity of items per transaction of more than 10,and the largest total transaction value
SELECT      user_id AS id, nama_user AS nama, COUNT(total) AS total_transactions, AVG(quantity) AS averaage_quantity, SUM(total) AS transaction
FROM        newtransaction_final
GROUP BY    user_id, nama_user
HAVING      total_transactions >=8
            AND averaage_quantity >10
ORDER BY    TRANSACTION DESC;



#10 the average, minimum, and maximum time it takes to settle payments per month, and how many transactions are paid each month?
SELECT      YEAR(created_at) AS year,
            MONTH(created_at) AS month,
            AVG(DATEDIFF(paid_at, created_at)) AS average_day_sattle,
            MIN(DATEDIFF(paid_at, created_at)) AS minimum_day_sattle,
            MAX(DATEDIFF(paid_at, created_at)) AS maximum_day_sattle,
            COUNT(transaction) AS transaction_paid
FROM        newtransaction_final
GROUP BY    YEAR(created_at), MONTH(created_at)
ORDER BY    YEAR(created_at), MONTH(created_at)


