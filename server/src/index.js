import dotenv from "dotenv";
dotenv.config();
import express from "express";
import connectDb from "./db/dbConnection.js";
import cookieParser from "cookie-parser";
const app = express();
const PORT = process.env.PORT || 3000;

app.use(express.json({ limit: "16kb" }))
app.use(express.static("public"))
app.use(express.urlencoded({ extended: false }))
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


import authRoutes from "./routes/auth.routes.js";
import userRoutes from "./routes/user.routes.js";
app.use("/api/v1/auth", authRoutes)
app.use("/api/v1/user", userRoutes)