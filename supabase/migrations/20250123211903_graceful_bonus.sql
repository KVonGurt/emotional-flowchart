/*
  # Add more emotion words

  1. New Data
    - Adds more emotion words to existing categories
    - Focuses on words that fit "I'm feeling (blank)"
    - Includes additional slang and metaphorical expressions
*/

DO $$ 
DECLARE
  positive_cat_id uuid;
  negative_cat_id uuid;
  neutral_cat_id uuid;
  happiness_subcat_id uuid;
  sadness_subcat_id uuid;
  anger_subcat_id uuid;
  fear_subcat_id uuid;
  surprise_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Get category IDs
  SELECT id INTO positive_cat_id FROM categories WHERE name = 'POSITIVE EMOTIONS';
  SELECT id INTO negative_cat_id FROM categories WHERE name = 'NEGATIVE EMOTIONS';
  SELECT id INTO neutral_cat_id FROM categories WHERE name = 'NEUTRAL/MIXED EMOTIONS';

  -- Get subcategory IDs
  SELECT id INTO happiness_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Happiness/Joy';
  SELECT id INTO sadness_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Sadness/Grief';
  SELECT id INTO anger_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Anger/Frustration';
  SELECT id INTO fear_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Fear/Anxiety';
  SELECT id INTO surprise_subcat_id FROM subcategories WHERE category_id = neutral_cat_id AND name = 'Surprise/Amazement';

  -- Add more Core happiness words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = happiness_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Radiant', 'Showing great joy, love, or health'),
    (type_id, 'Vibrant', 'Full of energy and enthusiasm'),
    (type_id, 'Wonderful', 'Experiencing a feeling of wonder and delight'),
    (type_id, 'Fantastic', 'Extraordinarily good or pleasant'),
    (type_id, 'Marvelous', 'Causing great wonder or delight'),
    (type_id, 'Splendid', 'Magnificent or excellent'),
    (type_id, 'Peaceful', 'Free from disturbance; tranquil'),
    (type_id, 'Serene', 'Calm, peaceful, and untroubled');

  -- Add more Slang happiness words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = happiness_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'On point', 'Feeling perfect or exactly right'),
    (type_id, 'Living', 'Experiencing life to the fullest'),
    (type_id, 'Blessed', 'Feeling fortunate or lucky'),
    (type_id, 'Gucci', 'Feeling good or doing well'),
    (type_id, 'Hyped', 'Very excited or enthusiastic');

  -- Add more Core sadness words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = sadness_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Dejected', 'Sad and depressed; dispirited'),
    (type_id, 'Forlorn', 'Pitifully sad and abandoned or lonely'),
    (type_id, 'Miserable', 'Wretchedly unhappy or uncomfortable'),
    (type_id, 'Hopeless', 'Feeling or causing despair'),
    (type_id, 'Defeated', 'Demoralized and overcome by adversity');

  -- Add more Core anger words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = anger_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Livid', 'Furiously angry'),
    (type_id, 'Seething', 'Filled with intense but unexpressed anger'),
    (type_id, 'Bitter', 'Angry and resentful'),
    (type_id, 'Hostile', 'Unfriendly and antagonistic'),
    (type_id, 'Resentful', 'Feeling or expressing bitterness or indignation');

  -- Add more Core fear/anxiety words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = fear_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Apprehensive', 'Anxious or fearful about the future'),
    (type_id, 'Overwhelmed', 'Feeling overcome by intense emotion'),
    (type_id, 'Vulnerable', 'Exposed to emotional harm'),
    (type_id, 'Insecure', 'Not confident or assured; uncertain and anxious'),
    (type_id, 'Restless', 'Unable to remain still or quiet due to anxiety');

  -- Add Metaphorical fear/anxiety words
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (fear_subcat_id, 'Metaphorical')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Butterflies in stomach', 'Nervous excitement'),
    (type_id, 'Heart racing', 'Experiencing intense anxiety or fear'),
    (type_id, 'Walking on eggshells', 'Being cautious to avoid upsetting someone'),
    (type_id, 'Frozen with fear', 'Unable to move or act due to extreme fear');

  -- Add more Core surprise/amazement words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = surprise_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Bewildered', 'Perplexed and confused'),
    (type_id, 'Flabbergasted', 'Greatly surprised or astonished'),
    (type_id, 'Speechless', 'Unable to speak due to surprise or shock'),
    (type_id, 'Thunderstruck', 'Extremely surprised or shocked'),
    (type_id, 'Spellbound', 'Held in or as if in a spell; fascinated');

END $$;