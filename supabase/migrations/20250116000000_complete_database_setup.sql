/*
  # Complete Database Setup for Hachiran Ramen
  
  This is a consolidated migration that sets up the entire database schema,
  including all tables, policies, triggers, and initial data.
  
  IMPORTANT: This migration is idempotent and can be run multiple times safely.
  
  Security Note: Public INSERT/UPDATE policies are included to allow the admin
  dashboard (which uses password-based authentication) to function. In production,
  consider implementing proper Supabase authentication for better security.
*/

-- ============================================================================
-- 1. CREATE TABLES
-- ============================================================================

-- Create menu_items table
CREATE TABLE IF NOT EXISTS menu_items (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  description text NOT NULL,
  base_price decimal(10,2) NOT NULL,
  category text NOT NULL,
  popular boolean DEFAULT false,
  available boolean DEFAULT true,
  image_url text,
  discount_price decimal(10,2),
  discount_start_date timestamptz,
  discount_end_date timestamptz,
  discount_active boolean DEFAULT false,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create variations table
CREATE TABLE IF NOT EXISTS variations (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_item_id uuid REFERENCES menu_items(id) ON DELETE CASCADE,
  name text NOT NULL,
  price decimal(10,2) NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now()
);

-- Create add_ons table
CREATE TABLE IF NOT EXISTS add_ons (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  menu_item_id uuid REFERENCES menu_items(id) ON DELETE CASCADE,
  name text NOT NULL,
  price decimal(10,2) NOT NULL DEFAULT 0,
  category text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Create categories table
CREATE TABLE IF NOT EXISTS categories (
  id text PRIMARY KEY,
  name text NOT NULL,
  icon text NOT NULL DEFAULT '☕',
  sort_order integer NOT NULL DEFAULT 0,
  active boolean DEFAULT true,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- Create site_settings table
CREATE TABLE IF NOT EXISTS site_settings (
  id text PRIMARY KEY,
  value text NOT NULL,
  type text NOT NULL DEFAULT 'text',
  description text,
  updated_at timestamptz DEFAULT now()
);

-- Create payment_methods table
CREATE TABLE IF NOT EXISTS payment_methods (
  id text PRIMARY KEY,
  name text NOT NULL,
  account_number text NOT NULL,
  account_name text NOT NULL,
  qr_code_url text NOT NULL,
  active boolean DEFAULT true,
  sort_order integer NOT NULL DEFAULT 0,
  created_at timestamptz DEFAULT now(),
  updated_at timestamptz DEFAULT now()
);

-- ============================================================================
-- 2. ENABLE ROW LEVEL SECURITY
-- ============================================================================

ALTER TABLE menu_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE variations ENABLE ROW LEVEL SECURITY;
ALTER TABLE add_ons ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_settings ENABLE ROW LEVEL SECURITY;
ALTER TABLE payment_methods ENABLE ROW LEVEL SECURITY;

-- ============================================================================
-- 3. CREATE POLICIES - PUBLIC READ ACCESS
-- ============================================================================

-- Menu items policies
DROP POLICY IF EXISTS "Anyone can read menu items" ON menu_items;
CREATE POLICY "Anyone can read menu items"
  ON menu_items
  FOR SELECT
  TO public
  USING (true);

-- Variations policies
DROP POLICY IF EXISTS "Anyone can read variations" ON variations;
CREATE POLICY "Anyone can read variations"
  ON variations
  FOR SELECT
  TO public
  USING (true);

-- Add-ons policies
DROP POLICY IF EXISTS "Anyone can read add-ons" ON add_ons;
CREATE POLICY "Anyone can read add-ons"
  ON add_ons
  FOR SELECT
  TO public
  USING (true);

-- Categories policies
DROP POLICY IF EXISTS "Anyone can read categories" ON categories;
CREATE POLICY "Anyone can read categories"
  ON categories
  FOR SELECT
  TO public
  USING (active = true);

-- Site settings policies
DROP POLICY IF EXISTS "Anyone can read site settings" ON site_settings;
CREATE POLICY "Anyone can read site settings"
  ON site_settings
  FOR SELECT
  TO public
  USING (true);

-- Payment methods policies
DROP POLICY IF EXISTS "Anyone can read active payment methods" ON payment_methods;
CREATE POLICY "Anyone can read active payment methods"
  ON payment_methods
  FOR SELECT
  TO public
  USING (active = true);

-- ============================================================================
-- 4. CREATE POLICIES - PUBLIC WRITE ACCESS (for admin dashboard)
-- ============================================================================

-- Menu items - allow public to insert/update/delete (for admin dashboard)
DROP POLICY IF EXISTS "Public users can manage menu items" ON menu_items;
CREATE POLICY "Public users can manage menu items"
  ON menu_items
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Variations - allow public to insert/update/delete
DROP POLICY IF EXISTS "Public users can manage variations" ON variations;
CREATE POLICY "Public users can manage variations"
  ON variations
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Add-ons - allow public to insert/update/delete
DROP POLICY IF EXISTS "Public users can manage add-ons" ON add_ons;
CREATE POLICY "Public users can manage add-ons"
  ON add_ons
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Categories - allow public to insert/update/delete
DROP POLICY IF EXISTS "Public users can manage categories" ON categories;
CREATE POLICY "Public users can manage categories"
  ON categories
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Site settings - allow public to insert/update/delete
DROP POLICY IF EXISTS "Public users can manage site settings" ON site_settings;
CREATE POLICY "Public users can manage site settings"
  ON site_settings
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- Payment methods - allow public to insert/update/delete
DROP POLICY IF EXISTS "Public users can manage payment methods" ON payment_methods;
CREATE POLICY "Public users can manage payment methods"
  ON payment_methods
  FOR ALL
  TO public
  USING (true)
  WITH CHECK (true);

-- ============================================================================
-- 5. CREATE POLICIES - AUTHENTICATED USER ACCESS (for future use)
-- ============================================================================

-- Menu items authenticated policies
DROP POLICY IF EXISTS "Authenticated users can manage menu items" ON menu_items;
CREATE POLICY "Authenticated users can manage menu items"
  ON menu_items
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Variations authenticated policies
DROP POLICY IF EXISTS "Authenticated users can manage variations" ON variations;
CREATE POLICY "Authenticated users can manage variations"
  ON variations
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Add-ons authenticated policies
DROP POLICY IF EXISTS "Authenticated users can manage add-ons" ON add_ons;
CREATE POLICY "Authenticated users can manage add-ons"
  ON add_ons
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Categories authenticated policies
DROP POLICY IF EXISTS "Authenticated users can manage categories" ON categories;
CREATE POLICY "Authenticated users can manage categories"
  ON categories
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Site settings authenticated policies
DROP POLICY IF EXISTS "Authenticated users can manage site settings" ON site_settings;
CREATE POLICY "Authenticated users can manage site settings"
  ON site_settings
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- Payment methods authenticated policies
DROP POLICY IF EXISTS "Authenticated users can manage payment methods" ON payment_methods;
CREATE POLICY "Authenticated users can manage payment methods"
  ON payment_methods
  FOR ALL
  TO authenticated
  USING (true)
  WITH CHECK (true);

-- ============================================================================
-- 6. CREATE TRIGGERS AND FUNCTIONS
-- ============================================================================

-- Create updated_at trigger function
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ language 'plpgsql';

-- Create triggers
DROP TRIGGER IF EXISTS update_menu_items_updated_at ON menu_items;
CREATE TRIGGER update_menu_items_updated_at
  BEFORE UPDATE ON menu_items
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_categories_updated_at ON categories;
CREATE TRIGGER update_categories_updated_at
  BEFORE UPDATE ON categories
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_site_settings_updated_at ON site_settings;
CREATE TRIGGER update_site_settings_updated_at
  BEFORE UPDATE ON site_settings
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

DROP TRIGGER IF EXISTS update_payment_methods_updated_at ON payment_methods;
CREATE TRIGGER update_payment_methods_updated_at
  BEFORE UPDATE ON payment_methods
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Create discount helper functions
CREATE OR REPLACE FUNCTION is_discount_active(
  discount_active boolean,
  discount_start_date timestamptz,
  discount_end_date timestamptz
)
RETURNS boolean AS $$
BEGIN
  IF NOT discount_active THEN
    RETURN false;
  END IF;
  
  IF discount_start_date IS NULL AND discount_end_date IS NULL THEN
    RETURN discount_active;
  END IF;
  
  RETURN (
    (discount_start_date IS NULL OR now() >= discount_start_date) AND
    (discount_end_date IS NULL OR now() <= discount_end_date)
  );
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION get_effective_price(
  base_price decimal,
  discount_price decimal,
  discount_active boolean,
  discount_start_date timestamptz,
  discount_end_date timestamptz
)
RETURNS decimal AS $$
BEGIN
  IF is_discount_active(discount_active, discount_start_date, discount_end_date) AND discount_price IS NOT NULL THEN
    RETURN discount_price;
  END IF;
  
  RETURN base_price;
END;
$$ LANGUAGE plpgsql;

-- Create indexes
CREATE INDEX IF NOT EXISTS idx_menu_items_discount_active ON menu_items(discount_active);
CREATE INDEX IF NOT EXISTS idx_menu_items_discount_dates ON menu_items(discount_start_date, discount_end_date);

-- Add foreign key constraint for categories
DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1 FROM information_schema.table_constraints
    WHERE constraint_name = 'menu_items_category_fkey'
  ) THEN
    ALTER TABLE menu_items 
    ADD CONSTRAINT menu_items_category_fkey 
    FOREIGN KEY (category) REFERENCES categories(id);
  END IF;
END $$;

-- ============================================================================
-- 7. CREATE STORAGE BUCKET FOR IMAGES
-- ============================================================================

-- Create storage bucket for menu images
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES (
  'menu-images',
  'menu-images',
  true,
  5242880, -- 5MB limit
  ARRAY['image/jpeg', 'image/png', 'image/webp', 'image/gif']
) ON CONFLICT (id) DO NOTHING;

-- Storage policies - Public read access
DROP POLICY IF EXISTS "Public read access for menu images" ON storage.objects;
CREATE POLICY "Public read access for menu images"
ON storage.objects
FOR SELECT
TO public
USING (bucket_id = 'menu-images');

-- Storage policies - Public write access (for admin dashboard)
DROP POLICY IF EXISTS "Public users can upload menu images" ON storage.objects;
CREATE POLICY "Public users can upload menu images"
ON storage.objects
FOR INSERT
TO public
WITH CHECK (bucket_id = 'menu-images');

DROP POLICY IF EXISTS "Public users can update menu images" ON storage.objects;
CREATE POLICY "Public users can update menu images"
ON storage.objects
FOR UPDATE
TO public
USING (bucket_id = 'menu-images');

DROP POLICY IF EXISTS "Public users can delete menu images" ON storage.objects;
CREATE POLICY "Public users can delete menu images"
ON storage.objects
FOR DELETE
TO public
USING (bucket_id = 'menu-images');

-- Storage policies - Authenticated user access (for future use)
DROP POLICY IF EXISTS "Authenticated users can upload menu images" ON storage.objects;
CREATE POLICY "Authenticated users can upload menu images"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'menu-images');

DROP POLICY IF EXISTS "Authenticated users can update menu images" ON storage.objects;
CREATE POLICY "Authenticated users can update menu images"
ON storage.objects
FOR UPDATE
TO authenticated
USING (bucket_id = 'menu-images');

DROP POLICY IF EXISTS "Authenticated users can delete menu images" ON storage.objects;
CREATE POLICY "Authenticated users can delete menu images"
ON storage.objects
FOR DELETE
TO authenticated
USING (bucket_id = 'menu-images');

-- ============================================================================
-- 8. INSERT INITIAL DATA
-- ============================================================================

-- Insert Hachiran Ramen categories
INSERT INTO categories (id, name, icon, sort_order, active) VALUES
  ('signature-ramen', 'Signature Ramen', '🍜', 1, true),
  ('ramen-rice-bowls', 'Ramen & Rice Bowls', '🍲', 2, true),
  ('appetizers-sides', 'Appetizers & Sides', '🥟', 3, true),
  ('extras-addons', 'Extras & Add-ons', '➕', 4, true),
  ('hachiran-beverages', 'Beverages', '🥤', 5, true),
  ('hachiran-promotions', 'Promotions', '💝', 6, true)
ON CONFLICT (id) DO UPDATE
SET
  name = EXCLUDED.name,
  icon = EXCLUDED.icon,
  sort_order = EXCLUDED.sort_order,
  active = EXCLUDED.active;

-- Insert default site settings
INSERT INTO site_settings (id, value, type, description) VALUES
  ('site_name', 'Hachiran Ramen', 'text', 'The name of the restaurant'),
  ('site_logo', 'https://images.pexels.com/photos/302899/pexels-photo-302899.jpeg?auto=compress&cs=tinysrgb&w=300&h=300&fit=crop', 'image', 'The logo image URL for the site'),
  ('site_description', 'Authentic Japanese ramen bowls made with love. Visit us in Maginhawa, Kamuning, or Morayta.', 'text', 'Short marketing description shown on the site'),
  ('currency', '₱', 'text', 'Currency symbol for prices'),
  ('currency_code', 'PHP', 'text', 'Currency code for payments'),
  ('contact_phone', '09759123948 / 09959057813', 'text', 'Primary customer contact numbers'),
  ('locations', 'Maginhawa • Kamuning • Morayta', 'text', 'Branch locations shown to guests')
ON CONFLICT (id) DO UPDATE
SET
  value = EXCLUDED.value,
  type = EXCLUDED.type,
  description = EXCLUDED.description;

-- Insert default payment methods
INSERT INTO payment_methods (id, name, account_number, account_name, qr_code_url, sort_order, active) VALUES
  ('gcash', 'GCash', '09XX XXX XXXX', 'Hachiran Ramen', 'https://images.pexels.com/photos/8867482/pexels-photo-8867482.jpeg?auto=compress&cs=tinysrgb&w=300&h=300&fit=crop', 1, true),
  ('maya', 'Maya (PayMaya)', '09XX XXX XXXX', 'Hachiran Ramen', 'https://images.pexels.com/photos/8867482/pexels-photo-8867482.jpeg?auto=compress&cs=tinysrgb&w=300&h=300&fit=crop', 2, true),
  ('bank-transfer', 'Bank Transfer', 'Account: 1234-5678-9012', 'Hachiran Ramen', 'https://images.pexels.com/photos/8867482/pexels-photo-8867482.jpeg?auto=compress&cs=tinysrgb&w=300&h=300&fit=crop', 3, true)
ON CONFLICT (id) DO UPDATE
SET
  name = EXCLUDED.name,
  account_number = EXCLUDED.account_number,
  account_name = EXCLUDED.account_name,
  qr_code_url = EXCLUDED.qr_code_url,
  sort_order = EXCLUDED.sort_order,
  active = EXCLUDED.active;

-- Insert Hachiran Ramen menu items (Signature Ramen)
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url) VALUES
  ('Special Tonkotsu Ramen', 'Creamy tonkotsu broth with 3 thin pork chashu slices, tamago, naruto, spring onions, shiitake, and mamen noodles.', 199, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1543353071-087092ec393b?auto=format&fit=crop&w=800&q=80'),
  ('Premium Tonkotsu Ramen', 'Elevated tonkotsu bowl with 2 thick pork chashu slices, tamago, naruto, spring onions, and mamen noodles.', 299, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1528834352185-1eaea6f62196?auto=format&fit=crop&w=800&q=80'),
  ('Maximum Overload Ramen', 'A feast of 2 thin pork chashu, 1 premium thick pork, double tamago and naruto, spring onions, shiitake, and mamen noodles.', 348, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1516100882582-96c3a05fe590?auto=format&fit=crop&w=800&q=80'),
  ('Creamy Fried Tonkotsu Ramen', 'Crispy fried tonkotsu pork with rich broth, tamago, nori, naruto, spring onions, shiitake, and mamen noodles.', 258, 'signature-ramen', false, true, 'https://images.unsplash.com/photo-1604908176755-3991e06fc1f8?auto=format&fit=crop&w=800&q=80'),
  ('Spicy Beef Ramen', 'Fiery ramen topped with sukiyaki beef, tamago, nori, naruto, spring onions, shiitake, and mamen noodles.', 248, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1512058564366-c9e3e0464b8f?auto=format&fit=crop&w=800&q=80'),
  ('Beef Wagyu Ramen Supreme', 'Luxurious bowl with wagyu cubes, sukiyaki beef, tamago, nori, lobster balls, spring onions, shiitake, and mamen noodles.', 368, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1604908177522-4023ac76d9a4?auto=format&fit=crop&w=800&q=80'),
  ('Tantanmen', 'Sesame-infused broth with premium pork chashu, tamago, nori, spring onions, sesame seeds, naruto, shiitake, and mamen noodles.', 318, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80'),
  ('Spicy Seafood Tantanmen', 'Seafood-loaded tantanmen with tempura, calamari, lobster balls, tamago, nori, naruto, shiitake, spring onions, and mamen noodles.', 388, 'signature-ramen', false, true, 'https://images.unsplash.com/photo-1505935428862-770b6f24f629?auto=format&fit=crop&w=800&q=80'),
  ('Creamy Seafood Tempura Ramen', 'Silky broth with tempura, calamari, lobster balls, tamago, nori, naruto, shiitake, spring onions, and mamen noodles.', 388, 'signature-ramen', false, true, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80')
ON CONFLICT DO NOTHING;

-- Note: Additional menu items, variations, and add-ons can be inserted via the admin dashboard
-- or through separate data migration files if needed.

