import React, { useState, useEffect } from 'react';
import { Sparkles, Cloud, CircleDot, ArrowLeft, Info, X } from 'lucide-react';
import emotionsData from './data/emotions/emotions_data.json';

// Add these type definitions at the top of the file with other types
interface EmotionWord {
  word: string;
  definition: string;
}

interface EmotionType {
  name: string;
  emotion_words: EmotionWord[];
}

interface Subcategory {
  name: string;
  emotion_types: EmotionType[];
}

interface Category {
  name: string;
  subcategories: Subcategory[];
}

// Update EmotionState to use strings instead of IDs
type EmotionState = {
  category: string | null;
  subcategory: string | null;
  type: string | null;
};

// Add these types near the top with other types
type DictionaryResponse = {
  word: string;
  phonetic?: string;
  phonetics: {
    text?: string;
    audio?: string;
  }[];
  origin?: string;
  meanings: {
    partOfSpeech: string;
    definitions: {
      definition: string;
      example?: string;
      synonyms?: string[];
      antonyms?: string[];
    }[];
    synonyms?: string[];
    antonyms?: string[];
  }[];
  sourceUrls?: string[];
} | null;

// Update the SelectedWordInfo type to use a more specific type for rawResponse
type SelectedWordInfo = {
  word: string;
  dictionaryData: DictionaryResponse;
  loading: boolean;
  error?: string;
  // Replace any with DictionaryApiResponse type
  rawResponse?: DictionaryApiResponse[];
} | null;

