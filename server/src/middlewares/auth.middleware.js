import ApiError from "../utils/ApiError.js";
import jwt from "jsonwebtoken";
const isAuthorizedUser = (req, res) => {
  try {
    const { incomingToken } = req.headers;
  if (!incomingToken) {
    return res.status(401).json(new ApiError(401, "Unauthorized"));
  }
  const token = incomingToken.split(" ")[1];
  const decodedToken = jwt.verify(token,"4ak64a3m3o9avbxzsq20",);
  if (!decodedToken) {
    return res.status(401).json(new ApiError(401, "Unauthorized"));
  }
  req.user = decodedToken;
  } catch (err) {
    return res.status(500).json(new ApiError(500, err.message || "Internal server error"));
  }
};

export default isAuthorizedUser;