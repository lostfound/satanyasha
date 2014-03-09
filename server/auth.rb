#!/usr/bin/ruby

module Auth
  def validation_key string, password=@password
    (Digest::SHA512.new<<"#{string}#{password}").to_s
  end
end
