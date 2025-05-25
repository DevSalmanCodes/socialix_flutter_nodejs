
import { log } from "console";
import User from "../models/user.model.js";
import ApiError from "../utils/ApiError.js";
import ApiResponse from "../utils/ApiResonse.js";
import { uploadOnCloudinary } from "../utils/cloudinary.js"
import jwt from "jsonwebtoken";
class AuthController {
  async register(req, res) {

    const { username, email, password, bio } = req.body;

    if (!username || !email || !password) {
      return res
        .status(400)
        .json(new ApiError(400, "Please provide all fields"));
    }
    try {
      const avatarLocalPath = req.file;
      const existedUser = await User.findOne({ email: email });

      if (existedUser) {
        return res
          .status(400)
          .json(new ApiError(400, "User with this email already exist"));
      }
      let uploadRes;
      if (req.file) {
        uploadRes = await uploadOnCloudinary(avatarLocalPath.path);
      }

      const user = await User.create({
        username: username,
        email: email,
        password: password,
        bio: bio,
        avatar: {
          url: uploadRes?.url || '',
          public_id: uploadRes?.public_id || ''
        },
        coverImage: '',
      });
      user.avatar = user.avatar.url;
      user.password = undefined;
      user.accesToken = undefined;
      user.refreshToken = undefined;
      return res
        .status(201)
        .json(new ApiResponse(201, "User created successfuly", user));
    } catch (err) {
      console.log(err);

      return res

        .status(500)
        .json(new ApiError(500, err?.message || "Internal server error"));
    }
  }

  async login(req, res) {
    
    const { email, password } = req.body;

    if (!email || !password) {

      return res
        .status(400)
        .json(new ApiError(400, "Please provide all fields"));
    }
    try {

      const user = await User.findOne({ email: email });

      if (!user) {

        return res.status(404).json(new ApiError(404, "User not found"));
      }

      const isMatch = await user.comparePassword(password);

      if (!isMatch) {

        return res.status(400).json(new ApiError(400, "Incorrect password"));
      }

      const accessToken = user.generateAccessToken(user._id);
      const refreshToken = user.generateRefreshToken(user._id);
      const options = {
        httpOnly: true,
        secure: true,
      };
      user.refreshToken = refreshToken;
      user.accessToken = accessToken;

      user.password = undefined;
      user.avatar = user.avatar.url;
      
      return res
        .status(200)
        .cookie("accessToken", accessToken, options)
        .cookie("refreshToken", refreshToken, options)

        .json(
          new ApiResponse(200, "User logged in successfully", user)
        );
    } catch (err) {
      return res
        .status(500)
        .json(new ApiError(500, err?.message || "Internal server error"));
    }
  }
  async logout(req, res) {
    try {

      const user = await User.findByIdAndUpdate(
        req.user._id,
        {
          $unset: {
            refreshToken: 1,
          },
          $unset: {
            accessToken: 1
          }
        },
        { new: true }
      );
      user.password = undefined;
      
      user.avatar = null;
      const options = {
        httpOnly: true,
        secure: true,
      };

      return res
        .status(200)
        .clearCookie("accessToken", options)
        .clearCookie("refreshToken", options)
        .json(new ApiResponse(200, "Logged out successfuly", user));
    } catch (err) {
      return res
        .status(500)
        .json(new ApiError(500, err?.message || "Internal server error"));
    }
  }

  async refreshAccessToken(req, res) {
    const incomingRefreshToken =
      req.cookies.refreshToken || req.body.refreshToken;
    if (!incomingRefreshToken) {
      return res.status(401).json(new ApiError(401, "Unauthorized request"));
    }
    try {
      const decodedToken = jwt.verify(
        incomingRefreshToken,
        process.env.JWT_SECRET
      );

      const user = await User.findById(decodedToken?._id);
      if (!user) {
        return res.status(404).json(new ApiError(404, "Unauthorized request"));
      }
      if (incomingRefreshToken !== user?.refreshToken) {
        return res.status(401).json(new ApiError(401, "Token expired or used"));
      }
      const accessToken = user.generateAccessToken(user?._id);
      const refreshToken = user.generateRefreshToken(user?._id);

      const options = {
        httpOnly: true,
        secure: true,
      };
      return res
        .status(200)
        .cookie("accessToken", accessToken, options)
        .cookie("refreshToken", refreshToken, options)
        .json(
          new ApiResponse(200, "Token refreshed", {
            accessToken: accessToken,
            refreshToken: refreshToken,
          })
        );
    } catch (err) {
      return res
        .status(500)
        .json(new ApiError(500, err?.message || "Internal server error"));
    }
  }
}

export default new AuthController();
