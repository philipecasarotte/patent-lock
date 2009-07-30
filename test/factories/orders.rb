Factory.define :order do |o|
  o.total Configuration.first.service_price rescue ""
end