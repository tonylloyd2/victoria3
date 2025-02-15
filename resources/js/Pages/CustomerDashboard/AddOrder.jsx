import React, { useState, useEffect } from 'react';
import axios from 'axios';
import {ProductList} from './ProductList'; // Import ProductList component

export const AddOrder = () => {
    const [order, setOrder] = useState({
        user_id: '',
        expected_delivery: new Date().toISOString().split('T')[0], // Set the current date as the default for expected_delivery
        payment_status: '',
        order_date: '',
        total_cost: 0,
        products_ordered: [], // This will store product_name and quantity
    });

    const [products, setProducts] = useState([]); // Store product details to fetch product_name
    const [showOrderForm, setShowOrderForm] = useState(false);

    useEffect(() => {
        fetchProducts();
    }, []);

    const fetchProducts = async () => {
        try {
            const response = await axios.get('/admin/products'); // Assuming this is your endpoint for fetching products
            setProducts(response.data);
        } catch (error) {
            console.error('Error fetching products:', error);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setOrder({
            ...order,
            [name]: value,
        });
    };

    const handleProductSelection = (selectedProducts) => {
        const productsOrdered = Object.keys(selectedProducts).map(productId => {
            const product = products.find(p => p.id === parseInt(productId));
            return {
                product_name: product ? product.name : '',
                quantity: parseInt(selectedProducts[productId], 10),  // Ensure quantity is an integer
            };
        });

        const totalCost = productsOrdered.reduce((total, product) => {
            const productDetails = products.find(p => p.name === product.product_name); // Find the product by name
            return total + (productDetails ? productDetails.price_per_unit * product.quantity : 0);
        }, 0);

        setOrder({
            ...order,
            products_ordered: productsOrdered,
            total_cost: totalCost,
        });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();

        // Ensure we have the correct structure for products_ordered
        const transformedOrder = {
            ...order,
            products_ordered: order.products_ordered.map(product => ({
                product_name: product.product_name, // Send product_name instead of product_id
                quantity: product.quantity, // Send quantity
            }))
        };

        console.log('Order Data:', transformedOrder); // Log the data before sending

        try {
            const response = await axios.post('/api/orders', transformedOrder);
            alert('Order created successfully!');
            setOrder({
                user_id: '',
                expected_delivery: new Date().toISOString().split('T')[0], // Reset to current date after submission
                payment_status: '',
                order_date: '',
                total_cost: 0,
                products_ordered: [],
            });
        } catch (error) {
            console.error('Error creating order:', error);
            alert('There was an error creating your order. Please try again.');
        }
    };

    return (
        <div>
            <h2>Create Order</h2>
            <ProductList onSelectProduct={handleProductSelection} />

            <button
                onClick={() => setShowOrderForm(true)}
                disabled={order.products_ordered.length === 0}
                className={`mt-4 px-4 py-2 ${order.products_ordered.length === 0 ? 'bg-gray-400' : 'bg-blue-500'} text-white rounded-md hover:bg-blue-700 transition duration-300`}
            >
                Add Order
            </button>

            {showOrderForm && (
                <form onSubmit={handleSubmit} className="mt-6">
                    <div>
                        <label htmlFor="user_id">User ID</label>
                        <input
                            type="text"
                            id="user_id"
                            name="user_id"
                            value={order.user_id}
                            onChange={handleChange}
                            required
                            className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                        />
                    </div>

                    <div>
                        <label htmlFor="expected_delivery">Expected Delivery</label>
                        <input
                            type="date"
                            id="expected_delivery"
                            name="expected_delivery"
                            value={order.expected_delivery}
                            onChange={handleChange}
                            required
                            className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                        />
                    </div>

                    <div>
                        <label htmlFor="payment_status">Payment Status</label>
                        <input
                            type="text"
                            id="payment_status"
                            name="payment_status"
                            value={order.payment_status}
                            onChange={handleChange}
                            required
                            className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                        />
                    </div>

                    <div>
                        <label htmlFor="order_date">Order Date</label>
                        <input
                            type="date"
                            id="order_date"
                            name="order_date"
                            value={order.order_date}
                            onChange={handleChange}
                            required
                            className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                        />
                    </div>

                    <div>
                        <label htmlFor="total_cost">Total Cost</label>
                        <input
                            type="number"
                            id="total_cost"
                            name="total_cost"
                            value={order.total_cost}
                            readOnly
                            required
                            className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                        />
                    </div>

                    {/* Products Ordered */}
                    <div>
                        <label>Products Ordered</label>
                        {order.products_ordered.map((product, index) => (
                            <div key={index} className="flex space-x-2 mt-2">
                                <input
                                    type="text"
                                    name="product_name"
                                    value={product.product_name}
                                    placeholder="Product Name"
                                    readOnly
                                    required
                                    className="p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                />
                                <input
                                    type="number"
                                    name="quantity"
                                    value={product.quantity}
                                    placeholder="Quantity"
                                    readOnly
                                    required
                                    className="p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                />
                            </div>
                        ))}
                    </div>

                    <button
                        type="submit"
                        className="mt-4 px-4 py-2 bg-green-500 text-white rounded-md hover:bg-green-700 transition duration-300"
                    >
                        Submit Order
                    </button>
                </form>
            )}
        </div>
    );
};

