class CreateAnswers < ActiveRecord::Migration[6.0]
  def change
    create_table :answers do |t|
      t.text :body
      t.references :question, null: false, foreign_key: false
      t.timestamps
    end
  end
end
