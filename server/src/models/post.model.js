import mongoose, { mongo } from "mongoose";
const postSchema = new mongoose.Schema({
    content:{
        type: String,
        trim: true,
        default: ""
    },
    postImage:{
        type: String,
        default: "",
    },
    likes:{
        type: mongoose.Schema.Types.ObjectId,
        ref:"Like",
        default:null
    },
    comments:{
        type: mongoose.Schema.Types.ObjectId,
        ref:"Comment",
        default:null
    },
    postedBy:{
        type: mongoose.Schema.Types.ObjectId,
        ref:"User",
        required:true
    },
},{timestamps:true},)
const Post = mongoose.model("Post", postSchema);
export default Post;