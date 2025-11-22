-- Drop view first (views depend on tables)
DROP VIEW IF EXISTS high_winrate_builds;
-- Drop junction table first (has foreign keys)
DROP TABLE IF EXISTS champion_items;
-- Drop remaining tables
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS champions;
