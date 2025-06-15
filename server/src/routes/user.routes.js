import express from "express";
import UserController from "../controllers/user.controller.js";
import isAuthrorizedUser from "../middlewares/auth.middleware.js";
import upload from "../middlewares/multer.middleware.js";
const router = express.Router();

router
  .route("/:userId/get-user")
  .get(isAuthrorizedUser, UserController.getUserDetails);
router
  .route("/update-profile")
  .put(isAuthrorizedUser, UserController.updateUserProfile);

router
  .route("/change-password")
  .patch(isAuthrorizedUser, UserController.changePassword);

router.route("/upload-profile-pic").post(upload.single("image"), UserController.uploadProfilePic)

router.route("/toggle-follow").post(UserController.toggleFollow);
export default router;
