# League of Legends Build Optimizer Database

---

## Database Summary Report

### Intended Audience

This database was created for the League of Legends competitive gaming community, specifically players who want to optimize their builds based on statistical data. League of Legends is a Multiplayer Online Battle Arena (MOBA) game where players select champions and build items throughout the match to enhance their champion's abilities. With over 170 champions and 300+ items, determining item builds can be overwhelming and confusing for players at all skill levels.

The data for this database was pulled directly from u.gg, a leading League of Legends statistics platforms that aggregates millions of matches to provide win rates, pick rates, and performance metrics. This database models the relationship between champions, items, and their combined effectiveness to help players make informed decisions during champion select and in-game backing.

### User Perspective

FIXME
---

## Database ER Model

```mermaid
erDiagram
    CHAMPIONS ||--o{ CHAMPION_ITEMS : "builds_with"
    ITEMS ||--o{ CHAMPION_ITEMS : "used_in"
    
    CHAMPIONS {
        int champion_id PK
        varchar name
        varchar primary_role
        decimal win_rate
        decimal pick_rate
        decimal ban_rate
        datetime last_updated
    }
    
    ITEMS {
        int item_id PK
        varchar name
        int cost
        varchar class
    }
    
    CHAMPION_ITEMS {
        int champion_item_id PK
        int champion_id FK
        int item_id FK
        int priority_order
        decimal win_rate_with_item
    }
```
