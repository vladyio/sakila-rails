CREATE FUNCTION inventory_in_stock(p_inventory_id integer) RETURNS boolean
    AS $$
DECLARE
    v_rentals INTEGER;
    v_out     INTEGER;
BEGIN
    -- AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
    -- FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT count(*) INTO v_rentals
    FROM rentals
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rentals.id) INTO v_out
    FROM inventories LEFT JOIN rentals ON inventories.id = rentals.inventory_id
    WHERE inventories.id = p_inventory_id
    AND rentals.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END $$
    LANGUAGE plpgsql;
