class CoursesController < ApplicationController

    before_action :student_logged_in, only: [:select, :quit, :list]
    before_action :teacher_logged_in, only: [:new, :create, :edit, :destroy, :update]#add open by qiao
    before_action :logged_in, only: :index
    before_action :admin_logged_in, only: [:open, :close]

    def index
      @courses = Course.all.paginate(page: params[:page], per_page: 10) if student_logged_in?
    end
  
    def studentselected
      @courses = current_user.courses.paginate(page: params[:page], per_page: 10) if student_logged_in?
    end
  
    # 列出该学生未选的课程
    def list
      @courses = Course.all - current_user.courses if student_logged_in? && Course.first[:open]
    end

    def select
      @course=Course.find_by_id(params[:id])
      grade = Grade.new(course_id: @course.id, user_id: current_user.id)
      if grade.save
        @course.update_attributes(student_num: @course.student_num + 1)
        flash={:suceess => "成功选择课程: #{@course.name}"}
        redirect_to studentselected_courses_path, flash: flash
      end
    end

    def quit
      @course=Course.find_by_id(params[:id])
      grade = Grade.find_by(course_id: @course.id, user_id: current_user.id)
      if grade.destroy
        @course.update_attributes(student_num: @course.student_num - 1)
        flash={:suceess => "成功退选课程: #{@course.name}"}
        redirect_to studentselected_courses_path, flash: flash
      end
    end

    #管理员开放选课
    def open
      @courses=Course.all
      @courses.each do |course|
        course.update_attributes(open: true)
      end
    end
    #管理员关闭选课
    def close
      @courses=Course.all
      @courses.each do |course|
        course.update_attributes(open: false)
      end
    end
    #管理员增加课程
    def add
      @course = Course.new
    end

    def increase
      @course = Course.new(course_params) 
      # if @course
        puts "成功"
        render 'succ', alert:"增加成功！"
      # else
        # render 'home'
        # puts "失败"
      # end
    end

    #查看已选学分
    def subcredit
      @sum=0
      @courses = current_user.courses 
        @courses.each do |course|
          left, right =  course.credit.split("/").map(&:to_f)
          @sum +=right
          puts @sum.class
        end
    end

    def succ
    end



    private
  
    # Confirms a student logged-in user.
    def student_logged_in
      unless student_logged_in?
        redirect_to root_url, flash: {danger: '请登录学生'}
      end
    end
  
    # Confirms a teacher logged-in user.
    def teacher_logged_in
      unless teacher_logged_in?
        redirect_to root_url, flash: {danger: '请登录老师'}
      end
    end

    # Confirms a admin logged-in user.
    def admin_logged_in
      unless admin_logged_in?
        redirect_to root_url, flash: {danger: '请登录管理员'}
      end
    end
  
  
    # Confirms a  logged-in user.
    def logged_in
      unless logged_in?
        redirect_to root_url, flash: {danger: '请登录用户'}
      end
    end
  
    def course_params
      params.require(:course).permit(:course_code, :name, :course_type, :teaching_type, :exam_type,
                                     :credit, :limit_num, :class_room, :course_time, :course_week)
    end
  
  
  end
  