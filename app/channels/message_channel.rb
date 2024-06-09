class MessageChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from 'Message'
  end

  def receive(data)
    @message = Message.create(data)
    console.log(data)
    ActionCable.server.broadcast("Message", action: 'create', message: render_note(@message))

  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  private

  def render_note(note)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: note })
  end
end
