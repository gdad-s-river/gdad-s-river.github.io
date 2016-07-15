require 'digest/md5'

module Jekyll
  module GravatarFilter
    def to_gravatar(input)
      "http://www.gravatar.com/avatar/#{hash(input)}?#{options}"
    end

    def to_secure_gravatar(input)
      "https://secure.gravatar.com/avatar/#{hash(input)}?#{options}"
    end

    private :hash

    def hash(email)
      email_address = email ? email.downcase.strip : ''
      Digest::MD5.hexdigest(email_address)
    end

    def options
      options = []
      # Size
      options << "s=100"
      options.join("&")
    end
  end
end

Liquid::Template.register_filter(Jekyll::GravatarFilter)
