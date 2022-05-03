class Student < ApplicationRecord
  has_many :exams, dependent: :destroy

  scope :without_exams, -> do
    where(<<~SQL)
      NOT EXISTS (
        SELECT * 
        FROM exams e 
        WHERE e.student_id = students.id
      )
    SQL
  end

  scope :with_exams, -> do
    where(<<~SQL)
      EXISTS (
        SELECT * 
        FROM exams e 
        WHERE e.student_id = students.id
      )
    SQL
  end

  scope :with_good_score, -> do
    where(<<~SQL)
      students.id = (
        SELECT student_id
        FROM exams 
        GROUP BY student_id 
        HAVING AVG(score) >= 60
      )
    SQL
  end

  SCOPES_FOR_SELECT = %w(without_exams with_exams with_good_score).freeze
  scope :for_select, -> (scope_name) do
    raise ArgumentError unless scope_name.in?(SCOPES_FOR_SELECT)
    send(scope_name)
  end

  def self.ransackable_scopes(_auth_object = nil)
    [:for_select]
  end

  def avg_score
    exams.average(:score)
  end
end
