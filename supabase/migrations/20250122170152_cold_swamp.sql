/*
  # Emotions Database Schema

  1. New Tables
    - `categories` - Main emotion categories (positive, negative, neutral)
      - `id` (uuid, primary key)
      - `name` (text)
      - `created_at` (timestamp)
    
    - `subcategories` - Emotion subcategories
      - `id` (uuid, primary key)
      - `category_id` (uuid, foreign key)
      - `name` (text)
      - `created_at` (timestamp)
    
    - `emotion_types` - Types of emotions (core, slang, etc.)
      - `id` (uuid, primary key)
      - `subcategory_id` (uuid, foreign key)
      - `name` (text)
      - `created_at` (timestamp)
    
    - `emotion_words` - Individual emotion words with definitions
      - `id` (uuid, primary key)
      - `type_id` (uuid, foreign key)
      - `word` (text)
      - `definition` (text)
      - `created_at` (timestamp)

  2. Security
    - Enable RLS on all tables
    - Add policies for public read access
*/

-- Create tables
CREATE TABLE categories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE subcategories (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  category_id uuid REFERENCES categories(id) ON DELETE CASCADE,
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE emotion_types (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  subcategory_id uuid REFERENCES subcategories(id) ON DELETE CASCADE,
  name text NOT NULL,
  created_at timestamptz DEFAULT now()
);

CREATE TABLE emotion_words (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  type_id uuid REFERENCES emotion_types(id) ON DELETE CASCADE,
  word text NOT NULL,
  definition text NOT NULL,
  created_at timestamptz DEFAULT now()
);

-- Enable Row Level Security
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE subcategories ENABLE ROW LEVEL SECURITY;
ALTER TABLE emotion_types ENABLE ROW LEVEL SECURITY;
ALTER TABLE emotion_words ENABLE ROW LEVEL SECURITY;

-- Create policies for public read access
CREATE POLICY "Allow public read access on categories"
  ON categories FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public read access on subcategories"
  ON subcategories FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public read access on emotion_types"
  ON emotion_types FOR SELECT
  TO public
  USING (true);

CREATE POLICY "Allow public read access on emotion_words"
  ON emotion_words FOR SELECT
  TO public
  USING (true);