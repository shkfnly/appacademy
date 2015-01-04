class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.text :question_text
      t.integer :answer_id
      t.integer :poll_id
      
      t.timestamps null: false
    end
  end
end
