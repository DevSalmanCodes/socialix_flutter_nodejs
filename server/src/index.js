import dotenv from "dotenv";
dotenv.config();
import express from "express";
import connectDb from "./db/dbConnection.js";
import cookieParser from "cookie-parser";
const app = express();

const PORT = process.env.PORT || 3000;
app.use(express.json({limit: "16kb"}))
app.use(express.urlencoded({extended: true, limit: "16kb"}))
app.use(express.static("public"))
app.use(cookieParser())
connectDb()
  .then((_) => {
    app.listen(PORT, () => {
      console.log(`Server is running on port ${PORT}`);
    });
    
  })
  .catch((err) => {
    console.log(err);
  });
