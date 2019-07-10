class CreateBoltOns < ActiveRecord::Migration[5.2]
  def change
    create_table :bolt_ons do |t|
      t.string :name, null: false
      t.boolean :enabled, default: false, null: false
    end

    add_index :bolt_ons, :name, unique: true
  end
end
