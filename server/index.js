// Import from package
const express = require('express'); 
const mongoose = require('mongoose');
// Import from other file
const authRouter = require('./routes/auth');
// initializatio
const PORT = 3000;
const app = express();
const DB = "mongodb+srv://muhidin:Muhidin123@cluster0.zmkevav.mongodb.net/?retryWrites=true&w=majority";
// middleware
app.use(express.json());
app.use(authRouter);
// connections
mongoose
  .connect(DB)
  .then(() => {
    console.log("Connection Successful");
  })
  .catch((e) => {
    console.log(e);
  });
app.listen(PORT,"0.0.0.0", ()=>{
    console.log(`Connected at port ${PORT}`);
},);

