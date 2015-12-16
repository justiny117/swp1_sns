class TimelineController < ApplicationController
before_action :authenticate_user!, except: :index
before_action :authenticate_user!, except: :front

    def index
        @blogs = Blog.all.reverse
    end
    def fox
        @blogs = Blog.all.reverse
    end
    def wolf
        @blogs = Blog.all.reverse
    end
    def write
        Blog.create(user_id: current_user.id, content: params[:naeyong])
        redirect_to :back
    end
    def comment
        Comment.create(user_id: current_user.id, blog_id: params[:blog_id], msg: params[:comment])
        redirect_to :back
    end
    def blog_edit
        @blog = Blog.find(params[:id])
    end
    def comment_edit
        @comm = Comment.find(params[:id])
    end
    def blog_update
        blogu = Blog.find(params[:id])
        blogu.content = params[:naeyong]
        blogu.save
        redirect_to :root
    end
    def comment_update
        commu = Comment.find(params[:id])
        commu.msg = params[:comment]
        commu.save
        redirect_to :root
    end
    def blog_delete
        blogd = Blog.find(params[:id])
        blogd.destroy
        redirect_to :back
    end
    def comment_delete
        commd = Comment.find(params[:id])
        commd.destroy
        redirect_to :back
    end

    def myblog
        @myblogs = Blog.where(user_id: current_user.id)
    end
    def mycomment
        @mycomments = Comment.where(user_id: current_user.id)
        @belongblog = Blog.where(user_id: current_user.id)
        #@belongblog = Blog.where(user_id: @mycomments.blog_id)
    end
    def agree
        if params[:bloguseremail] == current_user.email then
            redirect_to :back
        elsif   params[:userexist] == 'true'      then
            redirect_to :back
        else
            Agree.create(user_id: current_user.id, blog_id: params[:blog_id])
            redirect_to :back
        end
    end
    
    def agreec
        if params[:commentuseremail] == current_user.email then
            redirect_to :back
        elsif   params[:userexist2] == 'true'      then
            redirect_to :back
        else
            Agreec.create(user_id: current_user.id, comment_id: params[:comment_id])
            redirect_to :back
        end        
    end
    def follow
        @followexist = Follower.where(useremail: params[:bloguseremail])
        if params[:bloguseremail] == current_user.email then
        redirect_to :back
        elsif  @followexist.exists?(user_id: current_user.id) == true  then
        redirect_to :back        
        else
        Following.create(useremail: current_user.email, user_id: params[:followuserid])
        Follower.create(useremail: params[:followuseremail], user_id: current_user.id)
        redirect_to :back
        end
    end    
    def follow_gather
        @user = User.all
        @blogs = Blog.all.reverse
    end
    def agreeinorder
        @blogs = Blog.all.sort_by{|b| b.agree_count}.reverse
    end

    def mypage
        @user = User.where(nickname: params[:nickname])
    end
    
    def follow_delete
        @userdate = User.where(id: params[:id])
        @userdate.each do |d|
            @followdel1 = Follower.where(useremail: d.email, user_id: current_user.id)
            @followdel2 = Following.where(useremail: current_user.email, user_id: d.id) 
            @followdel1.each do |a|
            a.destroy
            end
            @followdel2.each do |b|
            b.destroy
            end
        end
        redirect_to :back
    end
    
    def userblog
        @uu = User.where(nickname: params[:nickname]).take
        @blogs = Blog.all
    end
end
