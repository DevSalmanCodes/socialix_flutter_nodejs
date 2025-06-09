import express from 'express';
const router = express.Router();
import PostController from '../controllers/post.controller.js';
import upload from "../middlewares/multer.middleware.js";
import isAuthorizedUser from "../middlewares/auth.middleware.js";
router.route("/create-post").post(isAuthorizedUser,upload.single("image"),PostController.createPost);
router.route("/get-posts").get(isAuthorizedUser,PostController.getPosts);
export default router;