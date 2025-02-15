import React, { useState, useEffect } from 'react';
import axios from 'axios';

const ProductList = () => {
    const [products, setProducts] = useState([]);
    const [isEditing, setIsEditing] = useState(false);
    const [isAdding, setIsAdding] = useState(false);  // To control showing the add form
    const [editForm, setEditForm] = useState({
        id: '',
        name: '',
        price_per_unit: '',
        availability_in_stock: false, // Default to false (No)
        image: null,
    });

    useEffect(() => {
        fetchProducts();
    }, []);

    const fetchProducts = async () => {
        try {
            const response = await axios.get('/admin/products');
            setProducts(response.data);
        } catch (error) {
            console.error('Error fetching products:', error);
        }
    };

    const handleEdit = (product) => {
        setIsEditing(true);
        setEditForm({
            id: product.id,
            name: product.name,
            price_per_unit: product.price_per_unit,
            availability_in_stock: product.availability_in_stock,
            image: null,
        });
    };

    const handleDelete = async (id) => {
        try {
            await axios.delete(`/admin/products/${id}`);
            setProducts(products.filter(product => product.id !== id));
            alert('Product deleted successfully');
        } catch (error) {
            console.error('Error deleting product:', error);
        }
    };

    const handleChange = (e) => {
        const { name, value } = e.target;
        setEditForm({
            ...editForm,
            [name]: value,
        });
    };

    const handleImageChange = (e) => {
        setEditForm({
            ...editForm,
            image: e.target.files[0], // Store the selected image file
        });
    };

    const handleAvailabilityChange = (e) => {
        setEditForm({
            ...editForm,
            availability_in_stock: e.target.checked, // Handle checkbox for Yes/No
        });
    };

    const handleUpdate = async (e) => {
        e.preventDefault();

        const formData = new FormData();
        formData.append('name', editForm.name);
        formData.append('price_per_unit', editForm.price_per_unit);
        formData.append('availability_in_stock', editForm.availability_in_stock ? 1 : 0); // Convert boolean to 1/0 for database
        if (editForm.image) formData.append('image', editForm.image); // Append the image if it's selected

        try {
            const response = await axios.put(`/admin/products/${editForm.id}`, formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            setProducts(
                products.map((product) =>
                    product.id === editForm.id ? response.data : product
                )
            );
            setIsEditing(false);
            setEditForm({ id: '', name: '', price_per_unit: '', availability_in_stock: false, image: null });
            alert('Product updated successfully');
        } catch (error) {
            console.error('Error updating product:', error);
        }
    };

    const handleAddProduct = () => {
        setIsAdding(true);
        setEditForm({
            id: '',
            name: '',
            price_per_unit: '',
            availability_in_stock: false,
            image: null,
        });
    };

    const handleAddSubmit = async (e) => {
        e.preventDefault();
        const formData = new FormData();
        formData.append('name', editForm.name);
        formData.append('price_per_unit', editForm.price_per_unit);
        formData.append('availability_in_stock', editForm.availability_in_stock ? 1 : 0); // Convert boolean to 1/0 for database
        if (editForm.image) formData.append('image', editForm.image); // Append the image if it's selected

        try {
            const response = await axios.post('/admin/products', formData, {
                headers: {
                    'Content-Type': 'multipart/form-data',
                },
            });
            setProducts([...products, response.data]);
            setIsAdding(false);
            setEditForm({ id: '', name: '', price_per_unit: '', availability_in_stock: false, image: null });
            alert('Product added successfully');
        } catch (error) {
            console.error('Error adding product:', error);
        }
    };

    const handleCloseModal = () => {
        setIsAdding(false); // Close the modal
    };

    return (
        <div>
            <h2>Product List</h2>

            {/* Button to show Add Product Form at the top */}
            <button onClick={handleAddProduct} style={{ marginBottom: '20px' }}>Add Product</button>

            {/* Display Product Table */}
            <table>
                <thead>
                    <tr>
                        <th>Product Name</th>
                        <th>Price per Unit</th>
                        <th>Stock Availability</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {products.map((product) => (
                        <tr key={product.id}>
                            <td>{product.name}</td>
                            <td>{product.price_per_unit}</td>
                            <td>{product.availability_in_stock ? "Yes" : "No"}</td>
                            <td><img src={`/storage/${product.image_path.split('public/')[1]}`} alt={product.name} style={{ maxWidth: '100px', maxHeight: '100px' }} /></td> {/* Resize the image */}
                            <td>
                                <button onClick={() => handleEdit(product)}>Edit</button>
                                <button onClick={() => handleDelete(product.id)}>Delete</button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            {/* Show Add Product Modal */}
            {isAdding && (
                <div style={styles.modalOverlay}>
                    <div style={styles.modalContent}>
                        <h3>Add New Product</h3>
                        <form onSubmit={handleAddSubmit}>
                            <div>
                                <label>Product Name:</label>
                                <input
                                    type="text"
                                    name="name"
                                    value={editForm.name}
                                    onChange={handleChange}
                                    required
                                />
                            </div>
                            <div>
                                <label>Price per Unit:</label>
                                <input
                                    type="number"
                                    name="price_per_unit"
                                    value={editForm.price_per_unit}
                                    onChange={handleChange}
                                    required
                                />
                            </div>
                            <div>
                                <label>Availability in Stock:</label>
                                <input
                                    type="checkbox"
                                    checked={editForm.availability_in_stock}
                                    onChange={handleAvailabilityChange} // Handle checkbox change
                                />
                            </div>
                            <div>
                                <label>Product Image:</label>
                                <input
                                    type="file"
                                    name="image"
                                    onChange={handleImageChange}
                                />
                            </div>
                            <button type="submit">Add Product</button>
                            <button type="button" onClick={handleCloseModal}>Close</button>
                        </form>
                    </div>
                </div>
            )}

            {/* Show Edit Product Form */}
            {isEditing && (
                <div style={{ border: '1px solid #000', padding: '20px', marginTop: '30px' }}>
                    <h3>Edit Product</h3>
                    <form onSubmit={handleUpdate}>
                        <div>
                            <label>Product Name:</label>
                            <input
                                type="text"
                                name="name"
                                value={editForm.name}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div>
                            <label>Price per Unit:</label>
                            <input
                                type="number"
                                name="price_per_unit"
                                value={editForm.price_per_unit}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div>
                            <label>Availability in Stock:</label>
                            <input
                                type="checkbox"
                                checked={editForm.availability_in_stock}
                                onChange={handleAvailabilityChange} // Handle checkbox change
                            />
                        </div>
                        <div>
                            <label>Product Image:</label>
                            <input
                                type="file"
                                name="image"
                                onChange={handleImageChange}
                            />
                        </div>
                        <button type="submit">Update Product</button>
                    </form>
                </div>
            )}
        </div>
    );
};

const styles = {
    modalOverlay: {
        position: 'fixed',
        top: 0,
        left: 0,
        right: 0,
        bottom: 0,
        backgroundColor: 'rgba(0, 0, 0, 0.5)',
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
    },
    modalContent: {
        backgroundColor: '#fff',
        padding: '20px',
        borderRadius: '5px',
        width: '400px',
        boxShadow: '0 4px 8px rgba(0, 0, 0, 0.1)',
    },
};

export default ProductList;
