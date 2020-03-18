class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :filename
      t.string :commit
      t.string :title
      t.string :description

      t.timestamps
    end
  end
end
