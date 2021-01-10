class CourseInfo < ApplicationRecord
    belongs_to :course

    validates :course_id, :course_class, :course_day, presence: true
end
