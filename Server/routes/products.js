const express = require("express");
const auth = require("../Middlewares/auth");
const Product = require("../Models/product");
const productRouter = express.Router();

// Get All Products

productRouter.get("/api/products", auth, async function (req, res) {
    try {
        const products = await Product.find({ category: req.query.category });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });

    }
});

// Search a product

productRouter.get("/api/products/search/:name", auth, async function (req, res) {
    try {
        const products = await Product.find({
            name: { $regex: req.params.name, $options: "i" },
        });
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });

    }
});



module.exports = productRouter;