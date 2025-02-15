import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { AddFactory } from './AddFactory';

export const FactoryList = ({ onEdit }) => {
    const [factories, setFactories] = useState([]);
    const [showAddFactory, setShowAddFactory] = useState(false); // Popup state

    useEffect(() => {
        // Fetch all factories
        axios.get('/api/factories')
            .then(response => {
                setFactories(response.data);
            })
            .catch(error => {
                console.error('There was an error fetching the factories!', error);
            });
    }, []);

    const handleDelete = (id) => {
        axios.delete(`/api/factories/${id}`)
            .then(response => {
                setFactories(factories.filter(factory => factory.id !== id));
                console.log('Factory deleted successfully', response.data);
            })
            .catch(error => {
                console.error('There was an error deleting the factory!', error);
            });
    };

    return (
        <div>
            <h1 className="text-xl font-semibold">Factory List</h1>

            {/* Add Factory Button */}
            <button
                onClick={() => setShowAddFactory(true)}
                className="mb-4 px-4 py-2 bg-green-500 text-white rounded"
            >
                Add Factory
            </button>

            {/* Add Factory Popup */}
            {showAddFactory && (
                <div className="fixed inset-0 flex items-center justify-center bg-gray-900 bg-opacity-50">
                    <div className="bg-white p-6 rounded-lg shadow-lg w-96">
                        <h3 className="text-lg font-semibold mb-4">Add Factory</h3>
                        <AddFactory />
                        <button
                            onClick={() => setShowAddFactory(false)}
                            className="mt-4 px-4 py-2 bg-gray-500 text-white rounded"
                        >
                            Close
                        </button>
                    </div>
                </div>
            )}

            <ul>
                {factories.map(factory => (
                    <li key={factory.id} className="p-2 border-b flex justify-between items-center">
                        <div>
                            {factory.name} - {factory.location}
                        </div>
                        <div>
                            <button
                                onClick={() => onEdit(factory)}
                                className="px-2 py-1 text-white bg-blue-500 rounded mr-2"
                            >
                                Edit
                            </button>
                            <button
                                onClick={() => handleDelete(factory.id)}
                                className="px-2 py-1 text-white bg-red-500 rounded"
                            >
                                Delete
                            </button>
                        </div>
                    </li>
                ))}
            </ul>
        </div>
    );
};
