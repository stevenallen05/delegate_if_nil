superclass = ActiveRecord::Migration
superclass = ActiveRecord::Migration[5.0] if superclass.respond_to?(:[])

class CreateTables < superclass
  def up
    create_table :grandparents do |t|
      t.string :attribute_one
      t.string :attribute_two
      t.string :attribute_three

      t.timestamps
    end

    create_table :parents do |t|
      t.string :attribute_one
      t.string :attribute_two
      t.string :attribute_three
      t.belongs_to :grandparent, foreign_key: true

      t.timestamps
    end

    create_table :children do |t|
      t.string :attribute_one
      t.string :attribute_two
      t.string :attribute_three
      t.belongs_to :parent, foreign_key: true

      t.timestamps
    end
  end
end
