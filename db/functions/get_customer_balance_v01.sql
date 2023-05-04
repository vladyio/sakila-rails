CREATE FUNCTION get_customer_balance(p_customer_id integer, p_effective_date timestamp without time zone) RETURNS numeric
    AS $$
       --#OK, WE NEED TO CALCULATE THE CURRENT BALANCE GIVEN A CUSTOMER_ID AND A DATE
       --#THAT WE WANT THE BALANCE TO BE EFFECTIVE FOR. THE BALANCE IS:
       --#   1) RENTAL FEES FOR ALL PREVIOUS RENTALS
       --#   2) ONE DOLLAR FOR EVERY DAY THE PREVIOUS RENTALS ARE OVERDUE
       --#   3) IF A FILM IS MORE THAN RENTAL_DURATION * 2 OVERDUE, CHARGE THE REPLACEMENT_COST
       --#   4) SUBTRACT ALL PAYMENTS MADE BEFORE THE DATE SPECIFIED
DECLARE
    v_rentfees DECIMAL(5,2); --#FEES PAID TO RENT THE VIDEOS INITIALLY
    v_overfees INTEGER;      --#LATE FEES FOR PRIOR RENTALS
    v_payments DECIMAL(5,2); --#SUM OF PAYMENTS MADE PREVIOUSLY
BEGIN
    SELECT COALESCE(SUM(films.rental_rate),0) INTO v_rentfees
    FROM films, inventories, rentals
    WHERE films.id = inventories.film_id
      AND inventories.id = rentals.inventory_id
      AND rentals.rental_date <= p_effective_date
      AND rentals.customer_id = p_customer_id;

    SELECT COALESCE(SUM(CASE
                        WHEN
                          (rentals.return_date * '1 day'::interval - rentals.rental_date * '1 day'::interval) > (films.rental_duration * '1 day'::interval)
                        THEN EXTRACT(DAY FROM(
                            (rentals.return_date * '1 day'::interval - rentals.rental_date * '1 day'::interval) - (films.rental_duration * '1 day'::interval)
                          ))
                        ELSE 0
                        END), 0) INTO v_overfees
    FROM rentals, inventories, films
    WHERE films.id = inventories.film_id
      AND inventories.id = rentals.inventory_id
      AND rentals.rental_date <= p_effective_date
      AND rentals.customer_id = p_customer_id;

    SELECT COALESCE(SUM(payments.amount), 0) INTO v_payments
    FROM payments
    WHERE payments.payment_date <= p_effective_date
    AND payments.customer_id = p_customer_id;

    RETURN v_rentfees + v_overfees - v_payments;
END
$$
    LANGUAGE plpgsql;
