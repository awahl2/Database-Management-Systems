-- Query #1: 
/*
 -- Gets all champions sorted by win rate (descending) and by ban rate (ascending)
 -- This identifies the strongest champions that are not heavily banned.
 -- This is most useful for players who want to pick strong champions that will likely not be banned.
 */
SELECT name,
    primary_role,
    win_rate,
    ban_rate
FROM champions
ORDER BY win_rate DESC,
    ban_rate ASC
LIMIT 20;
-- Query #2:
/*
 -- Calculates the total cost of a full item build for the champion 'bard'.
 -- Also calculates the required gold per minute (GPM) to afford this build by 27 and 30 minutes.
 -- This helps players understand the economic requirements for building items on Bard.
 */
SELECT c.name AS champion_name,
    c.primary_role,
    (
        core_items.core_cost + situational_items.situational_cost
    ) AS total_build_cost,
    ROUND(
        (
            core_items.core_cost + situational_items.situational_cost
        ) / 27.5,
        2
    ) AS required_gpm_27min,
    ROUND(
        (
            core_items.core_cost + situational_items.situational_cost
        ) / 30,
        2
    ) AS required_gpm_30min
FROM champions c
    INNER JOIN (
        SELECT ci.champion_id,
            SUM(i.cost) AS core_cost
        FROM champion_items ci
            INNER JOIN items i ON ci.item_id = i.item_id
        WHERE ci.priority_order BETWEEN 0 AND 3
        GROUP BY ci.champion_id
    ) AS core_items ON c.champion_id = core_items.champion_id
    INNER JOIN (
        SELECT ci.champion_id,
            SUM(i.cost) AS situational_cost
        FROM champion_items ci
            INNER JOIN items i ON ci.item_id = i.item_id
            INNER JOIN (
                SELECT champion_id,
                    priority_order,
                    MAX(win_rate_with_item) AS max_wr
                FROM champion_items
                WHERE priority_order BETWEEN 4 AND 6
                GROUP BY champion_id,
                    priority_order
            ) AS best_items ON ci.champion_id = best_items.champion_id
            AND ci.priority_order = best_items.priority_order
            AND ci.win_rate_with_item = best_items.max_wr
        GROUP BY ci.champion_id
    ) AS situational_items ON c.champion_id = situational_items.champion_id
WHERE c.name = 'bard';
-- Query #3:
/*
 -- Lists the top 15 jungle champions by win rate, along with an abbreviation of their role using the MID function.
 */
SELECT name,
    primary_role,
    MID(primary_role, 1, 3) AS role_abbr,
    win_rate
FROM champions
WHERE primary_role = 'jungle'
ORDER BY win_rate DESC
LIMIT 15;
-- Query #4:
/*
 -- Groups items by class and calculates the average, minumum, and maximum cost for each class.
 -- Useful for newer players to understand the cost distribution of different item classes.
 */
SELECT class,
    COUNT(*) AS item_count,
    ROUND(AVG(cost), 2) AS avg_cost,
    MIN(cost) AS min_cost,
    MAX(cost) AS max_cost
FROM items
GROUP BY class
HAVING item_count >= 3
ORDER BY avg_cost DESC;
-- Query #5:
/*
 -- Retrieves all items used by the champion 'ahri', along with their cost, priority order, and win rate when used by her.
 -- This helps players understand which items synergize best with Ahri.
 */
SELECT c.name AS champion_name,
    c.primary_role,
    i.name AS item_name,
    i.cost,
    ci.priority_order,
    ci.win_rate_with_item
FROM champions c
    INNER JOIN champion_items ci ON c.champion_id = ci.champion_id
    INNER JOIN items i ON ci.item_id = i.item_id
WHERE c.name = 'ahri'
ORDER BY ci.priority_order;
-- Query #6:
/*
 -- Lists champions that do not have any associated builds in the champion_items table.
 -- Helpful for later table population.
 */
SELECT c.champion_id,
    c.name,
    c.primary_role,
    c.win_rate
FROM champions c
    LEFT JOIN champion_items ci ON c.champion_id = ci.champion_id
WHERE ci.champion_item_id IS NULL
ORDER BY c.name
LIMIT 20;
-- Query #7:
/*
 -- Updates the win rate and pick rate for the champion 'jinx'.
 -- This reflects recent performance changes in the game meta.
 */
UPDATE champions
SET win_rate = 53.45,
    pick_rate = 13.21
WHERE name = 'jinx';
-- Query #8:
/*
 -- Deletes all items from the items table that have a cost less than 200.
 */
DELETE FROM items
WHERE cost < 200;
-- Verify deletion by checking remaining item count
SELECT COUNT(*) AS remaining_items
FROM items;
-- Query #9:
/*
 -- Creates a view that shows champions with high win rates when using specific items.
 -- This view includes the champion name, primary role, item name, item cost, priority order, and win rate with the item.
 -- The view filters for builds with a win rate greater than 53.00%.
 */
CREATE VIEW high_winrate_builds AS
SELECT c.name AS champion_name,
    c.primary_role,
    i.name AS item_name,
    i.cost,
    ci.priority_order,
    ci.win_rate_with_item
FROM champions c
    INNER JOIN champion_items ci ON c.champion_id = ci.champion_id
    INNER JOIN items i ON ci.item_id = i.item_id
WHERE ci.win_rate_with_item > 53.00;
-- Query the view
SELECT *
FROM high_winrate_builds
ORDER BY win_rate_with_item DESC
LIMIT 10;
-- Query #10:
/*
 -- Transaction that reduces the cost of all 'Legendary' class items by 10% if their cost is below 3000.
 -- After the update, it selects a few items to verify the changes. If satisfied, the transaction is committed; otherwise, it can be rolled back.
 */
START TRANSACTION;
-- Reduce cost of items by 10%
UPDATE items
SET cost = cost * 0.9
WHERE class = 'Legendary'
    AND cost < 3000;
-- Check if updates look correct
SELECT name,
    cost,
    class
FROM items
WHERE class = 'Legendary'
    AND cost < 3000
LIMIT 5;
-- If satisfied with changes, COMMIT; otherwise ROLLBACK
COMMIT;
-- ROLLBACK; -- Use this instead if you want to undo
