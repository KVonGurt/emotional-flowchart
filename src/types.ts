export interface EmotionCategory {
  name: string;
  subcategories: EmotionSubcategory[];
}

export interface EmotionSubcategory {
  name: string;
  types: EmotionType[];
}

export interface EmotionType {
  name: string;
  words: EmotionWord[];
}

export interface EmotionWord {
  word: string;
  definition: string;
}

export interface EmotionState {
  category: string | null;
  subcategory: string | null;
  type: string | null;
}