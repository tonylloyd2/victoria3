import React, { useEffect, useState } from 'react';
import axios from 'axios';
import AddManager from './AddManager';

const ManagersList = () => {
    const [managers, setManagers] = useState([]);
    const [selectedManager, setSelectedManager] = useState(null);
    const [showAddManager, setShowAddManager] = useState(false); // Popup state for adding manager
    const [formData, setFormData] = useState({
        name: '',
        email: '',
        password: '',
        role: ''
    });
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState(null);

    useEffect(() => {
        fetchManagers();
    }, []);

    // Fetch all managers
    const fetchManagers = async () => {
        try {
            const response = await axios.get('/admin/managers/all');
            setManagers(response.data);
        } catch (err) {
            setError(err.message);
        } finally {
            setLoading(false);
        }
    };

    // Handle delete with confirmation
    const handleDelete = async (email) => {
        if (window.confirm('Are you sure you want to delete this manager?')) {
            try {
                await axios.delete(`/admin/managers/${email}`);
                setManagers(managers.filter(manager => manager.email !== email));
                alert('Manager deleted successfully');
            } catch (err) {
                console.error('Error deleting manager:', err);
                alert('Failed to delete manager');
            }
        }
    };

    // Handle edit - populate form data
    const handleEdit = (manager) => {
        setSelectedManager(manager);
        setFormData({
            name: manager.name,
            email: manager.email,
            password: '',
            role: manager.role
        });
    };

    // Handle form change
    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData(prevData => ({
            ...prevData,
            [name]: value
        }));
    };

    // Handle update manager
    const handleUpdate = async (e) => {
        e.preventDefault();
        try {
            await axios.put(`/admin/managers/${selectedManager.email}`, formData);
            setSelectedManager(null);
            fetchManagers(); // Refresh the list
            alert('Manager updated successfully');
        } catch (err) {
            console.error('Error updating manager:', err);
            alert('Failed to update manager');
        }
    };

    if (loading) return <p>Loading...</p>;
    if (error) return <p>Error loading managers: {error}</p>;

    return (
        <div>
            <h1 className="text-xl font-semibold">Managers List</h1>

            {/* Add Manager Button */}
            <button
                onClick={() => setShowAddManager(true)}
                className="mb-4 px-4 py-2 bg-green-500 text-white rounded"
            >
                Add Manager
            </button>

            {/* Add Manager Popup */}
            {showAddManager && (
                <div className="fixed inset-0 flex items-center justify-center bg-gray-900 bg-opacity-50">
                    <div className="bg-white p-6 rounded-lg shadow-lg w-96">
                        <h3 className="text-lg font-semibold mb-4">Add Manager</h3>
                        <AddManager />
                        <button
                            onClick={() => setShowAddManager(false)}
                            className="mt-4 px-4 py-2 bg-gray-500 text-white rounded"
                        >
                            Close
                        </button>
                    </div>
                </div>
            )}

            {selectedManager ? (
                // Edit Manager Form
                <div className="bg-white p-6 rounded-lg shadow-lg w-96">
                    <h3 className="text-lg font-semibold mb-4">Edit Manager</h3>
                    <form onSubmit={handleUpdate}>
                        <div>
                            <label>Name:</label>
                            <input
                                type="text"
                                name="name"
                                value={formData.name}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <div>
                            <label>Email:</label>
                            <input
                                type="email"
                                name="email"
                                value={formData.email}
                                onChange={handleChange}
                                required
                                disabled
                            />
                        </div>
                        <div>
                            <label>Password (Leave blank to keep current password):</label>
                            <input
                                type="password"
                                name="password"
                                value={formData.password}
                                onChange={handleChange}
                            />
                        </div>
                        <div>
                            <label>Role:</label>
                            <input
                                type="text"
                                name="role"
                                value={formData.role}
                                onChange={handleChange}
                                required
                            />
                        </div>
                        <button type="submit" className="px-4 py-2 bg-blue-500 text-white rounded">
                            Update Manager
                        </button>
                        <button
                            type="button"
                            onClick={() => setSelectedManager(null)}
                            className="ml-2 px-4 py-2 bg-gray-500 text-white rounded"
                        >
                            Cancel
                        </button>
                    </form>
                </div>
            ) : (
                // Managers List
                <ul>
                    {managers.map(manager => (
                        <li key={manager.email} className="p-2 border-b flex justify-between items-center">
                            <div>
                                {manager.name} - {manager.email} ({manager.role})
                            </div>
                            <div>
                                <button
                                    onClick={() => handleEdit(manager)}
                                    className="px-2 py-1 text-white bg-blue-500 rounded mr-2"
                                >
                                    Edit
                                </button>
                                <button
                                    onClick={() => handleDelete(manager.email)}
                                    className="px-2 py-1 text-white bg-red-500 rounded"
                                >
                                    Delete
                                </button>
                            </div>
                        </li>
                    ))}
                </ul>
            )}
        </div>
    );
};

export default ManagersList;
