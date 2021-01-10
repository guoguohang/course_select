module SessionsHelper
    # 登入指定的用户
    def log_in(user)
        session[:user_id] = user.id
    end

    # 返回当前登录的用户
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end

    # 如果用户已登录，返回true，否则返回false
    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

    # 如果指定用户是当前用户，返回 true
    def current_user?(user)
        user == current_user
    end

    def student_logged_in?
        !current_user.nil? && !current_user.teacher && !current_user.admin
    end
    
    def teacher_logged_in?
        !current_user.nil? && current_user.teacher
    end

    def admin_logged_in?
        !current_user.nil? &&current_user.admin
    end
end
