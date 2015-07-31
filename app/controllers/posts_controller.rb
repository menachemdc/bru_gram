class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@posts = Post.all
	end
	def new
		@post = Post.new
	end
	def create
		@post = current_user.posts.build(post_params) 
		if @post.save
			redirect_to posts_path
		else
			render :new
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit 
		@post = Post.find(params[:id])
	  	can_user_edit
	end 


	def update 
		@post = Post.find(params[:id])
	  	can_user_edit 

		if @post.update(post_params)
			redirect_to posts_path
		else	
			render 'edit'
		end
	end

	  def destroy 
		@post = Post.find(params[:id])
    	can_user_edit
		
		@post.destroy

		redirect_to posts_path
  end




end

private
	
	def can_user_edit
		if (@post.user != current_user)
			redirect_to posts_path
		end
	end

	def post_params
		params.require(:post).permit(:text, :photo, :public?)
	end