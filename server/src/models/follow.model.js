import mongoose from "mongoose";
const followScema = new mongoose.Schema({
    followId:{
        type:mongoose.Types.ObjectId,
        ref:"User"
    },
    followerId:{
         type:mongoose.Types.ObjectId,
        ref:"User"
    }
})
export default mongoose.model("Follow",followScema);