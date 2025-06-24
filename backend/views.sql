CREATE OR REPLACE VIEW itemsview AS
SELECT 
    items.*, 
    categories.*, 
    ROUND((item_price - (item_price * item_discount / 100)), 2) AS item_final_price,
    COALESCE(AVG(rating.rating_stars), 0) AS item_avg_rating
FROM items 
INNER JOIN categories ON items.item_cat = categories.category_id
LEFT JOIN rating ON items.item_id = rating.rating_itemid
GROUP BY 
    items.item_id, 
    categories.category_id

CREATE OR REPLACE VIEW favourite AS
SELECT favourites.*, itemsview.* FROM favourites
INNER JOIN user ON favourites.favourite_userid = user.user_id
INNER JOIN itemsview ON favourites.favourite_itemid = itemsview.item_id

CREATE OR REPLACE VIEW cartview AS
SELECT cart.*,items.*, ROUND((item_price - (item_price * item_discount / 100)), 3) AS item_final_price, categories.category_name,categories.category_name_ar,categories.category_name_es,SUM((item_price - (item_price * item_discount / 100))) AS totalprice,COUNT(cart.cart_itemid) AS countitems 
FROM cart 
INNER JOIN items ON items.item_id = cart.cart_itemid
INNER JOIN categories ON items.item_cat = categories.category_id
WHERE cart_orderid = 0
GROUP BY cart.cart_userid, cart.cart_itemid

CREATE OR REPLACE VIEW ordersview AS
SELECT cart.*,items.*, ROUND((item_price - (item_price * item_discount / 100)), 3) AS item_final_price, categories.category_name,categories.category_name_ar,categories.category_name_es,address.*, SUM((item_price - (item_price * item_discount / 100))) AS totalprice,COUNT(cart.cart_itemid) AS countitems 
FROM cart 
INNER JOIN items ON items.item_id = cart.cart_itemid
INNER JOIN categories ON items.item_cat = categories.category_id
INNER JOIN address ON address.address_userid = cart.cart_userid
WHERE cart_orderid != 0
GROUP BY cart.cart_userid, cart.cart_itemid, cart.cart_orderid