const express = require('express');
const admin = require('../Middlewares/admin');
const { Product } = require('../Models/product');

const adminRouter = express.Router();

// Add Product

adminRouter.post("/admin/add-product", admin, async function (req, res) {

   try {
      const { name, description, images, quantity, price, category } = req.body;
      let product = new Product({
         name,
         description,
         images,
         quantity,
         price,
         category,
      });
      product = await product.save();
      res.json(product);
   } catch (e) {
      res.status(500).json({ error: e.message });
   }
});

// Get all Products

adminRouter.get("/admin/get-products", admin, async function (req, res) {
   try {
      const products = await Product.find({});
      res.json(products);
   } catch (e) {
      res.status(500).json({ error: e.message });
   };
})

// Delete the product

adminRouter.post('/admin/delete-product', admin, async function (req, res) {
   try {
      const { id } = req.body;
      let product = await Product.findByIdAndDelete(id);
      res.json(product);
   } catch (e) {
      res.status(500).json({ error: e.message });
   }
});




module.exports = adminRouter;