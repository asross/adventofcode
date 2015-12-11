triples = ['abc']
'd'.upto('z') { |c| triples << "#{triples.last[1..2]}#{c}" }
@triples = Regexp.new(triples.join('|'))

def next_password(pw)
  pw.succ.upto('zzzzzzzz').detect do |s|
    s =~ @triples && s !~ /[iol]/ && s =~ /(.)\1.*(.)\2/
  end
end

raise unless next_password('abcdefgh') == 'abcdffaa'

pw = next_password('cqjxjnds')
puts pw

pwpw = next_password(pw)
puts pwpw
