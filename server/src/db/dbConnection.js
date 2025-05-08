import mongoose from "mongoose";

const connectDb = async () => {
  try {
    const connectionInstance = await mongoose.connect("mongodb://localhost:27017/socially");
    console.log(`MongoDB connected: ${connectionInstance.connection.host}`);
  } catch (err) {
    console.log("Error connecting to MongoDB: ", err);
    process.exit(1);
  }
};
export default connectDb;
