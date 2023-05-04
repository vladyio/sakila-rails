CREATE FUNCTION inventory_held_by_customer(p_inventory_id integer) RETURNS integer
    AS $$
DECLARE
    v_customer_id INTEGER;
BEGIN

  SELECT customer_id INTO v_customer_id
  FROM rentals
  WHERE return_date IS NULL
  AND inventory_id = p_inventory_id;

  RETURN v_customer_id;
END $$
    LANGUAGE plpgsql;
