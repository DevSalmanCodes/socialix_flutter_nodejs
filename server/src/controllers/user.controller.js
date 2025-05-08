import User from "../models/user.model";
import ApiError from "../utils/ApiError.js";
import ApiResponse from "../utils/ApiResonse.js";
class UserController {
  static async getCurrentUser(req, res) {
    try {
      const user = await User.findById(req.user._id).select(
        "-password -refreshToken"
      );
      if (!user) {
        return res.status(404).json(new ApiError(404, "User not found"));
      }

      res
        .status(200)
        .json(new ApiResponse(200, "User fetched successfully", user));
    } catch (err) {
      return res
        .status(500)
        .json(new ApiError(500, err?.message || "Internal server error"));
    }
  }

  static async updateUserProfile(req, res) {
    const { username, email, bio } = req.body;
    if (!username && !email && !bio) {
      return res
        .status(400)
        .json(new ApiError(400, "Please provide at least one field to update"));
    }
    try {
      const user = await User.findById(req.user._id);
      if (!user) {
        return res.status(404).json(new ApiError(404, "User not found"));
      }
      user.username = username;
      user.email = email;
      user.bio = bio;
      await user.save();
      return res
        .status(200)
        .json(new ApiResponse(200, "Profile updated", user));
    } catch (err) {
      return res
        .status(500)
        .json(new ApiError(500, err?.message || "Internal server error"));
    }
  }
  static async changePassword(req, res) {
    const { oldPassword, newPassword } = req.body;
    if (!oldPassword || !newPassword) {
      return res
        .status(400)
        .json(new ApiError(400, "Please provide both old and new passwords"));
    }
    try {
      const user = await User.findById(req.user._id);
      if (!user) {
        return res.status(404).json(new ApiError(404, "User not found"));
      }
      const isMatch = await user.comparePassword(oldPassword);
      if (!isMatch) {
        return res
          .status(401)
          .json(new ApiError(401, "Incorrect old password"));
      }
      user.password = newPassword;
      await user.save();
      return res.status(200).json(new ApiResponse(200, "Password updated"));
    } catch (err) {
      return res
        .status(500)
        .json(new ApiError(500, err?.message || "Internal server error"));
    }
  }
}
export default UserController;
