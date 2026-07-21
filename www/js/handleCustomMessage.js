Shiny.addCustomMessageHandler("notify", function(message) {
  console.log("Server message:", message.text);
  // Example: Show toast or alert
  alert(message.text);
  // Or: document.getElementById("someDiv").innerText = message.text;
});