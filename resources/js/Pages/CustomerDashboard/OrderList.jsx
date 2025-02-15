import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Edit2, Trash2 } from 'lucide-react';

export const OrderList = () => {
    const [orders, setOrders] = useState([]);
    const [products, setProducts] = useState([]);
    const [isLoading, setIsLoading] = useState(true);
    const [selectedOrder, setSelectedOrder] = useState(null);  // Store selected order for editing
    const [orderData, setOrderData] = useState({
        expected_delivery: '',
        payment_status: '',
        products_ordered: [],  // Initialize as an empty array
        total_cost: '',
    });

    useEffect(() => {
        fetchOrders();
        fetchProducts();
    }, []);

    // Fetch all orders
    const fetchOrders = async () => {
        try {
            const response = await axios.get('/api/orders');
            const ordersData = response.data.map(order => {
                // Parse the products_ordered JSON string to an array
                order.products_ordered = JSON.parse(order.products_ordered);
                return order;
            });
            setOrders(ordersData);
        } catch (error) {
            console.error('Error fetching orders:', error);
        } finally {
            setIsLoading(false);
        }
    };

    // Fetch all products
    const fetchProducts = async () => {
        try {
            const response = await axios.get('/admin/products');
            setProducts(response.data);
        } catch (error) {
            console.error('Error fetching products:', error);
        }
    };

    // Handle delete order
    const handleDelete = async (id) => {
        if (window.confirm('Are you sure you want to delete this order?')) {
            try {
                await axios.delete(`/api/orders/${id}`);
                setOrders(orders.filter(order => order.id !== id));
                alert('Order deleted successfully');
            } catch (error) {
                console.error('Error deleting order:', error);
                alert('Failed to delete order');
            }
        }
    };

    // Handle Edit Button click
    const handleEdit = (order) => {
        setSelectedOrder(order.id);
        setOrderData({
            expected_delivery: order.expected_delivery,
            payment_status: order.payment_status,
            products_ordered: Array.isArray(order.products_ordered) ? order.products_ordered : [], // Ensure it's an array
            total_cost: order.total_cost,
        });
    };

    // Handle updating the order
    const handleUpdate = async (e) => {
        e.preventDefault();

        try {
            const updatedOrderData = {
                ...orderData,
                products_ordered: orderData.products_ordered, // Ensure products_ordered is an array
            };

            // Send the PUT request to update the order
            await axios.put(`/api/orders/${selectedOrder}`, updatedOrderData);

            setSelectedOrder(null);  // Close the form after updating
            fetchOrders();  // Refresh the orders list
            alert('Order updated successfully!');
        } catch (error) {
            console.error('Error updating order:', error);
            alert('Failed to update order');
        }
    };

    // Handle product selection and quantity change
    const handleProductChange = (index, e) => {
        const { name, value } = e.target;
        const updatedProducts = [...orderData.products_ordered];
        updatedProducts[index][name] = value;
        setOrderData({ ...orderData, products_ordered: updatedProducts });
        calculateTotalCost(updatedProducts);
    };

    // Calculate total cost based on selected products and quantities
    const calculateTotalCost = (productsOrdered) => {
        let totalCost = 0;
        productsOrdered.forEach(product => {
            const productDetails = products.find(p => p.name === product.product_name); // Find the product by name
            return totalCost += productDetails ? productDetails.price_per_unit * product.quantity : 0;
        });
        setOrderData({ ...orderData, total_cost: totalCost });
    };

    // Add a new product to the order
    const addProductToOrder = () => {
        setOrderData((prevData) => ({
            ...prevData,
            products_ordered: [
                ...prevData.products_ordered,
                { product_name: '', quantity: 1 },
            ],
        }));
    };

    // Render orders list
    return (
        <div className="p-6 bg-white rounded-lg shadow-md">
            <h2 className="text-2xl font-bold mb-4">Your Orders</h2>
            {isLoading ? (
                <p>Loading orders...</p>
            ) : (
                <table className="min-w-full bg-white border border-gray-300">
                    <thead>
                        <tr>
                            <th className="py-2 px-4 border-b">Order ID</th>
                            <th className="py-2 px-4 border-b">Date Placed</th>
                            <th className="py-2 px-4 border-b">Expected Delivery</th>
                            <th className="py-2 px-4 border-b">Payment Status</th>
                            <th className="py-2 px-4 border-b">Products Ordered</th>
                            <th className="py-2 px-4 border-b">Total Cost</th>
                            <th className="py-2 px-4 border-b">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        {orders.length > 0 ? (
                            orders.map((order) => (
                                <tr key={order.id}>
                                    <td className="py-2 px-4 border-b">{order.id}</td>
                                    <td className="py-2 px-4 border-b">{new Date(order.created_at).toLocaleDateString()}</td>
                                    <td className="py-2 px-4 border-b">{new Date(order.expected_delivery).toLocaleDateString()}</td>
                                    <td className="py-2 px-4 border-b">{order.payment_status}</td>
                                    <td className="py-2 px-4 border-b">
                                        {order.products_ordered && Array.isArray(order.products_ordered) ? (
                                            <ul>
                                                {order.products_ordered.map((product, index) => {
                                                    // Find the product name using the product_id
                                                    const productDetails = products.find(p => p.name === product.product_name);
                                                    return (
                                                        <li key={index}>
                                                            {productDetails ? productDetails.name : 'Unknown Product'} (x{product.quantity})
                                                        </li>
                                                    );
                                                })}
                                            </ul>
                                        ) : (
                                            <p>No products ordered</p>
                                        )}
                                    </td>
                                    <td className="py-2 px-4 border-b">${order.total_cost}</td>
                                    <td className="py-2 px-4 border-b">
                                        <button
                                            onClick={() => handleEdit(order)}
                                            className="px-2 py-1 bg-blue-500 text-white rounded-md hover:bg-blue-700 transition duration-300 mr-2"
                                        >
                                            <Edit2 size={18} /> Edit
                                        </button>
                                        <button
                                            onClick={() => handleDelete(order.id)}
                                            className="px-2 py-1 bg-red-500 text-white rounded-md hover:bg-red-700 transition duration-300"
                                        >
                                            <Trash2 size={18} /> Delete
                                        </button>
                                    </td>
                                </tr>
                            ))
                        ) : (
                            <tr>
                                <td colSpan="7" className="py-2 px-4 text-center">No orders found</td>
                            </tr>
                        )}
                    </tbody>
                </table>
            )}

            {/* Edit Form Modal or Section */}
            {selectedOrder && (
                <div className="fixed inset-0 flex items-center justify-center bg-gray-900 bg-opacity-50">
                    <div className="bg-white p-6 rounded-lg shadow-lg w-96">
                        <h3 className="text-xl font-semibold mb-4">Edit Order</h3>
                        <form onSubmit={handleUpdate} className="space-y-4">
                            <div>
                                <label htmlFor="expected_delivery" className="block text-sm font-medium text-gray-700">Expected Delivery</label>
                                <input
                                    type="date"
                                    id="expected_delivery"
                                    value={orderData.expected_delivery}
                                    onChange={(e) => setOrderData({ ...orderData, expected_delivery: e.target.value })}
                                    required
                                    className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                />
                            </div>

                            <div>
                                <label htmlFor="payment_status" className="block text-sm font-medium text-gray-700">Payment Status</label>
                                <input
                                    type="text"
                                    id="payment_status"
                                    value={orderData.payment_status}
                                    onChange={(e) => setOrderData({ ...orderData, payment_status: e.target.value })}
                                    required
                                    className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                />
                            </div>

                            <div>
                                <label htmlFor="total_cost" className="block text-sm font-medium text-gray-700">Total Cost</label>
                                <input
                                    type="number"
                                    id="total_cost"
                                    value={orderData.total_cost}
                                    readOnly
                                    className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                    min="0"
                                />
                            </div>

                            <div>
                                <label htmlFor="products_ordered" className="block text-sm font-medium text-gray-700">Products Ordered</label>
                                {orderData.products_ordered.map((product, index) => (
                                    <div key={index} className="flex space-x-2 mt-2">
                                        <select
                                            name="product_name"
                                            value={product.product_name}
                                            onChange={(e) => handleProductChange(index, e)}
                                            required
                                            className="p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                        >
                                            <option value="">Select Product</option>
                                            {products.map((product) => (
                                                <option key={product.id} value={product.name}>
                                                    {product.name}
                                                </option>
                                            ))}
                                        </select>
                                        <input
                                            type="number"
                                            name="quantity"
                                            placeholder="Quantity"
                                            value={product.quantity}
                                            onChange={(e) => handleProductChange(index, e)}
                                            required
                                            className="p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                            min="1"
                                        />
                                    </div>
                                ))}
                                <button
                                    type="button"
                                    onClick={addProductToOrder}
                                    className="mt-2 px-2 py-1 bg-green-500 text-white rounded-md hover:bg-green-700 transition duration-300"
                                >
                                    Add Product
                                </button>
                            </div>

                            <div className="flex space-x-2 mt-4">
                                <button
                                    type="submit"
                                    className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-700 transition duration-300"
                                >
                                    Update Order
                                </button>
                                <button
                                    type="button"
                                    onClick={() => setSelectedOrder(null)}
                                    className="px-4 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-700 transition duration-300"
                                >
                                    Cancel
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            )}
        </div>
    );
};

