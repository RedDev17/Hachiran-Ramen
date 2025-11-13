/*
  # Hachiran Ramen Menu Refresh

  1. Categories
    - Adds dedicated categories for Hachiran Ramen offerings
    - Reorders categories to highlight signature ramen bowls
    - Sets legacy categories to inactive so only the new set is shown on the site

  2. Menu Items
    - Inserts signature ramen, rice bowls, appetizers, extras, beverages, and promos
    - Adds variations for multi-size items (e.g., Tonkotsu, Gyoza, Ebi Tempura, Lemonade)
    - Adds add-ons for Gyudon upgrades

  3. Site Settings
    - Updates site branding, locations, and contact numbers for Hachiran Ramen
*/

-- Upsert Hachiran categories
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

-- Hide legacy categories from the customer view
UPDATE categories
SET active = false
WHERE id NOT IN ('signature-ramen', 'ramen-rice-bowls', 'appetizers-sides', 'extras-addons', 'hachiran-beverages', 'hachiran-promotions');

-- Ensure legacy menu items do not surface in the storefront
UPDATE menu_items
SET available = false
WHERE category NOT IN ('signature-ramen', 'ramen-rice-bowls', 'appetizers-sides', 'extras-addons', 'hachiran-beverages', 'hachiran-promotions');

