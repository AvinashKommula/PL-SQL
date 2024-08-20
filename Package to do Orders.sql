CREATE TABLE orders (
    order_id          NUMBER PRIMARY KEY,
    customer_id       NUMBER NOT NULL,
    order_date        DATE DEFAULT SYSDATE,
    payment_status    VARCHAR2(20),
    total_amount      NUMBER
);

CREATE TABLE order_items (
    order_item_id  NUMBER PRIMARY KEY,
    order_id       NUMBER REFERENCES orders(order_id),
    product_id     NUMBER,
    quantity       NUMBER,
    price          NUMBER
);
CREATE TABLE inventory (
    product_id   NUMBER PRIMARY KEY,
    product_name VARCHAR2(100),
    quantity     NUMBER,
    price        NUMBER
);
-----------------------------------
INSERT INTO orders (order_id, customer_id, payment_status, total_amount)
VALUES (1001, 101, 'PENDING', 250.00);

INSERT INTO orders (order_id, customer_id, payment_status, total_amount)
VALUES (1002, 102, 'PENDING', 150.00);

-- ----------------------------------
INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price)
VALUES (1, 1001, 201, 2, 50.00);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price)
VALUES (2, 1001, 202, 3, 100.00);

INSERT INTO order_items (order_item_id, order_id, product_id, quantity, price)
VALUES (3, 1002, 203, 1, 150.00);

-- ------------------------------------------------------------
INSERT INTO inventory (product_id, product_name, quantity, price)
VALUES (201, 'Product A', 10, 50.00);

INSERT INTO inventory (product_id, product_name, quantity, price)
VALUES (202, 'Product B', 15, 100.00);

INSERT INTO inventory (product_id, product_name, quantity, price)
VALUES (203, 'Product C', 20, 150.00);
--------------------------------------------------

CREATE OR REPLACE PACKAGE E_COMMERCE AS

PROCEDURE Validate_Order(p_order_id NUMBER); 
PROCEDURE PROCESS_PAYMENT(p_order_id NUMBER);
PROCEDURE UPDATE_INVENTORY(p_order_id NUMBER);
PROCEDURE Generate_Confirmation(p_order_id NUMBER);

END E_COMMERCE;

CREATE OR REPLACE PACKAGE BODY E_COMMERCE AS

    PROCEDURE Validate_Order(p_order_id NUMBER) IS
        v_customer_id NUMBER;
    BEGIN
        -- Check if the order exists
        SELECT customer_id
        INTO v_customer_id
        FROM orders
        WHERE order_id = p_order_id;
        
        DBMS_OUTPUT.PUT_LINE('Order validated successfully for Customer ID: ' || v_customer_id);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('Order does not exist.');
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
    END Validate_Order;

    PROCEDURE Process_Payment(p_order_id NUMBER) IS
        v_total_amount NUMBER; 
    BEGIN
        -- Calculate the total amount based on order_items and inventory prices
        SELECT SUM(oi.quantity * inv.price)
        INTO v_total_amount
        FROM order_items oi
        JOIN inventory inv ON oi.product_id = inv.product_id
        WHERE oi.order_id = p_order_id;
        
        -- Update the total amount and payment status in the orders table
        UPDATE orders
        SET total_amount = v_total_amount,
            payment_status = 'SUCCESSFUL'
        WHERE order_id = p_order_id;
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Payment processed successfully for Order ID ' || p_order_id || '. Total Amount: ' || v_total_amount);
    EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
    END Process_Payment;

    PROCEDURE Update_Inventory(p_order_id NUMBER) IS
    BEGIN
        -- Update inventory based on the order
        UPDATE inventory inv
        SET quantity = quantity - (
            SELECT SUM(oi.quantity)
            FROM order_items oi
            WHERE oi.product_id = inv.product_id AND oi.order_id = p_order_id
        )
        WHERE product_id IN (SELECT product_id FROM order_items WHERE order_id = p_order_id);
        
        COMMIT;
        
        DBMS_OUTPUT.PUT_LINE('Inventory updated successfully for Order ID ' || p_order_id);
    EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
    END Update_Inventory;

    PROCEDURE Generate_Confirmation(p_order_id NUMBER) IS
    BEGIN
        -- Logic to generate and send order confirmation (simplified)
        DBMS_OUTPUT.PUT_LINE('Order confirmation generated for Order ID: ' || p_order_id);
    EXCEPTION
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Error occurred: ' || SQLERRM);
    END Generate_Confirmation;

END E_COMMERCE;

-- To Test
BEGIN
    -- Process order with order_id = 1001
    E_COMMERCE.validate_order(1001);
    E_COMMERCE.process_payment(1001);
    E_COMMERCE.update_inventory(1001);
    E_COMMERCE.generate_confirmation(1001);
END;


