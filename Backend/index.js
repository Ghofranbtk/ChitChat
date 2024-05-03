const express = require("express");
const axios = require("axios");
const app = express(); // Créez l'application Express
const port = process.env.PORT || 9250; // Port du serveur (9250 par défaut)
const host = "0.0.0.0";
// Vos identifiants OneSignal
const ONE_SIGNAL_APP_ID = "c4d125f3-5e95-4df1-9fbc-ec1a77b33fe4";
const ONE_SIGNAL_REST_KEY = "MjExYjE2NWUtMGMzYi00MjY1LTliNTAtZTExNzI4ZjhlMDVl";

// Fonction pour envoyer la notification
async function sendGlobalNotification(title, body) {
  const notification = {
    app_id: ONE_SIGNAL_APP_ID,
    headings: { en: title },
    contents: { en: body },
    included_segments: ["All"], // Envoyer à tous les utilisateurs
  };

  try {
    const response = await axios.post(
      "https://onesignal.com/api/v1/notifications",
      notification,
      {
        headers: {
          "Content-Type": "application/json",
          Authorization: `Basic ${ONE_SIGNAL_REST_KEY}`, // Autorisation
        },
      }
    );
    console.log("Notification sent:", response.data);
  } catch (error) {
    console.error("Error sending notification:", error);
  }
}

// Endpoint qui déclenche la notification
app.get("/api/sendNotification", async (req, res) => {
  await sendGlobalNotification("New Message !", "You Have i new Message !"); // Appelez la fonction
  res.send("Notification sent to all devices"); // Réponse au client
});

// Endpoint qui déclenche la notification
app.get("/api/updatedNotification", async (req, res) => {
  await sendGlobalNotification(
    "Message Updated !",
    "There are an updated message !"
  ); // Appelez la fonction
  res.send("Notification sent to all devices"); // Réponse au client
});

// Lancer le serveur
app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
