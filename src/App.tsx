import React, { useState, useEffect } from 'react';
import { Sparkles, Cloud, CircleDot, ArrowLeft, Info } from 'lucide-react';
import emotionsData from './data/emotions/emotions_data.json';

// Update EmotionState to use strings instead of IDs
type EmotionState = {
  category: string | null;
  subcategory: string | null;
  type: string | null;
};

const categoryIcons: { [key: string]: React.ReactNode } = {
  "POSITIVE EMOTIONS": <Sparkles className="w-5 h-5 text-yellow-400" />,
  "NEGATIVE EMOTIONS": <Cloud className="w-5 h-5 text-gray-400" />,
  "NEUTRAL/MIXED EMOTIONS": <CircleDot className="w-5 h-5 text-purple-400" />
};

const getCategoryStyle = (categoryName: string) => {
  switch(categoryName) {
    case "POSITIVE EMOTIONS":
      return "from-blue-500 to-indigo-600 hover:from-blue-600 hover:to-indigo-700";
    case "NEGATIVE EMOTIONS":
      return "from-slate-700 to-slate-800 hover:from-slate-800 hover:to-slate-900";
    case "NEUTRAL/MIXED EMOTIONS":
      return "from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600";
    default:
      return "from-blue-500 to-indigo-600";
  }
};

const getAccentColor = (categoryName: string) => {
  switch(categoryName) {
    case "POSITIVE EMOTIONS":
      return "text-blue-600";
    case "NEGATIVE EMOTIONS":
      return "text-slate-800";
    case "NEUTRAL/MIXED EMOTIONS":
      return "text-purple-600";
    default:
      return "text-gray-800";
  }
};

const capitalizeFirstWord = (text: string) => {
  return text.charAt(0).toUpperCase() + text.slice(1).toLowerCase();
};

function App() {
  const [selected, setSelected] = useState<EmotionState>({
    category: null,
    subcategory: null,
    type: null
  });
  const [selectedWord, setSelectedWord] = useState<string | null>(null);
  const [categories, setCategories] = useState<any[]>([]);
  const [subcategories, setSubcategories] = useState<any[]>([]);
  const [emotionTypes, setEmotionTypes] = useState<any[]>([]);
  const [currentCategory, setCurrentCategory] = useState<string>("");

  useEffect(() => {
    setCategories(emotionsData);
  }, []);

  useEffect(() => {
    if (selected.category) {
      // Find subcategories from the selected category using name
      const category = categories.find(c => c.name === selected.category);
      setSubcategories(category?.subcategories || []);
      setCurrentCategory(category?.name || "");
    }
  }, [selected.category, categories]);

  useEffect(() => {
    if (selected.subcategory) {
      // Find emotion types from the selected subcategory using name
      const category = categories.find(c => c.name === selected.category);
      const subcategory = category?.subcategories.find(s => s.name === selected.subcategory);
      setEmotionTypes(subcategory?.emotion_types || []);
    }
  }, [selected.subcategory, categories, selected.category]);

  const handleReset = () => {
    setSelected({
      category: null,
      subcategory: null,
      type: null
    });
    setSelectedWord(null);
    setCurrentCategory("");
  };

  const handleBack = () => {
    if (selected.subcategory) {
      setSelected({ ...selected, subcategory: null });
      setSelectedWord(null);
    } else if (selected.category) {
      setSelected({ ...selected, category: null });
      setCurrentCategory("");
    }
  };

  const renderCategories = () => (
    <div className="grid grid-cols-1 md:grid-cols-3 gap-6 w-full max-w-6xl">
      {categories.map((category) => (
        <button
          key={category.name}
          onClick={() => setSelected({ ...selected, category: category.name })}
          className={`p-8 rounded-2xl shadow-lg hover:shadow-xl transition-all transform hover:-translate-y-1 bg-gradient-to-br ${getCategoryStyle(category.name)}`}
        >
          <div className="flex items-center justify-center gap-3">
            <div className="bg-white/20 p-2 rounded-lg">
              {categoryIcons[category.name]}
            </div>
            <h3 className="text-xl font-bold text-white">{category.name}</h3>
          </div>
        </button>
      ))}
    </div>
  );

  const renderSubcategories = () => (
    <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-4 w-full max-w-6xl">
      {subcategories.map((sub) => (
        <button
          key={sub.name}
          onClick={() => setSelected({ ...selected, subcategory: sub.name })}
          className={`p-6 bg-white rounded-xl shadow-md hover:shadow-lg transition-all border border-gray-100 hover:-translate-y-0.5 transform group`}
        >
          <h3 className={`text-lg font-semibold text-center ${getAccentColor(currentCategory)} group-hover:opacity-80 transition-opacity`}>
            {capitalizeFirstWord(sub.name)}
          </h3>
        </button>
      ))}
    </div>
  );

  const renderEmotionTypes = () => (
    <div className="w-full max-w-6xl space-y-6">
      {emotionTypes.map((type) => (
        <div key={type.name} className="bg-white rounded-xl shadow-md border border-gray-100 overflow-hidden">
          <h3 className={`text-lg font-semibold px-6 py-4 ${getAccentColor(currentCategory)} border-b border-gray-100`}>
            {capitalizeFirstWord(type.name)}
          </h3>
          <div className="p-6">
            <div className="flex flex-wrap gap-3">
              {type.emotion_words.map((wordObj: any) => (
                <div key={wordObj.word} className="relative group">
                  <button
                    onClick={() => setSelectedWord(selectedWord === wordObj.word ? null : wordObj.word)}
                    className={`px-4 py-2.5 bg-white rounded-lg text-sm font-medium hover:bg-gray-50 transition-colors flex items-center gap-2 border border-gray-200 hover:border-gray-300 ${getAccentColor(currentCategory)}`}
                  >
                    {capitalizeFirstWord(wordObj.word)}
                    <Info className="w-3.5 h-3.5 opacity-60" />
                  </button>
                  {selectedWord === wordObj.word && (
                    <div className="absolute z-10 p-4 bg-white rounded-lg shadow-xl border border-gray-200 text-sm text-gray-600 min-w-[280px] max-w-[400px] whitespace-normal break-words bottom-[calc(100%+0.5rem)] right-0 sm:right-auto sm:left-1/2 sm:-translate-x-1/2">
                      {wordObj.definition}
                    </div>
                  )}
                </div>
              ))}
            </div>
          </div>
        </div>
      ))}
    </div>
  );

  return (
    <div className="min-h-screen bg-white p-6">
      <div className="max-w-7xl mx-auto">
        <div className="text-center mb-12">
          <button
            onClick={handleReset}
            className="group"
          >
            <h1 className="text-4xl font-bold mb-3 bg-gradient-to-r from-gray-800 to-gray-600 bg-clip-text text-transparent group-hover:from-gray-700 group-hover:to-gray-500 transition-all">
              Emotional Flowchart
            </h1>
            <p className="text-gray-600 font-medium">Discover the perfect words to express how you feel</p>
          </button>
        </div>

        {(selected.category || selected.subcategory) && (
          <button
            onClick={handleBack}
            className={`mb-8 flex items-center transition-colors px-4 py-2 rounded-lg text-sm font-medium border hover:bg-gray-50 ${getAccentColor(currentCategory)}`}
          >
            <ArrowLeft className="w-4 h-4 mr-2" />
            Back
          </button>
        )}

        <div className="flex flex-col items-center space-y-8">
          {!selected.category && renderCategories()}
          {selected.category && !selected.subcategory && renderSubcategories()}
          {selected.category && selected.subcategory && renderEmotionTypes()}
        </div>
      </div>
    </div>
  );
}

export default App;