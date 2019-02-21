require 'roda'
require_relative 'cc'

Roda.route do |r|
  r.get String do |number|
    response.status = 400 unless CC.validate(number)
    ''
  end
end

run Roda
