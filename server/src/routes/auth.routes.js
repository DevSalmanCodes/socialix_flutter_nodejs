import express from "express";
import AuthController from "../controllers/auth.controller.js";
import upload from "../middlewares/multer.middleware.js"
const router = express.Router();
router.route("/register").post(upload.single("image"), AuthController.register);

router.route("/login").post(AuthController.login);


export default router;