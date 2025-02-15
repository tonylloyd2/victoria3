import React, { useState } from 'react';
import { Inertia } from '@inertiajs/inertia'; // Import Inertia for navigation
import {AddWeeklyPlan} from "./AddWeeklyPlan";
import AddProduction from "./AddProduction";
import { EmployeeList } from "./EmployeeList"; // Import EmployeeList component

// Import icons for sidebar items
import { FaHome, FaRegListAlt, FaBox, FaUsers, FaSignOutAlt } from 'react-icons/fa';

export default function ManagerDashboard() {
    const [selectedView, setSelectedView] = useState('home'); // State to manage selected view

    // Function to handle logout
    const handleLogout = async () => {
        try {
            // Perform a POST request to logout the user
            await Inertia.post('/logout');
            // Redirect to the login page after successful logout
            Inertia.visit('/login');
        } catch (error) {
            console.error('Error logging out:', error);
            alert('Logout failed. Please try again.');
        }
    };

    return (
        <div className="flex h-screen overflow-hidden">
            {/* Sidebar */}
            <div className="sidebar bg-gray-800 text-white w-64 fixed top-0 left-0 h-full p-4">
                <h2 className="text-center text-xl font-bold mb-8">Manager</h2>
                <ul>
                    <li
                        className="flex items-center py-3 px-4 hover:bg-gray-600 rounded-md cursor-pointer"
                        onClick={() => setSelectedView('home')}
                    >
                        <FaHome className="mr-3" /> Home
                    </li>
                    
                    <li
                        className="flex items-center py-3 px-4 hover:bg-gray-600 rounded-md cursor-pointer"
                        onClick={() => setSelectedView('addWeeklyPlan')}
                    >
                        <FaRegListAlt className="mr-3" /> Add Weekly Plan
                    </li>
                    <li
                        className="flex items-center py-3 px-4 hover:bg-gray-600 rounded-md cursor-pointer"
                        onClick={() => setSelectedView('production')}
                    >
                        <FaBox className="mr-3" /> Production
                    </li>
                    <li
                        className="flex items-center py-3 px-4 hover:bg-gray-600 rounded-md cursor-pointer"
                        onClick={() => setSelectedView('employees')}
                    >
                        <FaUsers className="mr-3" /> Employees
                    </li>
                    <li
                        onClick={handleLogout}
                        className="flex items-center py-3 px-4 mt-8 hover:bg-red-600 rounded-md cursor-pointer"
                    >
                        <FaSignOutAlt className="mr-3" /> Logout
                    </li>
                </ul>
            </div>

            {/* Main content area */}
            <div className="flex-1 ml-28"> {/* Reduced the margin to ml-28 */}
                {/* Header */}
                <header className="bg-gray-800 text-white flex justify-between items-center p-4 w-full fixed top-0 left-56">
                    <div className="text-2xl font-semibold">Manager Dashboard</div>
                    <button
                        onClick={handleLogout}
                        className="px-4 py-2 bg-red-500 text-white rounded-lg hover:bg-red-700 transition duration-300"
                    >
                        Logout
                    </button>
                </header>

                {/* Main content */}
                <div className="p-1 mt-10">
                    {selectedView === 'home' && <div>Welcome to the Manager Dashboard</div>}
                    {selectedView === 'weeklyPlans' && <WeeklyPlanList />}
                    {selectedView === 'addWeeklyPlan' && <AddWeeklyPlan />}
                    {selectedView === 'production' && <AddProduction />}
                    {selectedView === 'employees' && <EmployeeList />}
                </div>
            </div>
        </div>
    );
}