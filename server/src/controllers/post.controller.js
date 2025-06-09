import Post from "../models/post.model.js";
import ApiError from "../utils/ApiError.js";
import { uploadOnCloudinary } from "../utils/cloudinary.js";
class PostController {
    static async createPost(req, res) {
        const { content } = req.body;
        const postImage = req.file?.path;
       
        if (!content && !postImage) {
            return res.status(400).json(new ApiError(400, "Content or post image is required"));
        }
        try {
            const uploadRes = await uploadOnCloudinary(postImage);
            const post = await Post.create({
                content: content,
                postImage: uploadRes?.url || "",
                postedBy: req.user._id, 
            });            
            return res.status(201).json({
                message: "Post created successfully",
                post: post,
            });
        } catch (err) {
            return res.status(500).json(new ApiError(500, "Internal server error" || err?.message));
        }
    }
}

export default PostController;