class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: {maximum: 50}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :name, presence: true, length: {maximum: 50}
    validates :email, presence: true, length: {maximum: 255}, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
    has_secure_password

    has_many :grades
    has_many :courses, through: :grades

    has_many :teaching_courses, class_name: "Course", foreign_key: :teacher_id

end
