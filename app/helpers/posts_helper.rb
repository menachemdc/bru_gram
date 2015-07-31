module PostsHelper
	def allowed_to_view(post)
	 (post.user == current_user)
			
	end
end