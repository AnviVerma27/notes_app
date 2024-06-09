class MessagesController < ApplicationController

    def index
        if current_user
            @message = current_user.messages.order("created_at DESC")
        else
            render 'home'
        end
    end

    def new
        @message = current_user.messages.build
    end

    def show
        @message = Message.find (params[:id])
    end

    def edit
        @message = Message.find (params[:id])
    end

    def update
        @message = Message.find (params[:id])
        if @message.update(message_params)
            ActionCable.server.broadcast('messages', { action: 'update', message: @message })
            redirect_to message_path
        else
            render 'edit'
        end
    end

    def destroy
        @message = Message.find(params[:id])
        if @message.destroy
            ActionCable.server.broadcast('messages', { action: 'delete', message: @message.id })
            redirect_to root_path, notice: 'Message was successfully deleted.'
        else
            render 'edit'
        end
    end

    def create
        @message = current_user.messages.build(message_params)
        if @message.save 
            ActionCable.server.broadcast('messages', { action: 'create', message: render_message(@message) })
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
    def message_params
        params.require(:message).permit(:title, :description)
    end
    def render_message(message)
        ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
    end
    
end
