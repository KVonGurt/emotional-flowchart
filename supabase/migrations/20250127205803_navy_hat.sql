DO $$ 
DECLARE
  positive_cat_id uuid;
  negative_cat_id uuid;
  neutral_cat_id uuid;
  happiness_subcat_id uuid;
  sadness_subcat_id uuid;
  anger_subcat_id uuid;
  fear_subcat_id uuid;
  love_subcat_id uuid;
  energy_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Get existing category IDs
  SELECT id INTO positive_cat_id FROM categories WHERE name = 'POSITIVE EMOTIONS';
  SELECT id INTO negative_cat_id FROM categories WHERE name = 'NEGATIVE EMOTIONS';
  SELECT id INTO neutral_cat_id FROM categories WHERE name = 'NEUTRAL/MIXED EMOTIONS';

  -- Get subcategory IDs
  SELECT id INTO happiness_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Happiness/Joy';
  SELECT id INTO sadness_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Sadness/Grief';
  SELECT id INTO anger_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Anger/Frustration';
  SELECT id INTO fear_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Fear/Anxiety';
  SELECT id INTO love_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Love/Connection';
  SELECT id INTO energy_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Energy/Enthusiasm';

  -- Add more Slang happiness words (increasing intensity)
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = happiness_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Feeling myself', 'Confident and content with oneself'),
    (type_id, 'Big mood', 'Strongly relating to a positive feeling'),
    (type_id, 'Slay', 'Doing exceptionally well'),
    (type_id, 'No cap', 'Being completely honest about feeling good'),
    (type_id, 'Living rent free', 'Constantly enjoying a thought or feeling'),
    (type_id, 'Main character energy', 'Feeling like everything is going your way'),
    (type_id, 'Understood the assignment', 'Excelling at something'),
    (type_id, 'Ate that', 'Did something exceptionally well'),
    (type_id, 'Serving', 'Presenting oneself excellently'),
    (type_id, 'It''s giving winner', 'Displaying successful or winning qualities');

  -- Add more Compound/Phrasal happiness expressions (increasing intensity)
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = happiness_subcat_id AND name = 'Compound/Phrasal';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Bright-eyed and bushy-tailed', 'Cheerful and ready for anything'),
    (type_id, 'Walking on air', 'Feeling extremely happy'),
    (type_id, 'Heart full of sunshine', 'Feeling completely happy and content'),
    (type_id, 'Dancing on clouds', 'Feeling extremely joyful and carefree'),
    (type_id, 'Jumping for joy', 'Extremely happy and excited'),
    (type_id, 'On top of the world', 'Feeling extremely happy and successful');

  -- Add more Slang love/connection expressions (increasing intensity)
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = love_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Catching feels', 'Beginning to develop romantic feelings'),
    (type_id, 'Heart eyes', 'Expressing strong admiration or love'),
    (type_id, 'Soft spot', 'Having particular affection for someone'),
    (type_id, 'Simping', 'Showing excessive affection or attention'),
    (type_id, 'Twin flame', 'Perfect spiritual match'),
    (type_id, 'Whole heart type beat', 'Complete and sincere love');

  -- Add more Slang energy/enthusiasm expressions (increasing intensity)
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = energy_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Feeling it', 'Experiencing good energy and enthusiasm'),
    (type_id, 'In the zone', 'Completely focused and energized'),
    (type_id, 'Beast mode', 'Operating at maximum energy and efficiency'),
    (type_id, 'Cracked', 'Performing exceptionally well'),
    (type_id, 'Built different', 'Uniquely capable or energetic'),
    (type_id, 'Leveled up', 'Reached a new level of performance or energy');

  -- Add more Slang sadness expressions (increasing intensity)
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = sadness_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Meh', 'Feeling unenthusiastic or down'),
    (type_id, 'Not it', 'Feeling disappointed or sad'),
    (type_id, 'Big sad', 'Experiencing significant sadness'),
    (type_id, 'Dead inside', 'Feeling emotionally numb'),
    (type_id, 'Can''t even', 'Unable to handle emotional situation'),
    (type_id, 'Hitting different', 'Affecting one particularly strongly');

  -- Add more Slang anger expressions (increasing intensity)
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = anger_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Salty', 'Slightly annoyed or bitter'),
    (type_id, 'Pressed', 'Agitated or annoyed'),
    (type_id, 'Throwing shade', 'Expressing disapproval or annoyance'),
    (type_id, 'Triggered', 'Becoming suddenly angry or upset'),
    (type_id, 'Tilted', 'Very frustrated or angry'),
    (type_id, 'Malding', 'Extremely angry and frustrated');

  -- Add more Slang fear/anxiety expressions (increasing intensity)
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = fear_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Sweating bullets', 'Very nervous or anxious'),
    (type_id, 'Shook', 'Shocked or scared'),
    (type_id, 'Sketched out', 'Feeling uneasy or suspicious'),
    (type_id, 'Buggin''', 'Feeling very worried or anxious'),
    (type_id, 'Losing it', 'Experiencing extreme anxiety'),
    (type_id, 'Going through it', 'Experiencing difficult emotions');

  -- Add Compound/Phrasal expressions for various emotions
  -- Love/Connection
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = love_subcat_id AND name = 'Compound/Phrasal';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Soul meets soul', 'Deep spiritual connection'),
    (type_id, 'Hearts intertwined', 'Deeply connected emotionally'),
    (type_id, 'Love at first sight', 'Immediate strong attraction'),
    (type_id, 'Match made in heaven', 'Perfect partnership'),
    (type_id, 'Written in the stars', 'Destined connection');

  -- Add Metaphorical expressions for various emotions
  -- Fear/Anxiety
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (fear_subcat_id, 'Metaphorical')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Walking on thin ice', 'In a precarious situation'),
    (type_id, 'Heart in throat', 'Feeling intense anxiety'),
    (type_id, 'World closing in', 'Feeling overwhelmed by fear'),
    (type_id, 'Shadows closing in', 'Growing sense of fear or dread'),
    (type_id, 'Walls have eyes', 'Feeling watched or paranoid');

END $$;