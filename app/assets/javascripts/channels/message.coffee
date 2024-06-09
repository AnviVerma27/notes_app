# # // app/assets/javascripts/channels/note.coffee (or .js)
# App.note = App.cable.subscriptions.create("NoteChannel", {
#   received: function(data) {
#     console.log("Received:", data);
#   },

#   sendNote: function(noteContent) {
#     this.perform('receive', { content: noteContent });
#   }
# });

# // app/assets/javascripts/channels/messages.js (or .coffee)
App.messages = App.cable.subscriptions.create("MessageChannel", {
  received: function(data) {
    # // Handle different actions based on the data received
    switch (data.action) {
      case 'create':
        # // Append the newly created message to the DOM
        $('messages').append(data.message);
        break;
      case 'update':
        let messageElement = $(`.message-item[data-id="${data.id}"]`);
        messageElement.html(data.message);
        break;
      case 'destroy':
        $(`.message-item[data-id="${data.id}"]`).remove();
        break;
      default:
        console.log("Unknown action:", data.action);
    }
  }
});

