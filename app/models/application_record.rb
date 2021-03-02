class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def unit_price_fix
    '%.2f' % unit_price
  end

  def status_view_format
    status.titleize
  end
end
