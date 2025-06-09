import Post from "../models/post.model.js";
import ApiError from "../utils/ApiError.js";
import ApiResponse from "../utils/ApiResonse.js";
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
    static async getPosts(req, res) {
        try {
            const posts = await Post.aggregate([
                {
                    $lookup: {
                        from: "likes",
                        localField: "_id",
                        foreignField: "postId",
                        as: "likes",
                    },

                    $lookup: {
                        from: "comments",
                        localField: "_id",
                        foreignField: "postId",
                        as: "comments",
                    },

                },
                {
                    $lookup: {
                      from: 'users',
                      localField: 'postedBy',
                      foreignField: '_id',
                      as: 'postedBy'
                    }
                  },
                  {
                    $unwind: '$postedBy'
                  },
                  {
                    $project: {
                      content: 1,
                      postImage: 1,
                      likes: 1,
                      comments: 1,
                      createdAt: 1,
                      updatedAt: 1,
                      postedBy: {
                        _id: 1,
                        username: 1
                      }
                    }
                  },
                {
                    $sort: { createdAt: -1 }
                }
            ]);
            return res.status(200).json(new ApiResponse(200, "Posts fetched successfully", posts));

        } catch (err) {
            return res.status(500).json(new ApiError(500, "Internal server error" || err?.message));
        }
    }
}

export default PostController;