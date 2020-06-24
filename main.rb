# frozen_string_literal: true

require_relative 'initializer'

nlp = NaturalLanguageProcessor.new

phrase = 'I am doing the installation, so she will never need to do it again, \
since she does not have enough knowledge for it'

words = nlp.tokenize(phrase)

p words

valid_words = words.select { |word| nlp.valid_word?(word) }

p valid_words
p nlp.valid_words(words)

stemmed_words = valid_words.map { |word| nlp.stem(word) }

p stemmed_words

lemmed_words = valid_words.map { |word| nlp.lemma(word) }

p lemmed_words
