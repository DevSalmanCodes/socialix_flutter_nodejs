import { v2 as cloudinary } from "cloudinary";
import fs from "fs";
async function uploadOnCloudinary(localFilePath) {
  try {
    cloudinary.config({
      cloud_name: "dcub10h9l",
      api_key: "425233367927479",
      api_secret: "6db-TvzoeRqy5kY661GW4qvTI3I",
    });
 
    const uploadResult = await cloudinary.uploader.upload(localFilePath, {
      resource_type: "auto",
    });
    fs.unlinkSync(localFilePath);
    return uploadResult;
  } catch (err) {
    console.log(err);
    
    fs.unlinkSync(localFilePath);
    return null;
  }
}

async function deleteCloudinaryFile(publicId) {
  try {
    await cloudinary.uploader.destroy(publicId);
    return true;
  } catch (err) {
    return false;
  }
}

export  {uploadOnCloudinary, deleteCloudinaryFile};