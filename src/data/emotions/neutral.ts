import { EmotionCategory } from '../../types';

export const neutralEmotions: EmotionCategory = {
  name: "NEUTRAL/MIXED EMOTIONS",
  subcategories: [
    {
      name: "Curiosity/Interest",
      types: [
        {
          name: "Core",
          words: [
            { word: "Piqued", definition: "Having one's interest or curiosity aroused" },
            { word: "Interested", definition: "Showing curiosity or concern about something" },
            { word: "Inquiring", definition: "Having or showing an interest in learning more" },
            { word: "Curious", definition: "Eager to learn or know more" },
            { word: "Intrigued", definition: "Very interested or curious about something" }
            // ... Continue with other curiosity words
          ]
        }
        // ... Continue with other curiosity types
      ]
    }
    // ... Continue with other neutral emotion subcategories
  ]
};