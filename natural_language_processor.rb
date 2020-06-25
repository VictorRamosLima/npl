# frozen_string_literal: true

require 'lingua/stemmer'
require 'lemmatizer'
require 'stopwords'
require 'tokenizer'

# class
class NaturalLanguageProcessor
  def initialize(overrides = {})
    @phrase = overrides[:phrase]

    @lemmer = overrides.fetch(:lemmer) { Lemmatizer.new }
    @stemmer = overrides.fetch(:stemmer) { Lingua::Stemmer.new }
    @stopwords = overrides.fetch(:stopwords) { Stopwords }

    @tokenizer = overrides.fetch(:tokenizer) do
      Tokenizer::WhitespaceTokenizer.new(:en)
    end
  end

  def self.pre_proccess(phrase: '')
    new(phrase: phrase).pre_proccess
  end

  def pre_proccess
    tokenize(phrase)
      .select { |word| valid_word?(word) }
      .map { |word| lemma(word) }
  end

  def stem(word = '')
    stemmer.stem(word)
  end

  def tokenize(phrase = '')
    tokenizer.tokenize(phrase)
  end

  def valid_word?(word = '')
    stopwords.valid?(word)
  end

  def valid_words(words = [])
    words.select { |word| valid_word? word }
  end

  def lemma(word = '')
    lemmer.lemma(word)
  end

  private

  attr_accessor :phrase, :lemmer, :stemmer, :stopwords, :tokenizer
end
