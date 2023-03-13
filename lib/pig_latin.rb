# frozen_string_literal: true

require 'active_support/inflector'

class PigLatin
  attr_reader :phrase

  def initialize(phrase)
    @phrase = phrase
  end

  # Splits the phrase into individual words or non-word components,
  # and calls translate_word to translate each word. If the component is not a word, it is left unchanged.
  # The translated words and non-words are then concatenated to form the final translated phrase.
  def translate
    split_phrase(phrase).map do |part|
      if part[:type] == :word
        translate_word(part[:value])
      else
        part[:value]
      end
    end.join
  end

  # The method takes a word and translates it into Pig Latin.
  # If the word starts with a vowel sound, the method appends "way" to the end of the word.
  # If the word starts with a consonant, the method finds the index of the first vowel
  # and moves the consonants before that vowel to the end of the word, followed by "ay".
  # The method also preserves the case of the original word in the translated word.
  def translate_word(word)
    translated_word = if starts_with_vowel_sound?(word)
                        "#{word}way"
                      else
                        first_vowel_index = find_first_vowel_index(word)
                        "#{word[first_vowel_index..]}#{word[0...first_vowel_index]}ay"
                      end

    preserve_case(word, translated_word)
  end

  # Checks if a given letter sounds like a vowel.
  def vowel_sound?(letter, position, last_letter)
    return position != 0 if letter == 'y'
    return last_letter != 'q' if letter == 'u'

    letter.match?(/[aeio]/i)
  end

  # The find_first_vowel_index method finds the index of the first vowel in a word.
  # It considers "y" as a vowel if it is not the first letter of the word
  # and "u" as a vowel if it is not preceded by a "q".
  def find_first_vowel_index(word)
    last_letter = ''
    word.downcase.chars.each_with_index do |letter, position|
      return position if vowel_sound?(letter, position, last_letter)

      last_letter = letter
    end
  end

  def starts_with_vowel_sound?(word)
    word.match(/\A[aeiou]/i)
  end

  def preserve_case(original, translated)
    return translated.capitalize if original.capitalize == original
    return translated.upcase if original.upcase == original

    translated
  end

  # Splits the input phrase into individual words and non-word components.
  # It returns an array of hashes, where each hash represents a word or non-word component
  # and has a type key that is either :word or :non_word and a value key that
  # contains the actual word or non-word component.
  def split_phrase(phrase)
    parts = []
    input = phrase.dup
    while (match = input.match(/[a-z'’]+/i))
      parts << { type: :non_word, value: match.pre_match } unless match.pre_match.to_s.empty?
      parts << { type: :word, value: match.to_s }
      input = match.post_match
    end

    parts << { type: :non_word, value: input } unless input.to_s.empty?

    parts
  end

  def self.translate(string)
    new(string).translate
  end
end
