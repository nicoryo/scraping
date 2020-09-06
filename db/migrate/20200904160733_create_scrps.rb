class CreateScrps < ActiveRecord::Migration[6.0]
  def change
    create_table :scrps do |t|
      t.string :name
      t.string :average
      t.string :start_value
      t.string :end_value
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
