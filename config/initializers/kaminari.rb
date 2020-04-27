# fix undefined method `per' with gem rails admin
Kaminari.configure do |config|
  config.page_method_name = :per_page_kaminari
end
