// IMPORT FROM PACKAGES
const express = require("express");

const mongoose = require('mongoose');

// IMPORT FROM OTHER FILES
const authRouter = require("./routes/auth");

// INIT
const PORT = 3000;
const app = express();
const DB = 'mongodb+srv://favad:favad123@cluster0.ciuwwr9.mongodb.net/?retryWrites=true&w=majority';

// middleware
app.use(express.json());
app.use(authRouter);
app.use(express.urlencoded({ extended: false }));

// Connections
mongoose.connect(DB).then(function () {
    console.log("connection success");
}).catch(function (e) {
    console.log(e);
});

// CREATE GET API
app.get("/hello-world", function (req, res) {

    res.json({ hi: "Hello Favad" });

});

app.listen(PORT, "192.168.29.218",  function () {

    console.log(`connected at port ${PORT} favad`);


});