import express from "express";
import AuthController from "../controllers/auth.controller.js";
import upload from "../middlewares/multer.middleware.js"
import isAuthorizedUser from "../middlewares/auth.middleware.js";
const router = express.Router();
router.route("/register").post(upload.single("image"), AuthController.register);

router.route("/login").post(AuthController.login);
router.route("/logout").post(isAuthorizedUser, AuthController.logout);
router.route("/refresh-token").post(AuthController.refreshAccessToken);
export default router;