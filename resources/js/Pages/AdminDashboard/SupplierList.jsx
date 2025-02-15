import React, { useState, useEffect } from 'react';
import axios from 'axios';
import {AddSupplier} from './AddSupplier.jsx';

const SupplierList = () => {
    const [suppliers, setSuppliers] = useState([]);
    const [showAddSupplier, setShowAddSupplier] = useState(false); // Popup state
    const [isEditing, setIsEditing] = useState(false);
    const [editForm, setEditForm] = useState({
        id: '',
        name: '',
        email: '',
        mobile_number: '',
        materials_supplied: [{ material: '', price_per_unit: '' }]  // Ensure correct structure
    });

    // Fetch all suppliers on component mount
    useEffect(() => {
        fetchSuppliers();
    }, []);

    const fetchSuppliers = async () => {
        try {
            const response = await axios.get('/admin/suppliers');
            setSuppliers(response.data);
        } catch (error) {
            console.error('Error fetching suppliers:', error);
        }
    };

    const handleEdit = (supplier) => {
        setIsEditing(true);
        // Split material and price per unit from the fetched data
        const parsedMaterials = supplier.materials_supplied.map((item) => {
            const [material, price] = item.split(',');  // Assuming the format "material,price"
            return {
                material: material.trim(),
                price_per_unit: price ? price.trim() : ''
            };
        });

        setEditForm({
            id: supplier.id,
            name: supplier.name,
            email: supplier.email,
            mobile_number: supplier.mobile_number,
            materials_supplied: parsedMaterials
        });
    };

    const handleDelete = async (id) => {
        try {
            await axios.delete(`/admin/suppliers/${id}`);
            setSuppliers(suppliers.filter(supplier => supplier.id !== id));
            alert('Supplier deleted successfully');
        } catch (error) {
            console.error('Error deleting supplier:', error);
        }
    };

    return (
        <div>
            <h2 className="text-xl font-semibold">Supplier List</h2>

            {/* Add Supplier Button */}
            <button
                onClick={() => setShowAddSupplier(true)}
                className="mb-4 px-4 py-2 bg-green-500 text-white rounded"
            >
                Add Supplier
            </button>

            {/* Add Supplier Popup */}
            {showAddSupplier && (
                <div className="fixed inset-0 flex items-center justify-center bg-gray-900 bg-opacity-50">
                    <div className="bg-white p-6 rounded-lg shadow-lg w-96">
                        <h3 className="text-lg font-semibold mb-4">Add Supplier</h3>
                        <AddSupplier />
                        <button
                            onClick={() => setShowAddSupplier(false)}
                            className="mt-4 px-4 py-2 bg-gray-500 text-white rounded"
                        >
                            Close
                        </button>
                    </div>
                </div>
            )}

            <table className="w-full border-collapse border border-gray-300">
                <thead>
                    <tr className="bg-gray-200">
                        <th className="border border-gray-300 px-4 py-2">Name</th>
                        <th className="border border-gray-300 px-4 py-2">Email</th>
                        <th className="border border-gray-300 px-4 py-2">Mobile Number</th>
                        <th className="border border-gray-300 px-4 py-2">Materials Supplied</th>
                        <th className="border border-gray-300 px-4 py-2">Price per Unit</th>
                        <th className="border border-gray-300 px-4 py-2">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    {suppliers.map((supplier) => (
                        <tr key={supplier.id} className="border border-gray-300">
                            <td className="border border-gray-300 px-4 py-2">{supplier.name}</td>
                            <td className="border border-gray-300 px-4 py-2">{supplier.email}</td>
                            <td className="border border-gray-300 px-4 py-2">{supplier.mobile_number}</td>
                            <td className="border border-gray-300 px-4 py-2">
                                {supplier.materials_supplied.map((item, index) => {
                                    const [material, price] = item.split(',');  // Split material and price
                                    return (
                                        <div key={index}>
                                            {material.trim()}
                                        </div>
                                    );
                                })}
                            </td>
                            <td className="border border-gray-300 px-4 py-2">
                                {supplier.materials_supplied.map((item, index) => {
                                    const [material, price] = item.split(',');
                                    return (
                                        <div key={index}>
                                            {price ? price.trim() : 'N/A'}
                                        </div>
                                    );
                                })}
                            </td>
                            <td className="border border-gray-300 px-4 py-2">
                                <button
                                    onClick={() => handleEdit(supplier)}
                                    className="px-2 py-1 text-white bg-blue-500 rounded mr-2"
                                >
                                    Edit
                                </button>
                                <button
                                    onClick={() => handleDelete(supplier.id)}
                                    className="px-2 py-1 text-white bg-red-500 rounded"
                                >
                                    Delete
                                </button>
                            </td>
                        </tr>
                    ))}
                </tbody>
            </table>

            {isEditing && (
                <div>
                    <h3>Edit Supplier</h3>
                    <form>
                        <div>
                            <label>Name:</label>
                            <input
                                type="text"
                                name="name"
                                value={editForm.name}
                                onChange={(e) => setEditForm({ ...editForm, name: e.target.value })}
                                required
                            />
                        </div>
                        <div>
                            <label>Email:</label>
                            <input
                                type="email"
                                name="email"
                                value={editForm.email}
                                onChange={(e) => setEditForm({ ...editForm, email: e.target.value })}
                                required
                            />
                        </div>
                        <div>
                            <label>Mobile Number:</label>
                            <input
                                type="text"
                                name="mobile_number"
                                value={editForm.mobile_number}
                                onChange={(e) => setEditForm({ ...editForm, mobile_number: e.target.value })}
                                required
                            />
                        </div>
                        <div>
                            <label>Materials Supplied:</label>
                            {editForm.materials_supplied.map((material, index) => (
                                <div key={index}>
                                    <input
                                        type="text"
                                        value={`${material.material},${material.price_per_unit}`}
                                        onChange={(e) => {
                                            const values = [...editForm.materials_supplied];
                                            const [name, price] = e.target.value.split(',');
                                            values[index] = { material: name.trim(), price_per_unit: price ? price.trim() : '' };
                                            setEditForm({ ...editForm, materials_supplied: values });
                                        }}
                                        required
                                    />
                                    <button type="button" onClick={() => {
                                        const values = [...editForm.materials_supplied];
                                        values.splice(index, 1);
                                        setEditForm({ ...editForm, materials_supplied: values });
                                    }}>Remove</button>
                                </div>
                            ))}
                            <button type="button" onClick={() => {
                                setEditForm({ ...editForm, materials_supplied: [...editForm.materials_supplied, { material: '', price_per_unit: '' }] });
                            }}>Add Material</button>
                        </div>
                        <button type="submit">Update Supplier</button>
                    </form>
                </div>
            )}
        </div>
    );
};

export default SupplierList;
