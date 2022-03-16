module Cmor::Contact
  class WhatsappRequest
    include ActiveModel::Model

    attr_accessor :message

    validates :message, presence: true

    def whatsapp_link
      "https://wa.me/#{number_for_url}?text=#{encoded_message}"
    end

    def number_for_url
      Cmor::Contact::Configuration.whatsapp_number&.gsub("+", "")&.gsub(" ", "")
    end

    private

    def encoded_message
      if URI.respond_to?(:encode)
        URI.encode(message)
      else
        CGI.escape(message)
      end
    end
  end
end
