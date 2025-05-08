import express from "express";
import UserController from "../controllers/user.controller";
import isAuthrorizedUser from "../middlewares/auth.middleware";
const router = express.Router();

router
  .route("/get-current-user")
  .get(isAuthrorizedUser, UserController.getCurrentUser);
router
  .route("/update-profile")
  .put(isAuthrorizedUser, UserController.updateUserProfile);

router
  .route("/change-password")
  .patch(isAuthrorizedUser, UserController.changePassword);
