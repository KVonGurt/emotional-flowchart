import { EmotionCategory } from '../../types';

export const negativeEmotions: EmotionCategory = {
  name: "NEGATIVE EMOTIONS",
  subcategories: [
    {
      name: "Sadness/Grief",
      types: [
        {
          name: "Core",
          words: [
            { word: "Blue", definition: "Feeling sad or depressed" },
            { word: "Low", definition: "Feeling depressed or unhappy" },
            { word: "Downcast", definition: "Feeling discouraged or sad" },
            { word: "Bummed", definition: "Feeling disappointed or depressed" },
            { word: "Gloomy", definition: "Feeling dark or depressed" },
            { word: "Morose", definition: "Sullen and ill-tempered" },
            { word: "Wistful", definition: "Full of melancholy longing" },
            { word: "Hurt", definition: "Feeling emotional pain" },
            { word: "Doleful", definition: "Expressing sorrow; mournful" },
            { word: "Melancholic", definition: "Feeling deep sadness or gloom" }
            // ... Continue with other core sadness words
          ]
        }
        // ... Continue with other sadness types
      ]
    }
    // ... Continue with other negative emotion subcategories
  ]
};