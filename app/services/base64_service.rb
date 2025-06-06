module Base64Service

  def self.encode(text)
    return nil unless text
    begin
      # Ensure text is UTF-8 before encoding, replace invalid chars
      Base64.encode64(text.encode('UTF-8', invalid: :replace, undef: :replace))
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError => e
      # fallback: encode as-is, may result in mojibake
      Base64.encode64(text.to_s)
    end
  end

  def self.decode(text)
    return nil unless text
    begin
      # Decode and force UTF-8 encoding, replace invalid chars
      Base64.decode64(text).force_encoding('UTF-8').encode('UTF-8', invalid: :replace, undef: :replace)
    rescue Encoding::UndefinedConversionError, Encoding::InvalidByteSequenceError, ArgumentError => e
      # fallback: decode and force encoding, may result in mojibake
      Base64.decode64(text).force_encoding('UTF-8')
    end
  end
end
