/*
  # Allow Public Image Uploads for Admin
  
  This migration updates the storage policies to allow public uploads to the menu-images bucket.
  This is necessary because the admin dashboard uses password-based authentication rather than Supabase Auth.
  
  NOTE: In production, consider implementing proper Supabase authentication or using a service role key
  for admin operations instead of allowing public uploads.
*/

-- Allow public users to upload menu images (for admin dashboard)
-- Drop policies if they exist to make migration idempotent
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

