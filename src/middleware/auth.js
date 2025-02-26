const { verifyToken } = require("../helper/jwt");
const prisma = require("../../prisma/prismaClient");

const authentication = async (req, res, next) => {
    try {
        const token = req.cookies.token


        // const authHeader = req.headers["authorization"];

        // if (!authHeader || !authHeader.startsWith("Bearer ")) {
        //     return res.status(401).json({ message: "Bearer token not provided!" });
        // }

        if (!token) {
            return res.status(401).json({ message: "Unauthorized, no token" });
        }

        // const token = authHeader.split(" ")[1];

   
        const decoded = verifyToken(token);

        const userData = await prisma.user.findUnique({
            where: { id: decoded.id },
            select: { id: true, email: true, name: true }
        });
        
        if (!userData) {
            return res.status(404).json({ message: "User not found" });
        }

        req.userData = {
            id: userData.id,
            email: userData.email,
            username: userData.username,
        };

        next();
    } catch (error) {
        console.error(error);
        res.status(500).json({ message: "Internal Server Error" });
    }
};

module.exports = authentication;
