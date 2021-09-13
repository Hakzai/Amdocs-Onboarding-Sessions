--CREATE TABLE
CREATE TABLE PRODUCTS (PROD_ID VARCHAR2(4) PRIMARY KEY, 
                       PROD_NAME VARCHAR(10), 
                       PROD_DESC VARCHAR2(20), 
                       PRICE NUMBER(8,2));

--INSERT ON TABLE
INSERT INTO PRODUCTS VALUES('EL1', 'LED TV', 'SAMSUNG', '500');
INSERT INTO PRODUCTS VALUES('EL2', 'NOTEPAD', 'HP', '800');

--SELECT
SELECT * 
FROM PRODUCTS;

--VARIABLES
DECLARE
    product_name PRODUCTS.PROD_NAME%TYPE;
BEGIN
    SELECT PROD_NAME INTO product_name
    FROM PRODUCTS
    WHERE PROD_ID = 'EL2';
    DBMS_OUTPUT.PUT_LINE('Product name is ' || product_name);
END;

DECLARE
    product_name PRODUCTS%ROWTYPE;
BEGIN
    SELECT * INTO product_name
    FROM PRODUCTS
    WHERE PROD_ID = 'EL2';
    DBMS_OUTPUT.PUT_LINE('Product name is ' || product_name.PROD_DESC || chr(10) || 'Product price is ' || product_name.PRICE);
END;

--CURSOR
DECLARE
    prod_id PRODUCTS.PROD_ID%TYPE;
    prod_name PRODUCTS.PROD_NAME%TYPE;
    prod_desc PRODUCTS.PROD_DESC%TYPE;
    prod_price PRODUCTS.PRICE%TYPE;
    CURSOR c_products IS SELECT PROD_ID, PROD_NAME 
                         FROM PRODUCTS;
BEGIN
    OPEN c_products;
    LOOP
        FETCH c_products into prod_id, prod_name;
        EXIT WHEN c_products%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Product ID is: ' || prod_id || chr(10) || 
                             'Product name is: ' || prod_name || chr(10));
    END LOOP;
    CLOSE c_products;
END;

DECLARE
    c_prod_id PRODUCTS.PROD_ID%TYPE;
    c_prod_name PRODUCTS.PROD_NAME%TYPE;
    c_prod_desc PRODUCTS.PROD_DESC%TYPE;
    c_prod_price PRODUCTS.PRICE%TYPE;
    CURSOR c_products IS SELECT * 
                         FROM PRODUCTS;
BEGIN
    OPEN c_products;
    LOOP
        FETCH c_products into c_prod_id, c_prod_name, c_prod_desc, c_prod_price;
        EXIT WHEN c_products%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Product ID is: ' || c_prod_id || chr(10) || 
                             'Product name is: ' || c_prod_name || chr(10) || 
                             'Product description is: ' || c_prod_desc || chr (10) ||
                             'Product price is: ' || c_prod_price || chr(10));
    END LOOP;
    CLOSE c_products;
END;

--PROCEDURE
CREATE OR REPLACE PROCEDURE p_insert_product
    (v_prod_id IN VARCHAR2,
     v_prod_name IN VARCHAR2,
     v_prod_desc IN VARCHAR2,
     v_price IN NUMBER)
IS BEGIN
    INSERT INTO PRODUCTS VALUES(v_prod_id,
                                v_prod_name, 
                                v_prod_desc, 
                                v_price);
   END;

BEGIN
    p_insert_product('EL3', 'X3 PRO', 'XIAOMI', 1200);
    p_insert_product('EL4', 'CAMERA', 'REDRAGON', 700);
END;

--FUNCTION
CREATE OR REPLACE FUNCTION f_get_price(v_prod_id IN VARCHAR2)
RETURN NUMBER
IS
v_prod_price NUMBER;
BEGIN
    SELECT PRICE
    INTO v_prod_price
    FROM PRODUCTS
    WHERE PROD_ID = v_prod_id;
    RETURN v_prod_price;
END;

DECLARE
    v_prod_price NUMBER;
BEGIN
    v_prod_price := f_get_price('EL1');
    DBMS_OUTPUT.PUT_LINE(v_prod_price);
END;

--TRIGGER
CREATE OR REPLACE TRIGGER t_product_insert
AFTER INSERT ON PRODUCTS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Product inserted');
END;