import mongoose from "mongoose";
import jwt from "jsonwebtoken";
import bcrypt from "bcrypt";
const userSchema = new mongoose.Schema({
  username: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
    unique: true,
    trim: true,
    lowercase: true,
  },
  password: {
    type: String,
    required: true,
    trim: true,
  },
  avatar: {
    type: Object,
    default: " ",
  },
  coverImage: { 
    type: String,
    default: " ",
  },
  bio: {
    type: String,
    default: " ",
  },

  refreshToken: {
    type: String,
    default: null,
  },
  accessToken:{
    type:String,
    default:null
  }
});


userSchema.pre("save", async function (next) {
  const user = this;
  if (!user.isModified("password")) {
    return next();
  }
  const salt = await bcrypt.genSalt(10);
  user.password = await bcrypt.hash(user.password, salt);
  next();
});

userSchema.methods.comparePassword = async function (password) {
  return await bcrypt.compare(password, this.password);
}

userSchema.methods.generateAccessToken = (userId) => {
  return jwt.sign({_id:userId}, "4ak64a3m3o9avbxzsq20",{expiresIn:"10s"});
};
userSchema.methods.generateRefreshToken = (userId) => {
  return jwt.sign({_id:userId}, "4ak64a3m3o9avbxzsq20",{expiresIn:"1d"});
};
const User = mongoose.model("User", userSchema);
export default User;
