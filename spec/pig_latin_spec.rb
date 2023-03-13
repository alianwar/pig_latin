# frozen_string_literal: true

require 'pig_latin'
require 'rspec'
require 'byebug'

describe PigLatin do
  def assert_pig_latin(phrase, expected)
    expect(PigLatin.translate(phrase)).to eq(expected)
  end

  describe '#translate' do
    it 'translates single-word sentences starting with a vowel' do
      assert_pig_latin 'apple', 'appleway'
      assert_pig_latin 'under', 'underway'
    end

    it 'translates single-word sentences starting with a consonant' do
      assert_pig_latin 'pig', 'igpay'
      assert_pig_latin 'latin', 'atinlay'
      assert_pig_latin 'banana', 'ananabay'
      assert_pig_latin 'happy', 'appyhay'
    end

    it 'translates single-word sentences starting with a consonant cluster' do
      assert_pig_latin 'glove', 'oveglay'
      assert_pig_latin 'three', 'eethray'
      assert_pig_latin 'school', 'oolschay'
      assert_pig_latin 'quiet', 'ietquay'
      assert_pig_latin 'square', 'aresquay'
    end

    it 'translates multiple-word sentences' do
      assert_pig_latin 'hello world', 'ellohay orldway'
      assert_pig_latin 'eat apples', 'eatway applesway'
    end

    it 'handles edge cases' do
      assert_pig_latin '', ''
      assert_pig_latin 'pig!', 'igpay!'
      assert_pig_latin 'this is a test.', 'isthay isway away esttay.'
    end

    describe 'examples from requirements' do
      it 'translates hello to ellohay' do
        assert_pig_latin 'hello', 'ellohay'
      end

      it 'translates eat to eatway' do
        assert_pig_latin 'eat', 'eatway'
      end

      it 'translates yellow to ellowyay' do
        assert_pig_latin 'yellow', 'ellowyay'
      end

      it 'translates eat world to eatway orldway' do
        assert_pig_latin 'eat world', 'eatway orldway'
      end

      it 'translates Hello to Ellohay' do
        assert_pig_latin 'Hello', 'Ellohay'
      end

      it 'translates Apples to Applesway' do
        assert_pig_latin 'Apples', 'Applesway'
      end

      it 'translates eat… world?! to eatway… orldway?!' do
        assert_pig_latin 'eat… world?!', 'eatway… orldway?!'
      end

      it 'translates school to oolschay' do
        assert_pig_latin 'school', 'oolschay'
      end

      it 'translates quick to ickquay' do
        assert_pig_latin 'quick', 'ickquay'
      end

      it "translates she's great! to e'sshay eatgray!" do
        assert_pig_latin "she's great!", "e'sshay eatgray!"
      end

      it 'translates HELLO to ELLOHAY' do
        assert_pig_latin 'HELLO', 'ELLOHAY'
      end

      it 'translates Hello There to Ellohay Erethay' do
        assert_pig_latin 'Hello There', 'Ellohay Erethay'
      end
    end
  end
end
