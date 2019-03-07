superclass = ActiveRecord::Migration
superclass = ActiveRecord::Migration[5.0] if superclass.respond_to?(:[])

class CreateChildren < superclass
  def change
    create_table :children do |t|
      t.string :fallback
      t.string :not_fallback
      t.belongs_to :parent, foreign_key: true

      t.timestamps
    end
  end
end
