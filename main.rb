require_relative 'natural_language_processor'

phrase = 'I am doing the installation, so she will never need to do it again, since she does not have enough knowledge for it'

nlp = NaturalLanguageProcessor.new phrase: phrase

p nlp.pre_proccess

p NaturalLanguageProcessor.pre_proccess(phrase: phrase)
