# Database Analysis & Conclusion

Here is an architectural review of the `public` schema tables pulled directly from Supabase, alongside their relationships, design patterns, and areas for improvement.

## Tables Structure

### 1. `users`

- **PK**: `id` (uuid)
- **Columns**: `email` (text), `phone` (text), `user_name` (text), `created_at` (timestamptz)
- **Relationships**: `id` references `auth.users(id)`

### 2. `restaurants`

- **PK**: `id` (uuid)
- **Columns**: `owner_id` (uuid), `restaurant_name` (text), `restaurant_address` (text), `restaurant_logo_url` (text), `restaurant_description` (text, nullable), `menu_url` (text, nullable), `created_at` (timestamptz)
- **Relationships**: `owner_id` references `users(id)`

### 3. `menus`

- **PK**: `id` (uuid)
- **Columns**: `restaurant_id` (uuid, unique), `title` (text), `views_count` (int4), `created_at` (timestamptz)
- **Relationships**: `restaurant_id` references `restaurants(id)`

### 4. `menu_theme`

- **PK**: `id` (uuid)
- **Columns**: `menu_id` (uuid, unique), `font_family` (text), `card_radius` (int4), `card_elevation` (int4), `background_color` (text), `primary_color` (text), `created_at` (timestamptz)
- **Relationships**: `menu_id` references `menus(id)`

### 5. `categories`

- **PK**: `id` (uuid)
- **Columns**: `menu_id` (uuid), `name` (text), `image_url` (text, nullable), `items_count` (int2), `is_visible` (boolean), `created_at` (timestamptz)
- **Relationships**: `menu_id` references `menus(id)`

### 6. `menu_items`

- **PK**: `id` (uuid)
- **Columns**: `category_id` (uuid), `restaurant_id` (uuid), `owner_id` (uuid), `name` (text), `description` (text, nullable), `price` (text), `discount` (text, nullable), `image_urls` (ARRAY text), `is_visible` (boolean), `views_count` (int4), `expires_at` (timestamptz, nullable), `created_at` (timestamptz)
- **Relationships**:
  - `category_id` references `categories(id)`
  - `restaurant_id` references `restaurants(id)`
  - `owner_id` references `users(id)`

### 7. `banners`

- **PK**: `id` (uuid)
- **Columns**: `menu_id` (uuid), `image_url` (text), `redirect_url` (text, nullable), `is_live` (boolean), `interactions` (int2), `expires_at` (timestamptz, nullable), `created_at` (timestamptz)
- **Relationships**: `menu_id` references `menus(id)`

### 8. `events`

- **PK**: `id` (uuid)
- **Columns**: `menu_id` (uuid), `event_type` (text - restricted via CHECK constraint to: 'menu_visit', 'item_visit', 'banner_interaction'), `item_id` (uuid, nullable), `banner_id` (uuid, nullable), `created_at` (timestamptz)
- **Relationships**:
  - `menu_id` references `menus(id)`
  - `item_id` references `menu_items(id)`
  - `banner_id` references `banners(id)`

### 9. `otp_codes`

- **PK**: `id` (uuid)
- **Columns**: `email` (text), `code` (text), `expires_at` (timestamptz), `created_at` (timestamptz)

---

## RPC Functions

1. **`add_banner`**(p_menu_id, p_image_url, p_redirect_url, p_is_live, p_expires_at) -> `banners`
2. **`add_category`**(p_menu_id, p_name, p_image_url, p_is_visible) -> `categories`
3. **`add_item`**(p_category_id, p_restaurant_id, p_owner_id, p_name, p_price, p_description, p_image_url, p_is_visible) -> `menu_items`
4. **`check_email_exists`**(email_input) -> `boolean`
5. **`complete_signup`**(p_id, p_email, p_user_name, p_phone, p_restaurant_name, p_restaurant_address, p_restaurant_logo_url, p_restaurant_description) -> `jsonb`
6. **`get_all_standard_stats`**(p_menu_id) -> `json`
7. **`get_categories`**(p_menu_id) -> `SETOF categories`
8. **`get_custom_dashboard_stats`**(p_menu_id, p_start_time, p_end_time) -> `json`
9. **`get_items`**(p_category_id) -> `SETOF menu_items`
10. **`get_user_by_email`**(user_email) -> `jsonb`
11. **`increment_menu_view_count`**(p_menu_id) -> `void`
12. **`increment_view_count`**(p_item_id) -> `void`
13. **`log_event`**(p_menu_id, p_event_type, p_item_id, p_banner_id) -> `void`
14. **`set_restaurant_menu_url`**() -> `trigger` (Trigger execution function)
15. **`update_banner`**(p_banner_id, p_image_url, p_redirect_url, p_is_live, p_expires_at) -> `banners`
16. **`update_category`**(p_id, p_name, p_image_url, p_is_visible) -> `categories`
17. **`update_category_items_count`**() -> `trigger` (Trigger execution function)
18. **`update_item`**(p_id, p_name, p_price, p_description, p_image_urls, p_is_visible, p_discount, p_expires_at) -> `menu_items`
19. **`update_profile`**(p_owner_id, p_user_name, p_phone, p_restaurant_name, p_logo_url) -> `jsonb`
20. **`user_login`**() -> `jsonb`

