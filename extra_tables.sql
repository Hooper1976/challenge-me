-- SQL um die neuen Tabellen für Belohnungen und User-Profil Erweiterungen anzulegen
-- Im Supabase SQL Editor ausführen!

-- Tabelle für Belohnungen (Rewards)
CREATE TABLE IF NOT EXISTS public.rewards (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  points_cost INTEGER DEFAULT 1000,
  image_url TEXT,
  provider TEXT, -- z.B. McDonalds
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- Sicherstellen dass keine RLS Sperre im Admin-Test existiert
ALTER TABLE public.rewards DISABLE ROW LEVEL SECURITY;
