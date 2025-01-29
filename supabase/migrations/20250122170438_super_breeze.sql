/*
  # Populate Positive Emotions

  1. Data Population
    - Add "POSITIVE EMOTIONS" category
    - Add all positive emotion subcategories
    - Add emotion types for each subcategory
    - Add words with definitions for each type

  2. Structure
    - Organized by subcategories:
      - Happiness/Joy
      - Love/Connection
      - Energy/Enthusiasm
      - Confidence/Optimism
      - Trust/Security
      - Calm/Peace
*/

DO $$ 
DECLARE
  positive_cat_id uuid;
  happiness_subcat_id uuid;
  love_subcat_id uuid;
  energy_subcat_id uuid;
  confidence_subcat_id uuid;
  trust_subcat_id uuid;
  calm_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Insert Positive Emotions category
  INSERT INTO categories (name)
  VALUES ('POSITIVE EMOTIONS')
  RETURNING id INTO positive_cat_id;

  -- Happiness/Joy subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (positive_cat_id, 'Happiness/Joy')
  RETURNING id INTO happiness_subcat_id;

  -- Core type for Happiness/Joy
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (happiness_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Content', 'In a state of peaceful happiness and satisfaction'),
    (type_id, 'Glad', 'Feeling joy or pleasure; delighted'),
    (type_id, 'Buoyant', 'Cheerful and optimistic'),
    (type_id, 'Chipper', 'Cheerful and lively'),
    (type_id, 'Upbeat', 'Optimistic and cheerful'),
    (type_id, 'Beaming', 'Radiating joy or happiness'),
    (type_id, 'Delighted', 'Feeling great pleasure and joy'),
    (type_id, 'Satisfied', 'Content and pleased'),
    (type_id, 'Lighthearted', 'Carefree and cheerful'),
    (type_id, 'Pleased', 'Happy or satisfied'),
    (type_id, 'Cheery', 'Noticeably happy and optimistic'),
    (type_id, 'Cheerful', 'Full of good spirits and joy'),
    (type_id, 'Joyful', 'Feeling, expressing, or causing great pleasure and happiness'),
    (type_id, 'Elated', 'Extremely happy and excited'),
    (type_id, 'Ecstatic', 'Feeling or expressing overwhelming happiness'),
    (type_id, 'Overjoyed', 'Extremely joyful; delighted'),
    (type_id, 'Jubilant', 'Feeling or expressing great happiness and triumph'),
    (type_id, 'Euphoric', 'Characterized by intense feelings of well-being and happiness'),
    (type_id, 'Exultant', 'Triumphantly happy'),
    (type_id, 'Enraptured', 'Filled with delight and wonder'),
    (type_id, 'Blissful', 'Perfect happiness; serene joy'),
    (type_id, 'Beatific', 'Showing or feeling supreme happiness'),
    (type_id, 'Rapturous', 'Characterized by, feeling, or expressing great pleasure'),
    (type_id, 'Delirious', 'In a state of wild excitement or ecstasy');

  -- Slang type for Happiness/Joy
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (happiness_subcat_id, 'Slang')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Chilled', 'Relaxed and content'),
    (type_id, 'Vibing', 'In a state of harmony or agreement with someone or something'),
    (type_id, 'Jazzed', 'Very excited or enthusiastic'),
    (type_id, 'Lit', 'Exciting or excellent'),
    (type_id, 'Pumped', 'Very excited or enthusiastic'),
    (type_id, 'Stoked', 'Very excited or enthusiastic'),
    (type_id, 'Yasss', 'Enthusiastic agreement or approval');

  -- Compound/Phrasal type for Happiness/Joy
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (happiness_subcat_id, 'Compound/Phrasal')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Feeling sunny', 'Having a bright, optimistic outlook'),
    (type_id, 'In high spirits', 'Very happy and cheerful'),
    (type_id, 'Full of beans', 'Full of energy and enthusiasm'),
    (type_id, 'Tickled pink', 'Very pleased or amused'),
    (type_id, 'Happy as a clam', 'Very happy and content'),
    (type_id, 'On a high', 'Feeling euphoric or extremely happy'),
    (type_id, 'Riding high', 'Experiencing success or good fortune'),
    (type_id, 'Over the moon', 'Extremely happy or delighted'),
    (type_id, 'On cloud nine', 'In a state of extreme happiness'),
    (type_id, 'In seventh heaven', 'In a state of perfect happiness'),
    (type_id, 'Living my best life', 'Experiencing life at its most enjoyable or successful');

  -- Metaphorical type for Happiness/Joy
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (happiness_subcat_id, 'Metaphorical')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Like a ray of sunshine', 'Bringing happiness and brightness to a situation'),
    (type_id, 'Walking on sunshine', 'Feeling extremely happy and carefree'),
    (type_id, 'Grinning from ear to ear', 'Smiling very broadly with happiness'),
    (type_id, 'Sparkling', 'Shining with happiness or excitement'),
    (type_id, 'Glowing', 'Radiating happiness or well-being'),
    (type_id, 'On fire', 'Performing or feeling exceptionally well'),
    (type_id, 'Bursting with joy', 'Filled with extreme happiness'),
    (type_id, 'Beaming like the sun', 'Radiating happiness very brightly'),
    (type_id, 'Floating on air', 'Feeling extremely happy and lighthearted'),
    (type_id, 'Lit from within', 'Glowing with inner happiness'),
    (type_id, 'Shining like a diamond', 'Radiating exceptional happiness and brilliance');

END $$;