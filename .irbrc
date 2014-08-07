begin
  require 'wirble'

  Wirble.init
  Wirble.colorize
rescue LoadError => err
  warn "Can't load Wirble: #{err}"
end