// Add this new type for the Dictionary API response
type DictionaryApiResponse = {
  word: string;
  phonetic?: string;
  phonetics: {
    text?: string;
    audio?: string;
  }[];
  meanings: {
    partOfSpeech: string;
    definitions: {
      definition: string;
      example?: string;
      synonyms?: string[];
      antonyms?: string[];
    }[];
    synonyms?: string[];
    antonyms?: string[];
  }[];
  sourceUrls?: string[];
  origin?: string;
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
  const [selectedWord, setSelectedWord] = useState<SelectedWordInfo>(null);
  const [categories, setCategories] = useState<Category[]>([]);
  const [subcategories, setSubcategories] = useState<Subcategory[]>([]);
  const [emotionTypes, setEmotionTypes] = useState<EmotionType[]>([]);
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

  // Add this function to handle closing the modal
  const closeModal = () => {
    setSelectedWord(null);
  };

  const findWordInEmotionsData = (word: string): { word: string, definition: string } | null => {
    for (const category of emotionsData) {
      for (const subcategory of category.subcategories) {
        for (const emotionType of subcategory.emotion_types) {
          const foundWord = emotionType.emotion_words.find(
            w => w.word.toLowerCase() === word.toLowerCase()
          );
          if (foundWord) {
            return foundWord;
          }
        }
      }
    }
    return null;
  };

  const fetchWordDefinition = async (word: string, originalDefinition: string) => {
    setSelectedWord({
      word,
      dictionaryData: null,
      loading: true
    });

    try {
      const response = await fetch(`https://api.dictionaryapi.dev/api/v2/entries/en/${word}`);
      if (!response.ok) {
        // Instead of throwing error, fall back to emotions data
        const localWord = findWordInEmotionsData(word);
        if (!localWord) {
          throw new Error('Word not found in dictionary or local data');
        }
        
        setSelectedWord({
          word: localWord.word,
          dictionaryData: {
            word: localWord.word,
            phonetics: [],
            meanings: [{
              partOfSpeech: 'definition',
              definitions: [{
                definition: localWord.definition
              }]
            }]
          },
          loading: false,
          rawResponse: null
        });
        return;
      }
      
      const data = await response.json();
      setSelectedWord({
        word,
        dictionaryData: {
          word,
          phonetics: data[0].phonetics || [],
          meanings: data[0].meanings,
          sourceUrls: data[0].sourceUrls,
          phonetic: data[0].phonetic,
          origin: data[0].origin
        },
        loading: false,
        rawResponse: data
      });
    } catch (error) {
      // Final fallback using the passed originalDefinition
      setSelectedWord({
        word,
        dictionaryData: {
          word,
          phonetics: [],
          meanings: [{
            partOfSpeech: 'definition',
            definitions: [{
              definition: originalDefinition
            }]
          }]
        },
        loading: false,
        error: error instanceof Error ? error.message : 'Failed to fetch definition',
        rawResponse: null
      });
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
              {type.emotion_words.map((wordObj: EmotionWord) => (
                <button
                  key={wordObj.word}
                  onClick={() => fetchWordDefinition(wordObj.word, wordObj.definition)}
                  className={`px-4 py-2.5 bg-white rounded-lg text-sm font-medium hover:bg-gray-50 transition-colors flex items-center gap-2 border border-gray-200 hover:border-gray-300 ${getAccentColor(currentCategory)}`}
                >
                  {capitalizeFirstWord(wordObj.word)}
                  <Info className="w-3.5 h-3.5 opacity-60" />
                </button>
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

      {/* Modal */}
      {selectedWord && (
        <div className="fixed inset-0 bg-black/50 flex items-center justify-center p-4 z-50">
          <div className="bg-white rounded-xl max-w-lg w-full shadow-2xl max-h-[90vh] flex flex-col">
            <div className="flex items-center justify-between p-4 border-b sticky top-0 bg-white rounded-t-xl z-10">
              <h3 className={`text-xl font-semibold ${getAccentColor(currentCategory)}`}>
                {capitalizeFirstWord(selectedWord.word)}
              </h3>
              <button
                onClick={closeModal}
                className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
              >
                <X className="w-5 h-5 text-gray-500" />
              </button>
            </div>
            <div className="overflow-y-auto">
              <div className="p-6">
                {selectedWord.loading ? (
                  <div className="text-gray-600">Loading definition...</div>
                ) : selectedWord.error ? (
                  <div className="text-red-500">{selectedWord.error}</div>
                ) : selectedWord.dictionaryData ? (
                  <div className="space-y-6">
                    {/* Phonetics Section */}
                    {(selectedWord.dictionaryData.phonetic || selectedWord.dictionaryData.phonetics.length > 0) && (
                      <div className="space-y-3">
                        <h4 className="font-medium text-gray-700">Pronunciation</h4>
                        {selectedWord.dictionaryData.phonetic && 
                         !selectedWord.dictionaryData.phonetics.some(p => p.text === selectedWord.dictionaryData?.phonetic) && (
                          <div className="text-gray-600">{selectedWord.dictionaryData.phonetic}</div>
                         )}
                        {selectedWord.dictionaryData.phonetics.map((phonetic, index) => (
                          <div key={index} className="flex items-center gap-3">
                            {phonetic.text && <span className="text-gray-600">{phonetic.text}</span>}
                            {phonetic.audio && phonetic.audio !== "" && (
                              <button
                                onClick={() => new Audio(phonetic.audio).play()}
                                className="px-3 py-1 text-sm bg-gray-100 hover:bg-gray-200 rounded-md text-gray-700 transition-colors"
                              >
                                Play Audio
                              </button>
                            )}
                          </div>
                        ))}
                      </div>
                    )}

                    {/* Origin Section */}
                    {selectedWord.dictionaryData.origin && (
                      <div className="space-y-2">
                        <h4 className="font-medium text-gray-700">Origin</h4>
                        <p className="text-gray-600">{selectedWord.dictionaryData.origin}</p>
                      </div>
                    )}

                    {/* Meanings Section */}
                    <div className="space-y-6">
                      {selectedWord.dictionaryData.meanings.map((meaning, index) => (
                        <div key={index} className="space-y-3">
                          <h4 className="font-medium text-gray-700 italic">
                            {meaning.partOfSpeech}
                          </h4>
                          
                          {/* Definitions */}
                          <div className="space-y-4">
                            {meaning.definitions.map((def, defIndex) => (
                              <div key={defIndex} className="space-y-2">
                                <div className="flex gap-2">
                                  <span className="text-gray-400 min-w-[1.5rem]">{defIndex + 1}.</span>
                                  <span className="text-gray-600">{def.definition}</span>
                                </div>
                                
                                {def.example && (
                                  <p className="text-gray-500 italic ml-7">
                                    Example: "{def.example}"
                                  </p>
                                )}
                                
                                {def.synonyms && def.synonyms.length > 0 && (
                                  <div className="ml-7 text-sm">
                                    <span className="text-gray-500">Synonyms: </span>
                                    <span className="font-semibold">
                                      {[...new Set(def.synonyms)].join(", ")}
                                    </span>
                                  </div>
                                )}
                                
                                {def.antonyms && def.antonyms.length > 0 && (
                                  <div className="ml-7 text-sm">
                                    <span className="text-gray-500">Antonyms: </span>
                                    <span className="font-semibold">
                                      {[...new Set(def.antonyms)].join(", ")}
                                    </span>
                                  </div>
                                )}
                              </div>
                            ))}
                          </div>

                          {/* Part of Speech Level Synonyms */}
                          {meaning.synonyms && meaning.synonyms.length > 0 && (
                            <div className="pt-2 border-t">
                              <span className="text-gray-500 text-sm">Related synonyms: </span>
                              <span className="text-sm font-semibold">
                                {[...new Set(meaning.synonyms)].join(", ")}
                              </span>
                            </div>
                          )}

                          {/* Part of Speech Level Antonyms */}
                          {meaning.antonyms && meaning.antonyms.length > 0 && (
                            <div className="pt-2 border-t">
                              <span className="text-gray-500 text-sm">Related antonyms: </span>
                              <span className="text-sm font-semibold">
                                {[...new Set(meaning.antonyms)].join(", ")}
                              </span>
                            </div>
                          )}
                        </div>
                      ))}
                    </div>

                    {/* Source URLs */}
                    {selectedWord.dictionaryData.sourceUrls && selectedWord.dictionaryData.sourceUrls.length > 0 && (
                      <div className="pt-4 border-t text-sm text-gray-500">
                        <h4 className="font-medium text-gray-700 mb-2">Sources</h4>
                        <ul className="space-y-1">
                          {selectedWord.dictionaryData.sourceUrls.map((url, index) => (
                            <li key={index}>
                              <a 
                                href={url}
                                target="_blank"
                                rel="noopener noreferrer"
                                className="text-blue-600 hover:underline"
                              >
                                {url}
                              </a>
                            </li>
                          ))}
                        </ul>
                      </div>
                    )}
                  </div>
                ) : (
                  <div className="text-gray-600">No definition available</div>
                )}
              </div>
            </div>

            {/* Add Debug Panel */}
            {import.meta.env.VITE_SHOW_DEBUG === 'true' && (
              <div className="border-t">
                <details className="group">
                  <summary className="flex items-center justify-between p-4 cursor-pointer hover:bg-gray-50">
                    <span className="text-sm font-medium text-gray-600">Debug</span>
                    <svg
                      className="w-5 h-5 text-gray-500 transition-transform group-open:rotate-180"
                      xmlns="http://www.w3.org/2000/svg"
                      viewBox="0 0 20 20"
                      fill="currentColor"
                    >
                      <path
                        fillRule="evenodd"
                        d="M5.23 7.21a.75.75 0 011.06.02L10 11.168l3.71-3.938a.75.75 0 111.08 1.04l-4.25 4.5a.75.75 0 01-1.08 0l-4.25-4.5a.75.75 0 01.02-1.06z"
                        clipRule="evenodd"
                      />
                    </svg>
                  </summary>
                  <div className="p-4 border-t bg-gray-50">
                    <pre className="text-sm text-gray-700 whitespace-pre-wrap overflow-x-auto">
                      {selectedWord.rawResponse 
                        ? JSON.stringify(selectedWord.rawResponse, null, 2)
                        : 'Using fallback definition from local data'}
                    </pre>
                  </div>
                </details>
              </div>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

export default App;