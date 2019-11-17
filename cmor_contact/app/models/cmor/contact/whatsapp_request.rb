module Cmor::Contact
  class WhatsappRequest
    include ActiveModel::Model

    attr_accessor :message

    validates :message, presence: true

    def whatsapp_link
      "https://wa.me/#{number_for_url}?text=#{URI.encode(message)}"
    end

    def number_for_url
      Cmor::Contact::Configuration.whatsapp_number&.gsub("+", "")&.gsub(" ", "")
    end
  end
end
