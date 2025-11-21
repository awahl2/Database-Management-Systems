CREATE TABLE champions (
    champion_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    primary_role VARCHAR(20) NOT NULL,
    win_rate DECIMAL(5,2),
    pick_rate DECIMAL(5,2),
    ban_rate DECIMAL(5,2),
    INDEX idx_role (primary_role),
    INDEX idx_win_rate (win_rate)
);

CREATE TABLE items (
    item_id SMALLINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    cost MEDIUMINT NOT NULL,
    class VARCHAR(30),
    INDEX idx_cost (cost),
    INDEX idx_class (class)
);

CREATE TABLE champion_items (
    champion_item_id INT PRIMARY KEY AUTO_INCREMENT,
    champion_id SMALLINT NOT NULL,
    item_id SMALLINT NOT NULL,
    priority_order TINYINT NOT NULL,
    win_rate_with_item DECIMAL(5,2),
    FOREIGN KEY (champion_id) REFERENCES champions(champion_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id),
    INDEX idx_champion (champion_id),
    INDEX idx_item (item_id),
    INDEX idx_win_rate (win_rate_with_item)
);
