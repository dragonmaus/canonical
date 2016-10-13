# frozen_string_literal: true
require 'addressable/uri/fetch'
require 'nokogiri'

module Addressable
  class URI
    def canonical
      dup.canonical!
    end

    def canonical!
      fixup!

      response = fetch use_get: :on_text
      response.uri ||= dup
      response.uri.normalize!

      return replace_self(response.uri) if !response.is_a?(Net::HTTPOK) || response.content_type != 'text/html'

      document = Nokogiri.HTML(response.body)
      # <link rel="canonical"> takes priority over <meta property="og:url">
      replace_self(
        if (element = document.at_css('link[@rel="canonical"]'))
          self.class.parse(element['href'])
        elsif (element = document.at_css('meta[@property="og:url"]'))
          self.class.parse(element['content'])
        else
          response.uri
        end
      )

      # The spec allows the canonical link to be a relative URI
      replace_self(self.class.join(response.uri, self)) unless absolute?

      # Because you can't always trust sites to do things properly
      normalize!
    end

    def fixup
      dup.fixup!
    end

    def fixup!
      normalize!
    end
  end
end
