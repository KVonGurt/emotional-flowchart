/*
  # Add more negative emotions subcategories

  1. New Data
    - Adds more negative emotions subcategories:
      - Anger/Frustration
      - Fear/Anxiety
      - Disgust/Aversion
*/

DO $$ 
DECLARE
  negative_cat_id uuid;
  anger_subcat_id uuid;
  fear_subcat_id uuid;
  disgust_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Get the existing negative emotions category ID
  SELECT id INTO negative_cat_id FROM categories WHERE name = 'NEGATIVE EMOTIONS';

  -- Anger/Frustration subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (negative_cat_id, 'Anger/Frustration')
  RETURNING id INTO anger_subcat_id;

  -- Core type for Anger/Frustration
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (anger_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Angry', 'Feeling or showing strong annoyance or hostility'),
    (type_id, 'Frustrated', 'Feeling or expressing distress and annoyance'),
    (type_id, 'Irritated', 'Showing or feeling slight anger'),
    (type_id, 'Furious', 'Extremely angry'),
    (type_id, 'Enraged', 'Very angry; furious'),
    (type_id, 'Annoyed', 'Slightly angry; irritated'),
    (type_id, 'Irate', 'Feeling or characterized by great anger'),
    (type_id, 'Outraged', 'Extremely angry and shocked'),
    (type_id, 'Indignant', 'Feeling or showing anger about something unjust');

  -- Slang type for Anger/Frustration
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (anger_subcat_id, 'Slang')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Ticked off', 'Angry or irritated'),
    (type_id, 'Fed up', 'Very annoyed or tired of something'),
    (type_id, 'Steamed', 'Very angry'),
    (type_id, 'Losing it', 'Becoming very angry or emotional'),
    (type_id, 'Heated', 'Angry or agitated');

  -- Fear/Anxiety subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (negative_cat_id, 'Fear/Anxiety')
  RETURNING id INTO fear_subcat_id;

  -- Core type for Fear/Anxiety
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (fear_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Afraid', 'Feeling fear or anxiety'),
    (type_id, 'Anxious', 'Experiencing worry or unease'),
    (type_id, 'Nervous', 'Easily agitated or alarmed'),
    (type_id, 'Scared', 'Feeling frightened or fearful'),
    (type_id, 'Terrified', 'Extremely frightened'),
    (type_id, 'Panicked', 'Feeling sudden uncontrollable fear'),
    (type_id, 'Uneasy', 'Feeling anxiety or apprehension'),
    (type_id, 'Worried', 'Feeling troubled about actual or potential problems');

  -- Disgust/Aversion subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (negative_cat_id, 'Disgust/Aversion')
  RETURNING id INTO disgust_subcat_id;

  -- Core type for Disgust/Aversion
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (disgust_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Disgusted', 'Feeling revulsion or strong disapproval'),
    (type_id, 'Repulsed', 'Feeling intense aversion or distaste'),
    (type_id, 'Revolted', 'Experiencing intense disgust'),
    (type_id, 'Nauseated', 'Feeling physical or emotional revulsion'),
    (type_id, 'Appalled', 'Feeling horror or disgust'),
    (type_id, 'Sickened', 'Feeling disgust or revulsion');

END $$;