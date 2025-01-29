/*
  # Add negative emotions data

  1. New Data
    - Adds negative emotions subcategories and their associated words:
      - Sadness/Grief
      - Anger/Frustration
      - Fear/Anxiety
      - Disgust/Aversion
      - Shame/Guilt
      - Jealousy/Envy
*/

DO $$ 
DECLARE
  negative_cat_id uuid;
  sadness_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Insert Negative Emotions category
  INSERT INTO categories (name)
  VALUES ('NEGATIVE EMOTIONS')
  RETURNING id INTO negative_cat_id;

  -- Sadness/Grief subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (negative_cat_id, 'Sadness/Grief')
  RETURNING id INTO sadness_subcat_id;

  -- Core type for Sadness/Grief
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (sadness_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Blue', 'Feeling sad or depressed'),
    (type_id, 'Low', 'Feeling depressed or unhappy'),
    (type_id, 'Downcast', 'Feeling discouraged or sad'),
    (type_id, 'Bummed', 'Feeling disappointed or depressed'),
    (type_id, 'Gloomy', 'Feeling dark or depressed'),
    (type_id, 'Morose', 'Sullen and ill-tempered'),
    (type_id, 'Wistful', 'Full of melancholy longing'),
    (type_id, 'Hurt', 'Feeling emotional pain'),
    (type_id, 'Doleful', 'Expressing sorrow; mournful'),
    (type_id, 'Melancholic', 'Feeling deep sadness or gloom'),
    (type_id, 'Despondent', 'In low spirits from loss of hope or courage'),
    (type_id, 'Sorrowful', 'Feeling or showing grief'),
    (type_id, 'Heartbroken', 'Suffering from overwhelming distress'),
    (type_id, 'Desolate', 'Feeling abandoned and alone'),
    (type_id, 'Woeful', 'Affected by or full of woe');

  -- Slang type for Sadness/Grief
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (sadness_subcat_id, 'Slang')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Down in the dumps', 'Very sad or depressed'),
    (type_id, 'Gutted', 'Very disappointed or upset'),
    (type_id, 'Crushed', 'Overwhelmed by sadness or grief'),
    (type_id, 'Wrecked', 'Emotionally devastated'),
    (type_id, 'Broken', 'Emotionally damaged or hurt');

  -- Metaphorical type for Sadness/Grief
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (sadness_subcat_id, 'Metaphorical')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Heart of stone', 'Unable to feel or express emotions'),
    (type_id, 'Heavy heart', 'Feeling sad or sorrowful'),
    (type_id, 'Dark cloud', 'A state of sadness or gloom'),
    (type_id, 'Storm inside', 'Turbulent emotions, especially sadness'),
    (type_id, 'Empty inside', 'Feeling hollow or without emotion');

END $$;