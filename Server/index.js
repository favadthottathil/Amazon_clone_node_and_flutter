console.log("hello,World");

const express = require("express");

const PORT = 3000;

const app = express();

// Creating An API

 app.listen(PORT, "0.0.0.0", function (){

    console.log(`connected at port ${PORT} favad`);


 } )