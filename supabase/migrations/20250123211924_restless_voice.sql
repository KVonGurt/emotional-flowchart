/*
  # Add more emotion subcategories

  1. New Data
    - Adds new subcategories for all emotion types
    - Includes words that fit "I'm feeling (blank)"
*/

DO $$ 
DECLARE
  positive_cat_id uuid;
  negative_cat_id uuid;
  neutral_cat_id uuid;
  confidence_subcat_id uuid;
  gratitude_subcat_id uuid;
  exhaustion_subcat_id uuid;
  confusion_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Get category IDs
  SELECT id INTO positive_cat_id FROM categories WHERE name = 'POSITIVE EMOTIONS';
  SELECT id INTO negative_cat_id FROM categories WHERE name = 'NEGATIVE EMOTIONS';
  SELECT id INTO neutral_cat_id FROM categories WHERE name = 'NEUTRAL/MIXED EMOTIONS';

  -- Add Confidence/Pride subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (positive_cat_id, 'Confidence/Pride')
  RETURNING id INTO confidence_subcat_id;

  -- Core type for Confidence/Pride
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (confidence_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Confident', 'Feeling or showing certainty about something'),
    (type_id, 'Proud', 'Feeling deep pleasure or satisfaction from achievements'),
    (type_id, 'Empowered', 'Made stronger and more confident'),
    (type_id, 'Unstoppable', 'Feeling impossible to defeat or prevent'),
    (type_id, 'Bold', 'Showing a willingness to take risks'),
    (type_id, 'Capable', 'Having the ability, fitness, or quality necessary to do something'),
    (type_id, 'Strong', 'Feeling physically or emotionally powerful');

  -- Add Gratitude/Appreciation subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (positive_cat_id, 'Gratitude/Appreciation')
  RETURNING id INTO gratitude_subcat_id;

  -- Core type for Gratitude/Appreciation
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (gratitude_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Grateful', 'Feeling or showing appreciation'),
    (type_id, 'Thankful', 'Pleased and relieved'),
    (type_id, 'Appreciative', 'Feeling or showing gratitude'),
    (type_id, 'Blessed', 'Feeling fortunate or favored'),
    (type_id, 'Moved', 'Affected with tender or grateful emotion');

  -- Add Exhaustion/Fatigue subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (negative_cat_id, 'Exhaustion/Fatigue')
  RETURNING id INTO exhaustion_subcat_id;

  -- Core type for Exhaustion/Fatigue
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (exhaustion_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Exhausted', 'Drained of energy or effectiveness'),
    (type_id, 'Tired', 'In need of sleep or rest'),
    (type_id, 'Drained', 'Emptied of energy or resources'),
    (type_id, 'Weary', 'Feeling or showing tiredness'),
    (type_id, 'Spent', 'Having used up all one''s energy'),
    (type_id, 'Fatigued', 'Extremely tired'),
    (type_id, 'Burned out', 'Exhausted physically or emotionally');

  -- Add Confusion/Uncertainty subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (neutral_cat_id, 'Confusion/Uncertainty')
  RETURNING id INTO confusion_subcat_id;

  -- Core type for Confusion/Uncertainty
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (confusion_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Confused', 'Unable to think clearly or understand'),
    (type_id, 'Uncertain', 'Not completely confident or sure'),
    (type_id, 'Puzzled', 'Unable to understand; perplexed'),
    (type_id, 'Lost', 'Unable to find one''s way or understand what to do'),
    (type_id, 'Unsure', 'Not confident about something'),
    (type_id, 'Ambivalent', 'Having mixed feelings about something'),
    (type_id, 'Perplexed', 'Completely baffled; very puzzled');

END $$;