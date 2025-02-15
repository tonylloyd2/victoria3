import React, { useState, useEffect } from 'react';
import axios from 'axios';

export const ProductList = ({ onSelectProduct }) => {
    const [products, setProducts] = useState([]);
    const [selectedProducts, setSelectedProducts] = useState({});

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

    const handleSelectProduct = (productId, quantity) => {
        const updatedSelectedProducts = { ...selectedProducts, [productId]: quantity };
        setSelectedProducts(updatedSelectedProducts);
        onSelectProduct(updatedSelectedProducts); // Passing selected products to parent
    };

    return (
        <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-6">
            {products.map((product) => (
                <div key={product.id} className="bg-white shadow-lg rounded-lg overflow-hidden">
                    <img
                        src={`/storage/${product.image_path.split('public/')[1]}`} 
                        alt={product.name}
                        className="w-full h-48 object-cover"
                    />
                    <div className="p-4">
                        <h3 className="text-xl font-semibold text-gray-800">{product.name}</h3>
                        <p className="text-gray-600">Price: {product.price_per_unit} USD</p>
                        <p className="text-gray-500">Stock: {product.availability_in_stock ? 'In Stock' : 'Out of Stock'}</p>

                        {/* Checkbox and Quantity Selection */}
                        <div className="mt-4">
                            <label className="flex items-center space-x-2">
                                <input
                                    type="checkbox"
                                    onChange={(e) => handleSelectProduct(product.id, e.target.checked ? 1 : 0)}
                                    className="form-checkbox h-5 w-5 text-indigo-500"
                                />
                                <span className="text-sm">Select</span>
                            </label>
                            <input
                                type="number"
                                placeholder="Quantity"
                                min="1"
                                value={selectedProducts[product.id] || 0}
                                onChange={(e) => handleSelectProduct(product.id, e.target.value)}
                                className="mt-2 p-2 text-sm border border-gray-300 rounded-md focus:outline-none focus:ring-1 focus:ring-indigo-500"
                            />
                        </div>
                    </div>
                </div>
            ))}
        </div>
    );
};

