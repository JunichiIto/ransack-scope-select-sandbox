class CreateExams < ActiveRecord::Migration[7.0]
  def change
    create_table :exams do |t|
      t.belongs_to :student, null: false, foreign_key: true
      t.string :subject
      t.integer :score

      t.timestamps
    end
  end
end
