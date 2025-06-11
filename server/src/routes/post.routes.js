import express from 'express';
const router = express.Router();
import PostController from '../controllers/post.controller.js';
import upload from "../middlewares/multer.middleware.js";
import isAuthorizedUser from "../middlewares/auth.middleware.js";
router.route("/create").post(isAuthorizedUser, upload.single("image"), PostController.createPost);
router.route("/get").get(isAuthorizedUser, PostController.getPosts);
router.route("/:postId/toggle-like").put(isAuthorizedUser, PostController.toggleLike);
router.route("/:postId/delete").delete(isAuthorizedUser, PostController.deletePost)
export default router;