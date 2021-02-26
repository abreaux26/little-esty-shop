class ChangeDefaultValueForMerchantStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :merchants, :status, from: 1, to: 0
  end
end
