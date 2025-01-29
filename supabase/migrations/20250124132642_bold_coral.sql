/*
  # Add new emotion categories and words

  1. New Subcategories
    - Love/Connection (under Positive Emotions)
    - Energy/Enthusiasm (under Positive Emotions)
    - Trust/Security (under Positive Emotions)
    - Disgust/Contempt (under Negative Emotions)
    - Guilt/Shame (under Negative Emotions)

  2. Changes
    - Add new word "Gleeful" to Happiness/Joy
    - Add new words to existing categories
    - Add new types (Core, Slang, Compound/Phrasal, Metaphorical, Cultural) for new subcategories

  3. Security
    - Maintains existing RLS policies
*/

DO $$ 
DECLARE
  positive_cat_id uuid;
  negative_cat_id uuid;
  love_subcat_id uuid;
  energy_subcat_id uuid;
  trust_subcat_id uuid;
  disgust_subcat_id uuid;
  guilt_subcat_id uuid;
  happiness_subcat_id uuid;
  type_id uuid;
BEGIN
  -- Get existing category IDs
  SELECT id INTO positive_cat_id FROM categories WHERE name = 'POSITIVE EMOTIONS';
  SELECT id INTO negative_cat_id FROM categories WHERE name = 'NEGATIVE EMOTIONS';
  SELECT id INTO happiness_subcat_id FROM subcategories WHERE category_id = positive_cat_id AND name = 'Happiness/Joy';

  -- Add "Gleeful" to Happiness/Joy Core type
  SELECT id INTO type_id FROM emotion_types WHERE subcategory_id = happiness_subcat_id AND name = 'Core';
  INSERT INTO emotion_words (type_id, word, definition)
  VALUES (type_id, 'Gleeful', 'Feeling great delight or joy');

  -- Love/Connection subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (positive_cat_id, 'Love/Connection')
  RETURNING id INTO love_subcat_id;

  -- Core type for Love/Connection
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (love_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Fond', 'Having an affection or liking for'),
    (type_id, 'Close', 'Having a strong emotional connection'),
    (type_id, 'Warm', 'Showing enthusiasm, affection, or kindness'),
    (type_id, 'Affectionate', 'Showing caring and warm feelings'),
    (type_id, 'Caring', 'Feeling and exhibiting concern and empathy'),
    (type_id, 'Tender', 'Showing gentle affection'),
    (type_id, 'Doting', 'Extremely and uncritically fond of someone'),
    (type_id, 'Smitten', 'Deeply affected by love'),
    (type_id, 'Cherished', 'Held dear'),
    (type_id, 'Swooning', 'Overwhelmed by romantic feelings'),
    (type_id, 'Devoted', 'Very loving and loyal'),
    (type_id, 'Beloved', 'Dearly loved'),
    (type_id, 'Enamored', 'Filled with love'),
    (type_id, 'Ardent', 'Characterized by intense feeling'),
    (type_id, 'Treasured', 'Regarded with love and affection'),
    (type_id, 'Passionate', 'Having intense feelings or emotions'),
    (type_id, 'Reverent', 'Feeling deep respect and love'),
    (type_id, 'Amorous', 'Showing romantic love'),
    (type_id, 'Infatuated', 'Inspired with intense love or admiration'),
    (type_id, 'Besotted', 'Strongly infatuated'),
    (type_id, 'Adoring', 'Feeling deep love and respect');

  -- Compound/Phrasal type for Love/Connection
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (love_subcat_id, 'Compound/Phrasal')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Heart-to-heart', 'An intimate, sincere conversation'),
    (type_id, 'Head over heels', 'Completely in love'),
    (type_id, 'Ironclad loyalty', 'Unbreakable faithfulness'),
    (type_id, 'Steadfast', 'Firmly fixed in place; unwavering'),
    (type_id, 'Bound together', 'Connected by strong ties'),
    (type_id, 'Ride or die', 'Loyal until the end'),
    (type_id, 'Joined at the hip', 'Inseparable'),
    (type_id, 'One soul, two bodies', 'Deeply connected spiritually'),
    (type_id, 'Attached at the heart', 'Emotionally inseparable');

  -- Metaphorical type for Love/Connection
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (love_subcat_id, 'Metaphorical')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Two peas in a pod', 'Very similar and close'),
    (type_id, 'Heart of gold', 'Very kind and caring'),
    (type_id, 'Fire in the belly', 'Strong passion or determination'),
    (type_id, 'Kindred spirits', 'Similar in nature or character'),
    (type_id, 'Magnetic souls', 'Naturally drawn to each other'),
    (type_id, 'Ice in the veins', 'Calm under pressure'),
    (type_id, 'Intertwined roots', 'Deeply connected lives');

  -- Cultural type for Love/Connection
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (love_subcat_id, 'Cultural')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Hygge', 'Danish concept of cozy contentment'),
    (type_id, 'Ubuntu', 'African concept of communal bond'),
    (type_id, 'Kilig', 'Filipino word for romantic thrill'),
    (type_id, 'Ya''aburnee', 'Arabic phrase expressing desire not to live without the beloved'),
    (type_id, 'Meraki', 'Greek word for doing something with soul/love'),
    (type_id, 'Pyaar', 'Hindi word for love');

  -- Energy/Enthusiasm subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (positive_cat_id, 'Energy/Enthusiasm')
  RETURNING id INTO energy_subcat_id;

  -- Core type for Energy/Enthusiasm
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (energy_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Eager', 'Wanting to do or have something very much'),
    (type_id, 'Peppy', 'Full of energy and high spirits'),
    (type_id, 'Sprightly', 'Full of life and energy'),
    (type_id, 'Bouncy', 'Lively and energetic'),
    (type_id, 'Brisk', 'Active and energetic'),
    (type_id, 'Animated', 'Full of life or excitement'),
    (type_id, 'Zippy', 'Lively and full of energy'),
    (type_id, 'Zesty', 'Characterized by great enthusiasm and energy'),
    (type_id, 'Bubbly', 'Cheerful and full of energy'),
    (type_id, 'High-spirited', 'Full of energy and enthusiasm'),
    (type_id, 'Lively', 'Full of life and energy'),
    (type_id, 'Energetic', 'Showing great activity or vitality'),
    (type_id, 'Vibrant', 'Full of energy and life'),
    (type_id, 'Dynamic', 'Characterized by constant change or activity'),
    (type_id, 'Exuberant', 'Filled with lively energy'),
    (type_id, 'Ebullient', 'Cheerful and full of energy'),
    (type_id, 'Fervent', 'Having or showing great warmth or intensity of spirit'),
    (type_id, 'Electric', 'Thrilling, exciting'),
    (type_id, 'Full-throttle', 'Using or proceeding with full power or force'),
    (type_id, 'Frenetic', 'Fast and energetic in a wild way'),
    (type_id, 'Manic', 'Characterized by great energy'),
    (type_id, 'Zealous', 'Having great energy or enthusiasm');

  -- Slang type for Energy/Enthusiasm
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (energy_subcat_id, 'Slang')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Gucci', 'Feeling good or doing well'),
    (type_id, 'Turnt', 'Excited and energetic'),
    (type_id, 'Amped', 'Very excited or energized'),
    (type_id, 'GOAT mode', 'Performing at peak level'),
    (type_id, 'Hyped', 'Very excited and energetic'),
    (type_id, 'Buzzin''', 'Feeling excited and energetic'),
    (type_id, 'Psyched', 'Very excited');

  -- Trust/Security subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (positive_cat_id, 'Trust/Security')
  RETURNING id INTO trust_subcat_id;

  -- Core type for Trust/Security
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (trust_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Comforted', 'Feeling at ease and supported'),
    (type_id, 'Guarded', 'Protected and safe'),
    (type_id, 'Sheltered', 'Protected from harm'),
    (type_id, 'Secure', 'Free from danger or threat'),
    (type_id, 'Safe', 'Protected from harm or risk'),
    (type_id, 'Assured', 'Confident and free from doubt'),
    (type_id, 'Reassured', 'Having confidence restored'),
    (type_id, 'Stable', 'Firmly established'),
    (type_id, 'Steady', 'Firmly fixed or supported'),
    (type_id, 'Trusting', 'Willing to rely on someone'),
    (type_id, 'Reliable', 'Consistently good in quality or performance'),
    (type_id, 'Anchored', 'Firmly fixed in place'),
    (type_id, 'Rooted', 'Firmly established'),
    (type_id, 'Protected', 'Kept safe from harm'),
    (type_id, 'Revered', 'Deeply respected and trusted');

  -- Disgust/Contempt subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (negative_cat_id, 'Disgust/Contempt')
  RETURNING id INTO disgust_subcat_id;

  -- Core type for Disgust/Contempt
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (disgust_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Icky', 'Feeling disgust or distaste'),
    (type_id, 'Meh', 'Unimpressed or unenthusiastic'),
    (type_id, 'Off-putting', 'Unpleasant or disconcerting'),
    (type_id, 'Off', 'Not quite right or normal'),
    (type_id, 'Grossed out', 'Disgusted'),
    (type_id, 'Averse', 'Having a strong dislike'),
    (type_id, 'Revolted', 'Feeling intense disgust'),
    (type_id, 'Nauseated', 'Feeling sick with disgust'),
    (type_id, 'Nauseous', 'Affected with nausea'),
    (type_id, 'Queasy', 'Feeling sick or nauseated'),
    (type_id, 'Repulsed', 'Feeling strong dislike or aversion'),
    (type_id, 'Loathing', 'Feeling intense dislike or disgust'),
    (type_id, 'Detestable', 'Deserving intense dislike'),
    (type_id, 'Abhorrent', 'Inspiring disgust and loathing'),
    (type_id, 'Vile', 'Morally bad; wicked'),
    (type_id, 'Foul', 'Offensive to the senses');

  -- Guilt/Shame subcategory
  INSERT INTO subcategories (category_id, name)
  VALUES (negative_cat_id, 'Guilt/Shame')
  RETURNING id INTO guilt_subcat_id;

  -- Core type for Guilt/Shame
  INSERT INTO emotion_types (subcategory_id, name)
  VALUES (guilt_subcat_id, 'Core')
  RETURNING id INTO type_id;

  INSERT INTO emotion_words (type_id, word, definition) VALUES
    (type_id, 'Sheepish', 'Embarrassed due to shame or guilt'),
    (type_id, 'Guilty', 'Feeling responsible for wrongdoing'),
    (type_id, 'Embarrassed', 'Feeling awkward or ashamed'),
    (type_id, 'Abashed', 'Embarrassed or ashamed'),
    (type_id, 'Chagrined', 'Feeling distressed by failure'),
    (type_id, 'Ashamed', 'Feeling shame or guilt'),
    (type_id, 'Regretful', 'Full of regret'),
    (type_id, 'Remorseful', 'Filled with remorse'),
    (type_id, 'Contrite', 'Feeling genuine remorse'),
    (type_id, 'Humiliated', 'Made to feel ashamed or foolish'),
    (type_id, 'Mortified', 'Feeling very ashamed or embarrassed'),
    (type_id, 'Degraded', 'Reduced to a lower rank'),
    (type_id, 'Disgraced', 'Having lost reputation or respect');

END $$;