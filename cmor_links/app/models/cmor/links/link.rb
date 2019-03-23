require_dependency 'redcloth'

class Cmor::Links::Link < ActiveRecord::Base
  # acts as list
  acts_as_list scope: :category

  # associations
  belongs_to :category, optional: true


  # callbacks
  after_initialize :set_defaults

  # constants
  MARKUP_LANGUAGES = %w(markdown textile rdoc)

  # validations
  validates :name, presence: true
  validates :url,  presence: true
  validates :markup_language, presence: true,
                              inclusion: MARKUP_LANGUAGES

  def description(options = {})
    options.reverse_merge!(as: :plain)
    case options[:as]
    when :html
      markup(self[:description])
    else
      self[:description]
    end
  end

  private

  def markup(text)
    case markup_language.to_sym
    when :textile
      return unless text
      RedCloth.new(text).to_html
    when :none
      text
    else
      fail "Unsupported markup language #{markup_language}"
    end
  end

  def set_defaults
    self.markup_language ||= 'textile' if self.new_record?
  end
end
