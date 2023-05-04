class CreateFunctionGroupConcat < ActiveRecord::Migration[7.0]
  def up
    # Source: https://github.com/fspacek/docker-postgres-sakila/blob/master/step_1.sql#L89-L109
    execute <<-SQL
      CREATE FUNCTION _group_concat(text, text) RETURNS text
          AS $_$
      SELECT CASE
        WHEN $2 IS NULL THEN $1
        WHEN $1 IS NULL THEN $2
        ELSE $1 || ', ' || $2
      END
      $_$
          LANGUAGE sql IMMUTABLE;

      CREATE AGGREGATE group_concat(text) (
          SFUNC = _group_concat,
          STYPE = text
      );
    SQL
  end

  def down
    execute <<-SQL
      DROP AGGREGATE IF EXISTS group_concat(text);
      DROP FUNCTION IF EXISTS _group_concat;
    SQL
  end
end
