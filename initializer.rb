# frozen_string_literal: true

require 'lingua/stemmer'
require 'lemmatizer'
require 'stopwords'
require 'tokenizer'

# class
class NaturalLanguageProcessor
  def initialize(overrides = {})
    @lemmer = overrides.fetch(:lemmer) { Lemmatizer.new }
    @stemmer = overrides.fetch(:stemmer) { Lingua::Stemmer.new }
    @stopwords = overrides.fetch(:stopwords) { Stopwords }
    @tokenizer = overrides.fetch(:tokenizer) do
      Tokenizer::WhitespaceTokenizer.new(:en)
    end
  end

  def proccess(phrase = '')
    tokenize(phrase)
      .select { |word| valid_word?(word) }
      .map { |word| stem(word) }
      .map { |word| lemma(word) }
  end

  def stem(word = '')
    @stemmer.stem(word)
  end

  def tokenize(phrase = '')
    @tokenizer.tokenize(phrase)
  end

  def valid_word?(word = '')
    @stopwords.valid?(word)
  end

  def valid_words(words = [])
    words.select { |word| valid_word? word }
  end

  def lemma(word = '')
    @lemmer.lemma(word)
  end
end
