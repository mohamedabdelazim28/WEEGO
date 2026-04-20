-- 1. Add 'type' field to bookings table
ALTER TABLE bookings ADD COLUMN IF NOT EXISTS type text DEFAULT 'normal';

-- 2. Update existing airport pickups (using category flag as hint) to 'airport'
UPDATE bookings SET type = 'airport' WHERE category = 'airport_pickup';

-- 3. Create the optimized dashboard statistics view
CREATE OR REPLACE VIEW dashboard_stats AS
SELECT
  count(*) FILTER (WHERE type = 'airport') AS airport_pickups,
  count(*) AS total_bookings,
  -- Use price_final if available, else price_estimated. Fallback to 0 to prevent NaN
  floor(SUM(COALESCE(price_final, price_estimated, 0)) * 0.1) AS total_points
FROM bookings;
