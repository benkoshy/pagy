# frozen_string_literal: true

require_relative '../test_helper'

describe 'pagy/locales' do
  let(:rules) { Pagy::I18n::P11n::RULE.keys }
  let(:counts) do
    {
      arabic:             %w[zero one two few many other],
      east_slavic:        %w[one few many other],
      one_other:          %w[one other],
      one_two_other:      %w[one two other],
      one_upto_two_other: %w[one other],
      other:              %w[other],
      polish:             %w[one few many other],
      west_slavic:        %w[one few other]
    }
  end

  # helpers
  def self.get_locale_files
    Pagy.root.join('locales') # locale files returns Pathname array
  end

  def self.is_yaml_file?(f)
    f.extname == '.yml'
  end

  def self.get_locale_name(f)
    f.basename.to_s[0..-5]
  end
  
  get_locale_files.each_child do |f|
    next unless is_yaml_file?(f)

    message = "locale file #{f}"
    locale  = get_locale_name(f)
    comment = f.readlines.first.to_s.strip
    rule    = comment.to_s.split[1][1..].to_s.to_sym

    it 'includes a comment with the pluralization rule and the i18n.rb reference' do
      _(rules).must_include rule, message
      _(comment).must_match 'https://github.com/ddnexus/pagy/blob/master/lib/pagy/i18n.rb', message
    end
    it 'defines and matches the locale pluralization rule' do
      _(Pagy::I18n::P11n::LOCALE[locale]).must_equal Pagy::I18n::P11n::RULE[rule], message
    end
    it 'pluralizes item_name according to the rule' do
      hash      = YAML.safe_load(f.read)
      item_name = hash[locale]['pagy']['item_name']
      case item_name
      when String
        _(rule).must_equal :other
      when Hash
        _(item_name.keys - counts[rule]).must_be_empty
      else
        raise StandardError, "item_name must be Hash or String"
      end
    end
  end
  
end
