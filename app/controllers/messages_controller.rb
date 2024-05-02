class MessagesController < ApplicationController

    def index
        @message = Message.all.order("created_at DESC")
    end

    def new
        @message = Message.new
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
            redirect_to message_path
        else
            render 'edit'
        end
    end

    def destroy
        @message = Message.find(params[:id])
        if @message.destroy
            redirect_to root_path, notice: 'Message was successfully deleted.'
        else
            render 'edit'
        end
    end

    def create
        @message = Message.new(message_params)
        if @message.save 
            redirect_to root_path
        else
            render 'new'
        end
    end

    private
    def message_params
        params.require(:message).permit(:title, :description)
    end
    
end
