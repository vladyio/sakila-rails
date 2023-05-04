CREATE FUNCTION _group_concat(text, text) RETURNS text
AS $_$
SELECT CASE
  WHEN $2 IS NULL THEN $1
  WHEN $1 IS NULL THEN $2
  ELSE $1 || ', ' || $2
END
$_$ LANGUAGE sql IMMUTABLE;

CREATE AGGREGATE group_concat(text) (
  SFUNC = _group_concat,
  STYPE = text
);
