class CreateCourseInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :course_infos do |t|
      t.integer :course_id
      t.string :course_day #星期几有课
      t.string :course_class #节次
      t.timestamps
    end
  end
end
