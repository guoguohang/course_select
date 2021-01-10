class GradesController < ApplicationController
    before_action :teacher_logged_in, only:[:write, :score]
    def scorelist
        @grades = Grade.where(user_id: current_user.id)
    end

    def upload
        puts params[:student_ids]
    end

     #教师录入成绩
    def write
        @courses = Course.where(teacher_id: current_user.id)
    end

    def browse
        @courses = Course.where(teacher_id: current_user.id)
    end
    #单门课程录入成绩按钮
    def score
        @grades =Grade.where(course_id:params[:id]) 
        # @students = User.all(id:@grades.user_id)
    end

    def studentsscorelist
        @grades =Grade.where(course_id:params[:id]) 
    end

    #成绩录入成功
    def done
        @grade =Grade.find_by(id:params[:id]) 
        @grade.update_attributes(grade: params[:grade])
    end

    def update
        @grade=Grade.find_by_id(params[:id])
        if @grade.update_attributes!(:grade => params[:grade][:grade])
          flash={:success => "#{@grade.user.name} #{@grade.course.name}的成绩已成功修改为 #{@grade.grade}"}
        else
          flash={:danger => "上传失败.请重试"}
        end
        # redirect_to grades_path(course_id: params[:course_id]), flash: flash
      end

    # Confirms a teacher logged-in user.
    def teacher_logged_in
        unless teacher_logged_in?
            redirect_to root_url, flash: {danger: '请登录老师'}
        end
    end
end