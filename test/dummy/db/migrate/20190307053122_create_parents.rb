superclass = ActiveRecord::Migration
superclass = ActiveRecord::Migration[5.0] if superclass.respond_to?(:[])

class CreateParents < superclass
  def change
    create_table :parents do |t|
      t.string :fallback

      t.timestamps
    end
  end
end
