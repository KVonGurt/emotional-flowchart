/*
  # Add more neutral emotions subcategories

  1. New Data
    - Adds more neutral/mixed emotions subcategories:
      - Surprise/Amazement
      - Contemplation/Reflection
      - Anticipation/Expectation
*/

DO $$ 
DECLARE
  neutral_cat_id uuid;
  surprise_subcat_id uuid;
  contemplation_subcat_id uuid;
  anticipation_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Get the existing neutral emotions category ID
  SELECT id INTO neutral_cat_id FROM categories WHERE name = 'NEUTRAL/MIXED EMOTIONS';

  -- Surprise/Amazement subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (neutral_cat_id, 'Surprise/Amazement')
  RETURNING id INTO surprise_subcat_id;

  -- Core type for Surprise/Amazement
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (surprise_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Surprised', 'Feeling or showing astonishment'),
    (type_id, 'Amazed', 'Feeling great wonder or astonishment'),
    (type_id, 'Astonished', 'Greatly surprised or impressed'),
    (type_id, 'Stunned', 'Extremely surprised or shocked'),
    (type_id, 'Startled', 'Suddenly surprised or alarmed'),
    (type_id, 'Dumbfounded', 'So surprised that one is temporarily speechless'),
    (type_id, 'Awestruck', 'Filled with wonder and amazement');

  -- Contemplation/Reflection subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (neutral_cat_id, 'Contemplation/Reflection')
  RETURNING id INTO contemplation_subcat_id;

  -- Core type for Contemplation/Reflection
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (contemplation_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Thoughtful', 'Absorbed in or characterized by thought'),
    (type_id, 'Pensive', 'Engaged in deep or serious thought'),
    (type_id, 'Reflective', 'Characterized by deep thought'),
    (type_id, 'Meditative', 'Absorbed in contemplation'),
    (type_id, 'Contemplative', 'Involving deep reflection'),
    (type_id, 'Introspective', 'Examining one''s own thoughts and feelings');

  -- Anticipation/Expectation subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (neutral_cat_id, 'Anticipation/Expectation')
  RETURNING id INTO anticipation_subcat_id;

  -- Core type for Anticipation/Expectation
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (anticipation_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Expectant', 'Having or showing an excited feeling that something is about to happen'),
    (type_id, 'Anticipating', 'Regarding something that is going to happen'),
    (type_id, 'Awaiting', 'Waiting for something expected'),
    (type_id, 'Prepared', 'Ready for what is about to happen'),
    (type_id, 'Watchful', 'Alert and vigilant for what may come'),
    (type_id, 'Ready', 'Prepared for what is about to occur');

END $$;