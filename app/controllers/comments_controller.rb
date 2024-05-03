class CommentsController < ApplicationController
    def create 
        @message = Message.find(params[:message_id])
        @comments = @message.comments.create(comment_params)
        @comments.user_id = current_user.id
        if @comments.save 
            redirect_to message_path(@message)
        else
            render 'new'
        end
    end

    private 
    def comment_params
        params.require(:comment).permit(:content)
    end
end
