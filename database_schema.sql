-- Supabase Database Schema for Challenge Me Web App

-- 1. Profiles (User Metadata)
CREATE TABLE profiles (
  id uuid REFERENCES auth.users ON DELETE CASCADE PRIMARY KEY,
  username TEXT UNIQUE NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  total_points INTEGER DEFAULT 0,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. Challenges (The Predefined and Global Tasks)
CREATE TYPE challenge_type AS ENUM ('predefined', 'global', 'user_generated');

CREATE TABLE challenges (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  description TEXT NOT NULL,
  points INTEGER DEFAULT 50,
  type challenge_type DEFAULT 'predefined',
  created_by uuid REFERENCES profiles(id),
  is_active BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. Participations / Proofs (Entries where users complete challenges)
CREATE TABLE challenge_entries (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  challenge_id uuid REFERENCES challenges(id) NOT NULL,
  user_id uuid REFERENCES profiles(id) NOT NULL,
  proof_url TEXT, -- URL to image/video in Supabase Storage
  proof_text TEXT,
  status TEXT CHECK (status IN ('pending', 'verified', 'rejected')) DEFAULT 'pending',
  verified_by uuid REFERENCES profiles(id), -- Option for Peer-Verification
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 4. Friendships
CREATE TABLE friendships (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  user_id_1 uuid REFERENCES profiles(id) NOT NULL,
  user_id_2 uuid REFERENCES profiles(id) NOT NULL,
  status TEXT CHECK (status IN ('request', 'accepted', 'blocked')) DEFAULT 'request',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  UNIQUE(user_id_1, user_id_2)
);

-- 5. Chat Messages
CREATE TABLE messages (
  id uuid DEFAULT gen_random_uuid() PRIMARY KEY,
  sender_id uuid REFERENCES profiles(id) NOT NULL,
  receiver_id uuid REFERENCES profiles(id) NOT NULL,
  content TEXT NOT NULL,
  is_read BOOLEAN DEFAULT false,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 6. Highscore View (Easy access to ranking)
CREATE VIEW leaderboard AS
  SELECT username, total_points, avatar_url
  FROM profiles
  ORDER BY total_points DESC;
