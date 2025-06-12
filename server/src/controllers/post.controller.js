import Post from "../models/post.model.js";
import ApiError from "../utils/ApiError.js";
import ApiResponse from "../utils/ApiResonse.js";
import { uploadOnCloudinary } from "../utils/cloudinary.js";
import Like from "../models/like.model.js";
class PostController {
    static async createPost(req, res) {
        const { content } = req.body;
        const postImage = req.file?.path;

        if (!content && !postImage) {
            return res.status(400).json(new ApiError(400, "Content or post image is required"));
        }
        try {
            let uploadRes;
            if (postImage) {
                uploadRes = await uploadOnCloudinary(postImage);
            }
            const newPost = await Post.create({
                content: content,
                postImage: uploadRes?.url || "",
                postedBy: req.user._id,
            });
            const populatedPost = await Post.findById(newPost._id).populate("postedBy", "username email avatar coverImage bio");
            const postWithAvatarUrl = {
                ...populatedPost.toObject(),
                postedBy: {
                    ...populatedPost.postedBy.toObject(),
                    avatar: populatedPost.postedBy.avatar?.url || "",
                },
            };
            return res.status(201).json({
                message: "Post created successfully",
                post: postWithAvatarUrl,
            });

        } catch (err) {
            return res.status(500).json(new ApiError(500, "Internal server error" || err?.message));
        } s
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
                    }
                },
                {
                    $lookup: {
                        from: "comments",
                        localField: "_id",
                        foreignField: "post",
                        as: "comments",
                    }
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
                            _id: '$postedBy._id',
                            username: '$postedBy.username',
                            email: '$postedBy.email',
                            coverImage: '$postedBy.coverImage',
                            avatar: '$postedBy.avatar.url',
                            bio: '$postedBy.bio',
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

    static async toggleLike(req, res) {
        const { postId } = req.params;
        const userId = req.user._id;

        try {
            const existingLikePost = await Like.findOne({ postId: postId, likedBy: userId });
            if (existingLikePost) {
                await existingLikePost.deleteOne();
                return res.status(200).json(new ApiResponse(200, "Post unliked successfully"));
            } else {
                await Like.create({ postId: postId, likedBy: userId });

                return res.status(201).json(new ApiResponse(201, "Post liked successfully"));
            }
        } catch (err) {
            return res.status(500).json(new ApiError(500, "Internal server error" || err?.message));
        }
    }

    static async deletePost(req, res) {
        const { postId } = req.params;
        try {
            const post = await Post.findById(postId);
            if (!post) {
                return res.status(400).json(new ApiError(400, "Post not found"));
            }
            if (post.postedBy.toString() !== req.user._id.toString()) {
                return res.status(401).json(new ApiError(401, "You are not authorized to delete this post"),);
            }
            await post.deleteOne();
            return res.status(200).json(new ApiResponse(200, "Post deleted successfully", post),)
        } catch (err) {
            return res.status(401).json(new ApiError(401, "Internal server error" || err?.message),);
        }
    }
}

export default PostController;