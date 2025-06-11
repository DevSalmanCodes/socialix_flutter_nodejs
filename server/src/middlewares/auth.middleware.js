import ApiError from "../utils/ApiError.js";
import jwt from "jsonwebtoken";
const isAuthorizedUser = (req, res,next) => {

  try {

    const { authorization } = req.headers;

    if (!authorization) {

      return res.status(401).json(new ApiError(401, "Unauthorized"));
    }
    const token = authorization.split(" ")[1];

    const decodedToken = jwt.verify(token, "4ak64a3m3o9avbxzsq20",);

    if (!decodedToken) {

      return res.status(401).json(new ApiError(401, "Unauthorized"));
    }

    req.user = decodedToken;
    next();

  } catch (err) {
    console.log(err);

    if (err.name === "TokenExpiredError") {
      return res.status(401).json(new ApiError(401, "Token expired"));
    } else if (err.name === "JsonWebTokenError") {
      return res.status(401).json(new ApiError(401, "Invalid token"));
    }
    return res.status(500).json(new ApiError(500, err.message || "Internal server error"));
  }


};

export default isAuthorizedUser;