/*
  # Add neutral emotions data

  1. New Data
    - Adds neutral/mixed emotions subcategories and their associated words:
      - Curiosity/Interest
      - Surprise/Amazement
      - Contemplation/Reflection
      - Anticipation/Expectation
*/

DO $$ 
DECLARE
  neutral_cat_id uuid;
  curiosity_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Insert Neutral Emotions category
  INSERT INTO categories (name)
  VALUES ('NEUTRAL/MIXED EMOTIONS')
  RETURNING id INTO neutral_cat_id;

  -- Curiosity/Interest subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (neutral_cat_id, 'Curiosity/Interest')
  RETURNING id INTO curiosity_subcat_id;

  -- Core type for Curiosity/Interest
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (curiosity_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Piqued', 'Having one''s interest or curiosity aroused'),
    (type_id, 'Interested', 'Showing curiosity or concern about something'),
    (type_id, 'Inquiring', 'Having or showing an interest in learning more'),
    (type_id, 'Curious', 'Eager to learn or know more'),
    (type_id, 'Intrigued', 'Very interested or curious about something'),
    (type_id, 'Fascinated', 'Intensely interested or captivated'),
    (type_id, 'Absorbed', 'Completely engrossed or engaged'),
    (type_id, 'Attentive', 'Paying careful attention'),
    (type_id, 'Inquisitive', 'Having a desire to learn or know something'),
    (type_id, 'Engaged', 'Actively interested or involved');

  -- Slang type for Curiosity/Interest
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (curiosity_subcat_id, 'Slang')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Nosey', 'Overly curious about others'' affairs'),
    (type_id, 'Snoopy', 'Inquisitive in an intrusive way'),
    (type_id, 'All ears', 'Very interested in hearing something'),
    (type_id, 'Dying to know', 'Very eager to learn something');

  -- Metaphorical type for Curiosity/Interest
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (curiosity_subcat_id, 'Metaphorical')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Mind like a sponge', 'Eagerly absorbing new information'),
    (type_id, 'Eyes wide open', 'Alert and eager to learn'),
    (type_id, 'Burning with curiosity', 'Intensely eager to know something'),
    (type_id, 'Thirst for knowledge', 'Strong desire to learn');

END $$;