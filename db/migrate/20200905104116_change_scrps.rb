class ChangeScrps < ActiveRecord::Migration[6.0]
  def change
    change_column :scrps, :average, :text
  end
end
