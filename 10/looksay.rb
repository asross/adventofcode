def looksay(s)
  s.gsub(/(\d)\1*/) { |m| "#{m.length}#{m[0]}" }
end