-- Signature ramen bowls
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url) VALUES
  ('Special Tonkotsu Ramen', 'Creamy tonkotsu broth with 3 thin pork chashu slices, tamago, naruto, spring onions, shiitake, and mamen noodles.', 199, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1543353071-087092ec393b?auto=format&fit=crop&w=800&q=80'),
  ('Premium Tonkotsu Ramen', 'Elevated tonkotsu bowl with 2 thick pork chashu slices, tamago, naruto, spring onions, and mamen noodles.', 299, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1528834352185-1eaea6f62196?auto=format&fit=crop&w=800&q=80'),
  ('Maximum Overload Ramen', 'A feast of 2 thin pork chashu, 1 premium thick pork, double tamago and naruto, spring onions, shiitake, and mamen noodles.', 348, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1516100882582-96c3a05fe590?auto=format&fit=crop&w=800&q=80'),
  ('Creamy Fried Tonkotsu Ramen', 'Crispy fried tonkotsu pork with rich broth, tamago, nori, naruto, spring onions, shiitake, and mamen noodles.', 258, 'signature-ramen', false, true, 'https://images.unsplash.com/photo-1604908176755-3991e06fc1f8?auto=format&fit=crop&w=800&q=80'),
  ('Spicy Beef Ramen', 'Fiery ramen topped with sukiyaki beef, tamago, nori, naruto, spring onions, shiitake, and mamen noodles.', 248, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1512058564366-c9e3e0464b8f?auto=format&fit=crop&w=800&q=80'),
  ('Beef Wagyu Ramen Supreme', 'Luxurious bowl with wagyu cubes, sukiyaki beef, tamago, nori, lobster balls, spring onions, shiitake, and mamen noodles.', 368, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1604908177522-4023ac76d9a4?auto=format&fit=crop&w=800&q=80'),
  ('Tantanmen', 'Sesame-infused broth with premium pork chashu, tamago, nori, spring onions, sesame seeds, naruto, shiitake, and mamen noodles.', 318, 'signature-ramen', true, true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80'),
  ('Spicy Seafood Tantanmen', 'Seafood-loaded tantanmen with tempura, calamari, lobster balls, tamago, nori, naruto, shiitake, spring onions, and mamen noodles.', 388, 'signature-ramen', false, true, 'https://images.unsplash.com/photo-1505935428862-770b6f24f629?auto=format&fit=crop&w=800&q=80'),
  ('Creamy Seafood Tempura Ramen', 'Silky broth with tempura, calamari, lobster balls, tamago, nori, naruto, shiitake, spring onions, and mamen noodles.', 388, 'signature-ramen', false, true, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80');

-- Ramen and rice bowls
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url) VALUES
  ('Tonkotsu Ramen', 'Classic pork bone broth ramen with customizable bowl sizes.', 108, 'ramen-rice-bowls', true, true, 'https://images.unsplash.com/photo-1604908177522-4023ac76d9a4?auto=format&fit=crop&w=800&q=80'),
  ('Beef Wagyu Ramen', 'Comforting wagyu beef ramen served with rich broth and seasonal greens.', 318, 'ramen-rice-bowls', true, true, 'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=800&q=80'),
  ('Seafood Tempura Ramen', 'Light, creamy broth topped with shrimp tempura and calamari.', 288, 'ramen-rice-bowls', false, true, 'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?auto=format&fit=crop&w=800&q=80'),
  ('Wagyu Rice Toppings', 'Seared wagyu beef served over steamed Japanese rice with house sauce.', 238, 'ramen-rice-bowls', false, true, 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?auto=format&fit=crop&w=800&q=80'),
  ('Gyudon', 'Sweet-savory beef bowl over Japanese rice with optional upgrades.', 188, 'ramen-rice-bowls', true, true, 'https://images.unsplash.com/photo-1562967914-608f82629710?auto=format&fit=crop&w=800&q=80');

-- Tonkotsu bowl variations
INSERT INTO variations (menu_item_id, name, price) VALUES
  ((SELECT id FROM menu_items WHERE name = 'Tonkotsu Ramen'), 'Special', 50),
  ((SELECT id FROM menu_items WHERE name = 'Tonkotsu Ramen'), 'Maximum Overload', 140),
  ((SELECT id FROM menu_items WHERE name = 'Tonkotsu Ramen'), 'Super Supreme', 160)
ON CONFLICT DO NOTHING;

-- Gyudon add-ons
INSERT INTO add_ons (menu_item_id, name, price, category) VALUES
  ((SELECT id FROM menu_items WHERE name = 'Gyudon'), 'Raw Egg', 30, 'toppings'),
  ((SELECT id FROM menu_items WHERE name = 'Gyudon'), 'Tamago', 30, 'toppings'),
  ((SELECT id FROM menu_items WHERE name = 'Gyudon'), 'Mozzarella Cheese', 38, 'toppings'),
  ((SELECT id FROM menu_items WHERE name = 'Gyudon'), 'Japanese Rice', 40, 'toppings')
ON CONFLICT DO NOTHING;

-- Gyudon size variation
INSERT INTO variations (menu_item_id, name, price) VALUES
  ((SELECT id FROM menu_items WHERE name = 'Gyudon'), 'Jumbo', 40)
ON CONFLICT DO NOTHING;

-- Appetizers and sides
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url) VALUES
  ('Gyoza', 'Handmade pan-seared dumplings with savory pork filling. Choose your tray size.', 88, 'appetizers-sides', true, true, 'https://images.unsplash.com/photo-1585238341986-4c30947b7e1f?auto=format&fit=crop&w=800&q=80'),
  ('Ebi Tempura', 'Crispy shrimp tempura fried to golden perfection.', 228, 'appetizers-sides', true, true, 'https://images.unsplash.com/photo-1576402187878-974f70c890a5?auto=format&fit=crop&w=800&q=80'),
  ('Wagyu on Stick', 'Grilled wagyu beef skewer brushed with tare glaze.', 118, 'appetizers-sides', false, true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80'),
  ('Yakimeshi Fried Rice', 'Japanese-style fried rice with vegetables and house seasoning.', 88, 'appetizers-sides', false, true, 'https://images.unsplash.com/photo-1512058564366-c9e3e0464b8f?auto=format&fit=crop&w=800&q=80');

-- Appetizer variations
INSERT INTO variations (menu_item_id, name, price) VALUES
  ((SELECT id FROM menu_items WHERE name = 'Gyoza'), '8 pcs', 40),
  ((SELECT id FROM menu_items WHERE name = 'Gyoza'), '12 pcs', 92),
  ((SELECT id FROM menu_items WHERE name = 'Ebi Tempura'), '5 pcs', 122),
  ((SELECT id FROM menu_items WHERE name = 'Ebi Tempura'), '7 pcs', 222)
ON CONFLICT DO NOTHING;

-- Extras and add-ons
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url) VALUES
  ('Egg / Tamago', 'Soft-boiled marinated egg to top any bowl.', 30, 'extras-addons', false, true, 'https://images.unsplash.com/photo-1505935428862-770b6f24f629?auto=format&fit=crop&w=800&q=80'),
  ('Extra Noodles', 'Extra serving of fresh mamen noodles.', 50, 'extras-addons', false, true, 'https://images.unsplash.com/photo-1604908177522-4023ac76d9a4?auto=format&fit=crop&w=800&q=80'),
  ('Spring Onion', 'Extra handful of sliced spring onions.', 25, 'extras-addons', false, true, 'https://images.unsplash.com/photo-1466978913421-dad2ebd01d17?auto=format&fit=crop&w=800&q=80'),
  ('Aji Soup', 'Rich pork bone soup refill.', 50, 'extras-addons', false, true, 'https://images.unsplash.com/photo-1516100882582-96c3a05fe590?auto=format&fit=crop&w=800&q=80'),
  ('Nori (per pack)', 'Crispy seaweed sheets for added umami.', 50, 'extras-addons', false, true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80'),
  ('Pork (per order)', 'Extra serving of pork chashu.', 60, 'extras-addons', false, true, 'https://images.unsplash.com/photo-1512058564366-c9e3e0464b8f?auto=format&fit=crop&w=800&q=80');

-- Beverages
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url) VALUES
  ('Red Iced Tea', 'House-brewed red iced tea, lightly sweetened.', 40, 'hachiran-beverages', true, true, 'https://images.unsplash.com/photo-1546171753-97d7676f45c1?auto=format&fit=crop&w=800&q=80'),
  ('Lemonade', 'Freshly squeezed lemonade available in two sizes.', 60, 'hachiran-beverages', false, true, 'https://images.unsplash.com/photo-1505253216365-39779c07cbf9?auto=format&fit=crop&w=800&q=80'),
  ('Boh Bah Milk Drink (Buy 1 Take 1)', 'Chewy boba milk drink perfect for sharing.', 99, 'hachiran-beverages', true, true, 'https://images.unsplash.com/photo-1523362628745-0c100150b504?auto=format&fit=crop&w=800&q=80');

INSERT INTO variations (menu_item_id, name, price) VALUES
  ((SELECT id FROM menu_items WHERE name = 'Lemonade'), '22 oz', 15)
ON CONFLICT DO NOTHING;

-- Promotions
INSERT INTO menu_items (name, description, base_price, category, popular, available, image_url) VALUES
  ('3in1 Promo 1', 'Bundle includes Special Tonkotsu Ramen, 5 pcs Gyoza, and a Bohbah Milk Drink.', 288, 'hachiran-promotions', true, true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80'),
  ('3in1 Promo 2', 'Bundle includes Regular Beef Gyudon, 5 pcs Gyoza, and a Bohbah Milk Drink.', 318, 'hachiran-promotions', false, true, 'https://images.unsplash.com/photo-1512058564366-c9e3e0464b8f?auto=format&fit=crop&w=800&q=80'),
  ('Love2Share Promo', 'Share the love with 2 Bohbah drinks, 1 Regular Gyudon, and 2 Regular Tonkotsu Ramen.', 680, 'hachiran-promotions', true, true, 'https://images.unsplash.com/photo-1525755662778-989d0524087e?auto=format&fit=crop&w=800&q=80');

-- Update site branding and contact details
INSERT INTO site_settings (id, value, type, description) VALUES
  ('site_name', 'Hachiran Ramen', 'text', 'The name of the restaurant'),
  ('site_description', 'Authentic Japanese ramen bowls made with love. Visit us in Maginhawa, Kamuning, or Morayta.', 'text', 'Short marketing description shown on the site'),
  ('contact_phone', '09759123948 / 09959057813', 'text', 'Primary customer contact numbers'),
  ('locations', 'Maginhawa • Kamuning • Morayta', 'text', 'Branch locations shown to guests')
ON CONFLICT (id) DO UPDATE
SET
  value = EXCLUDED.value,
  type = EXCLUDED.type,
  description = EXCLUDED.description;

