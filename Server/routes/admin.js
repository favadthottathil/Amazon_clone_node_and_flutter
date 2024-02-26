const express = require('express');
const admin = require('../Middlewares/admin');
const { Product } = require('../Models/product');
const Order = require('../Models/order');

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

// Get all Orders

adminRouter.get('/admin/get-orders', admin, async function (req, res) {
   try {
      const orders = await Order.find({});
      res.json(orders);
   } catch (e) {
      res.status(500).json({ error: e.message });
   }
});

// UPDATE ORDER STATUS

adminRouter.post('/admin/change-order-status', admin, async function (req, res) {
   try {
      const { id, status } = req.body;
      let order = await Order.findById(id);
      order.status = status;
      order = await order.save();
      res.json(order);
   } catch (e) {
      res.status(500).json({ error: e.message });
   }
});

// get analytics

adminRouter.get('/admin/analytics', admin, async function (req, res) {
   try {
      const orders = await Order.find({});
      let toatalEarings = 0;
      for (let i = 0; i < orders.length; i++) {
         for (let j = 0; j < orders[i].products.length; j++) {
            toatalEarings += orders[i].products[j].quantity * orders[i].products[j].product.price;
         }
      }
      // category wise order fetching
      let mobileEarnings = await fetchCategoryWiseProduct('Mobiles');
      let essentialsEarnings = await fetchCategoryWiseProduct('Essentials');
      let appliancesEarnings = await fetchCategoryWiseProduct('Appliances');
      let booksEarnings = await fetchCategoryWiseProduct('Books');
      let fashionEarnings = await fetchCategoryWiseProduct('Fashion');

      let earings = {
         toatalEarings,
         mobileEarnings,
         essentialsEarnings,
         appliancesEarnings,
         booksEarnings,
         fashionEarnings,
      }
      res.json(earings);
   } catch (e) {
      res.status(500).json({ error: e.message });
   }
});

async function fetchCategoryWiseProduct(category) {
   let earings = 0;
   let categoryOrder = Order.find({
      'products.product.category': category,
   });
   for (let i = 0; i < categoryOrder.length; i++) {
      for (let j = 0; j < categoryOrder[i].products.length; j++) {
         earings += categoryOrder[i].products[j].quantity * categoryOrder[i].products[j].product.price;
      }
   }
   return earings;
}

module.exports = adminRouter;