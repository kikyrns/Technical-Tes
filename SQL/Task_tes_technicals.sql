
CREATE TEMPORARY TABLE newtransaction1 AS
SELECT 
    order_details.order_detail_id,
    order_details.product_id,
    order_details.price,
    order_details.quantity,
    orders.*

FROM order_details

JOIN orders ON order_details.order_id = orders.order_id;


CREATE TEMPORARY TABLE newtransaction2 AS
SELECT 
    products.desc_product,
    products.category,
    products.base_price,
    newtransaction1.*

FROM products

JOIN newtransaction1 ON products.product_id = newtransaction1.product_id;


CREATE TEMPORARY TABLE newtransaction_final AS
SELECT 
    users.user_id,
    users.nama_user,
    users.email,
    newtransaction2.quantity * newtransaction2.price AS transaction,
    newtransaction2.*

FROM users

JOIN newtransaction2 ON users.user_id = newtransaction2.buyer_id;

DELETE FROM newtransaction_final
WHERE paid_at = 'NA' OR paid_at IS NULL;

DELETE FROM newtransaction_final
WHERE delivery_at = 'NA' OR delivery_at IS NULL;

ALTER TABLE newtransaction_final
MODIFY COLUMN paid_at DATE;

ALTER TABLE newtransaction_final
MODIFY COLUMN delivery_at DATE;



