class ApiError extends Error {
  constructor(statusCode, message) {
    super(message);
    this.success = false;
    this.statusCode = statusCode;
    this.message = message;
  }

  toJSON() {
    return {
      success: this.success,
      statusCode: this.statusCode,
      message: this.message,
    };
  }
}
export default ApiError;
