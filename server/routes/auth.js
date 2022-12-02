// import from packages 
const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require('../model/user');
// import from other file
const authRouter = express.Router();
const jwt = require("jsonwebtoken");


// code for Sing Up
authRouter.post("/api/signup", async (req, res) =>{
// first get the data from cliant 
try {
const {name,email,password} = req.body;
    // post the data to database 
 const existingUser = await User.findOne({email});
 if (existingUser) {
    return res.status(400).json({
        msg:"User with this email already exists!",
    });
 };

 const hashedPassword = await bcryptjs.hash(password, 8);
let user = new  User({
 email,
 password: hashedPassword,
 name,
 });
 user = await user.save();
 res.json(user);
} catch (e) {
 return   res.status(500).json({error: e.message});
}

// code for SingIn
authRouter.post("/api/signin", async (req, res) => {
    try {
      const { email, password } = req.body;
  
      const user = await User.findOne({ email });
      if (!user) {
        return res
          .status(400)
          .json({ msg: "User with this email does not exist!" });
      }
  
      const isMatch = await bcryptjs.compare(password, user.password);
      if (!isMatch) {
        return res.status(400).json({ msg: "Incorrect password." });
      }
  
      const token = jwt.sign({ id: user._id }, "passwordKey");
      res.json({ token, ...user._doc });
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });

  authRouter.post("/tokenIsValid", async (req, res) => {
    try {
      const token = req.header("x-auth-token");
      if (!token) return res.json(false);
      const verified = jwt.verify(token, "passwordKey");
      if (!verified) return res.json(false);
  
      const user = await User.findById(verified.id);
      if (!user) return res.json(false);
      res.json(true);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  });
// get user data
authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user);
  res.json({ ...user._doc, token: req.token });
});
});
module.exports = authRouter;