---

## Database Triggers

1. **`on_restaurant_created`** (Table: `restaurants`)
   - **Trigger**: `BEFORE INSERT ON public.restaurants FOR EACH ROW`
   - **Action**: `EXECUTE FUNCTION set_restaurant_menu_url()`
2. **`trigger_update_category_items_count`** (Table: `menu_items`)
   - **Trigger**: `AFTER INSERT OR DELETE OR UPDATE OF category_id ON public.menu_items FOR EACH ROW`
   - **Action**: `EXECUTE FUNCTION update_category_items_count()`

---

## Technical Conclusion & Recommendations

### 1. **Security Vulnerability: Row Level Security (RLS) is Disabled!**

Across all tables, `rls_enabled` is set to `false`. Without RLS, if the Supabase anon key is exposed, any user (or malicious actor) could read, update, or delete rows in `users`, `restaurants`, and `menu_items`.
> **Action**: Enable RLS on all tables immediately. Create policies enforcing the `auth.uid() = owner_id` paradigm (or equivalent) for insert/update/delete operations.

### 2. **Data Types for Currency (`price` and `discount` in `menu_items`)**

The `price` and `discount` columns in `menu_items` are currently stored as `text`.
Storing currency data as plain text completely removes your ability to perform analytical SQL functions like `SUM`, `AVG`, `MIN`, `MAX`, sort logic (e.g. `$100` might alphabetically sort before `$20`), and accurate validations.
> **Action**: Change `price` and `discount` data types from `text` to `NUMERIC` or `DECIMAL(10,2)` in PostgreSQL. Prefixing currencies in text should be strictly a frontend client responsibility.

### 3. **Relational Redundancy in `menu_items`**

The `menu_items` table contains three foreign keys mapping upwards: `category_id`, `restaurant_id`, and `owner_id`.
Normally, a `menu_item` belongs to a `category`, and that `category` references a `menu`, which in turn references a `restaurant`, which finally maps to an `owner`. Storing `restaurant_id` and `owner_id` explicitly at the item level represents *denormalization*.
> **Conclusion**: If this denormalization was implemented to simplify potential RLS policies down the line or to speed up queries linking "All menu items from owner X", then it is acceptable. Just be cautious of "update-anomalies" should a category switch its menu (or menu switch ownership, though unlikely).

### 4. **1-to-1 Relationship Mappings (`menus` & `menu_theme`)**

Your tables `menus.restaurant_id` and `menu_theme.menu_id` carry `unique` constraints.
This is a perfectly sound architecture for keeping a strict 1-to-1 extension where a restaurant only has a single active master menu, and a menu has exactly one theme configuration. Good job on extracting the theme layer away to prevent table rot.

### 5. **Analytics `events` Table Implementation**

You successfully implemented the `events` table resolving the "High Concurrency Blockages" and "Missing Chart Data" issues. It securely logs individual timestamps representing user views natively mapping specific `item_id`s and `banner_id`s, while implementing a strong Check Constraint on `event_type` (`'menu_visit'`, `'item_visit'`, `'banner_interaction'`).
> **Action**: You are now fully equipped to extract reliable graph data using Supabase RPC aggregating the count by standard Postgres interval truncations (by hour to populate today's chart, or by day for a week schema).
