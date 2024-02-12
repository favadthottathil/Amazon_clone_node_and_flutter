const express = require('express');
const admin = require('../Middlewares/admin');
const Product = require('../Models/product');

const adminRouter = express.Router();

// Add Product

adminRouter.post("/admin/add-product",admin, async function(req,res){

     try {
        const {name,description,images,quantity,price,category} = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        
     } catch (e) {
        res.status(500).json({error: e.message});
     }

});