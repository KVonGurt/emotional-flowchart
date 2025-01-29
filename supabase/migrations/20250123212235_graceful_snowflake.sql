/*
  # Add comprehensive emotion words set

  1. New Data
    - Adds extensive set of emotion words to all categories
    - All words fit "I'm feeling ___" format
    - Includes contemporary expressions and timeless emotions
    - Adds cultural/regional variations where appropriate

  2. Categories
    - Expands all existing emotion categories
    - Adds more nuanced expressions
    - Includes modern slang and metaphorical phrases
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
  exhaustion_subcat_id uuid;
  gratitude_subcat_id uuid;
  confidence_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Get category IDs
  SELECT id INTO positive_cat_id FROM categories WHERE name = 'POSITIVE EMOTIONS';
  SELECT id INTO negative_cat_id FROM categories WHERE name = 'NEGATIVE EMOTIONS';
  SELECT id INTO neutral_cat_id FROM categories WHERE name = 'NEUTRAL/MIXED EMOTIONS';

  -- Get existing subcategory IDs
  SELECT id INTO happiness_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Happiness/Joy';
  SELECT id INTO sadness_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Sadness/Grief';
  SELECT id INTO anger_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Anger/Frustration';
  SELECT id INTO fear_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Fear/Anxiety';
  SELECT id INTO exhaustion_subcat_id FROM subcategories WHERE category_id = negative_cat_id AND name = 'Exhaustion/Fatigue';
  SELECT id INTO gratitude_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Gratitude/Appreciation';
  SELECT id INTO confidence_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Confidence/Pride';

  -- Add more Core happiness/joy words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = happiness_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Alive', 'Full of energy and spirit'),
    (type_id, 'Energized', 'Filled with energy and enthusiasm'),
    (type_id, 'Inspired', 'Mentally stimulated to do something creative'),
    (type_id, 'Refreshed', 'Feeling renewed in mind or spirit'),
    (type_id, 'Optimistic', 'Hopeful and confident about the future'),
    (type_id, 'Renewed', 'Feeling fresh and energetic again'),
    (type_id, 'Elevated', 'Lifted up in spirit'),
    (type_id, 'Fulfilled', 'Satisfied or happy because of fully developing one''s abilities or character'),
    (type_id, 'Thrilled', 'Feeling intense excitement and pleasure'),
    (type_id, 'Enthusiastic', 'Having or showing intense interest or excitement');

  -- Add modern Slang happiness words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = happiness_subcat_id AND name = 'Slang';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Buzzed', 'Feeling excited and energetic'),
    (type_id, 'Glowing up', 'Experiencing positive personal growth or improvement'),
    (type_id, 'Winning', 'Experiencing success or achievement'),
    (type_id, 'Thriving', 'Prospering and growing'),
    (type_id, 'Zen', 'Peaceful and relaxed'),
    (type_id, 'Groovy', 'Feeling excellent or satisfying'),
    (type_id, 'Stellar', 'Feeling exceptionally good'),
    (type_id, 'Peachy', 'Feeling excellent or splendid'),
    (type_id, 'Epic', 'Feeling particularly impressive or remarkable'),
    (type_id, 'Legendary', 'Feeling remarkably good or impressive');

  -- Add more Core sadness words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = sadness_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Hollow', 'Feeling empty or without substance'),
    (type_id, 'Numb', 'Deprived of feeling or responsiveness'),
    (type_id, 'Fragile', 'Easily broken or damaged emotionally'),
    (type_id, 'Somber', 'Dark or gloomy in mood'),
    (type_id, 'Bereft', 'Deprived of or lacking something, especially a loved one'),
    (type_id, 'Disheartened', 'Having lost determination or confidence'),
    (type_id, 'Crestfallen', 'Sad and disappointed'),
    (type_id, 'Desolate', 'Feeling abandoned and alone'),
    (type_id, 'Inconsolable', 'Unable to be comforted'),
    (type_id, 'Melancholy', 'A deep and long-lasting sadness');

  -- Add more Core anger words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = anger_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Incensed', 'Very angry; enraged'),
    (type_id, 'Vexed', 'Annoyed, frustrated, or worried'),
    (type_id, 'Indignant', 'Feeling or showing anger because of something unjust'),
    (type_id, 'Agitated', 'Troubled or excited state'),
    (type_id, 'Provoked', 'Annoyed or angered by something'),
    (type_id, 'Irritable', 'Easily annoyed or made angry'),
    (type_id, 'Fuming', 'Extremely angry or irritated'),
    (type_id, 'Riled', 'Made angry or irritated'),
    (type_id, 'Cross', 'Annoyed or slightly angry'),
    (type_id, 'Disgruntled', 'Discontented and displeased');

  -- Add more Core fear/anxiety words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = fear_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Unnerved', 'Deprived of courage or confidence'),
    (type_id, 'Rattled', 'Feeling nervous, worried, or agitated'),
    (type_id, 'Tense', 'Unable to relax because of nervousness or anxiety'),
    (type_id, 'Jittery', 'Nervous or unable to relax'),
    (type_id, 'Skittish', 'Easily frightened or nervous'),
    (type_id, 'Flustered', 'Agitated or confused'),
    (type_id, 'Timid', 'Showing a lack of courage or confidence'),
    (type_id, 'Hesitant', 'Tentative or unsure'),
    (type_id, 'Queasy', 'Feeling sick or nervous'),
    (type_id, 'Frazzled', 'Exhausted or stressed out');

  -- Add more Core exhaustion/fatigue words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = exhaustion_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Depleted', 'Having used up energy or resources'),
    (type_id, 'Sluggish', 'Lacking energy or alertness'),
    (type_id, 'Lethargic', 'Lacking energy or enthusiasm'),
    (type_id, 'Drowsy', 'Sleepy and lethargic'),
    (type_id, 'Beat', 'Extremely tired or exhausted'),
    (type_id, 'Worn out', 'Extremely tired or exhausted'),
    (type_id, 'Rundown', 'Tired and in poor health'),
    (type_id, 'Overtired', 'Exhausted beyond normal tiredness'),
    (type_id, 'Wiped', 'Extremely tired'),
    (type_id, 'Zonked', 'Extremely tired or exhausted');

  -- Add more Core gratitude words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = gratitude_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Indebted', 'Feeling grateful for help received'),
    (type_id, 'Touched', 'Feeling appreciation or gratitude'),
    (type_id, 'Honored', 'Feeling respected or privileged'),
    (type_id, 'Fortunate', 'Feeling lucky or blessed'),
    (type_id, 'Humbled', 'Feeling modest or grateful'),
    (type_id, 'Valued', 'Feeling appreciated or worthwhile'),
    (type_id, 'Recognized', 'Feeling acknowledged or appreciated'),
    (type_id, 'Cherished', 'Feeling loved and appreciated'),
    (type_id, 'Acknowledged', 'Feeling recognized or appreciated'),
    (type_id, 'Supported', 'Feeling helped or encouraged');

  -- Add more Core confidence words
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = confidence_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Assured', 'Confident and free from doubt'),
    (type_id, 'Determined', 'Feeling firmly resolved or set in purpose'),
    (type_id, 'Fearless', 'Without fear; bold'),
    (type_id, 'Invincible', 'Too powerful to be defeated or overcome'),
    (type_id, 'Mighty', 'Possessing great and impressive power'),
    (type_id, 'Resolute', 'Admirably purposeful and unwavering'),
    (type_id, 'Tenacious', 'Holding firmly to a purpose'),
    (type_id, 'Unshakeable', 'Not able to be disputed or questioned'),
    (type_id, 'Validated', 'Having received confirmation or approval'),
    (type_id, 'Accomplished', 'Highly skilled or achieved');

END $$;