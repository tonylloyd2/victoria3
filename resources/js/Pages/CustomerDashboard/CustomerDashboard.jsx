import React, { useState } from 'react';
import {AddOrder} from './AddOrder';
import {OrderList} from './OrderList';
import {ProductList} from './ProductList'; // Import the ProductList component

export default function CustomerDashboard() {
    const [activePage, setActivePage] = useState('products'); // Set 'products' as default page
    const [isSidebarOpen, setIsSidebarOpen] = useState(true); // Sidebar toggle state

    const toggleSidebar = () => {
        setIsSidebarOpen(!isSidebarOpen); // Toggle sidebar visibility
    };

    return (
        <div className="min-h-screen bg-[#f4f7fc] flex">
            {/* Sidebar */}
            <div className={`fixed left-0 top-0 h-screen bg-[#2c3e50] text-white transition-all duration-300 ${isSidebarOpen ? 'w-64' : 'w-16'}`}>
                <div className="p-4 flex justify-between items-center">
                    <h2 className="text-xl font-semibold">{isSidebarOpen ? 'Customer Panel' : 'CP'}</h2>
                    <button onClick={toggleSidebar} className="text-white">
                        {isSidebarOpen ? '←' : '→'}
                    </button>
                </div>
                <div className="px-4 mt-6">
                    {/* Products Link */}
                    <button
                        className={`flex items-center p-3 w-full text-white rounded ${activePage === 'products' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
                        onClick={() => setActivePage('products')}
                    >
                        <span className="mr-3">🛍️</span>
                        Products
                    </button>
                    {/* Add Order Link */}
                    <button
                        className={`flex items-center p-3 w-full text-white rounded ${activePage === 'add-order' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
                        onClick={() => setActivePage('add-order')}
                    >
                        <span className="mr-3">📦</span>
                        Add Order
                    </button>
                    {/* Order List Link */}
                    <button
                        className={`flex items-center p-3 w-full text-white rounded ${activePage === 'order-list' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
                        onClick={() => setActivePage('order-list')}
                    >
                        <span className="mr-3">📝</span>
                        Order List
                    </button>
                </div>
            </div>

            {/* Main Content */}
            <div className="ml-64 w-full">
                {/* Top Bar */}
                <div className="bg-white shadow-md border-b border-gray-200 w-full fixed z-10 top-0 left-0">
                    <div className="flex justify-between items-center h-16 px-6">
                        <h1 className="text-2xl font-semibold text-gray-800">
                            {activePage === 'products' ? 'Products List' : activePage === 'add-order' ? 'Create Order' : 'Your Orders'}
                        </h1>
                    </div>
                </div>

                {/* Page Content */}
                <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 pt-20">
                    {activePage === 'products' && <ProductList />} {/* Show the ProductList as the default page */}
                    {activePage === 'add-order' && <AddOrder />}
                    {activePage === 'order-list' && <OrderList />}
                </div>
            </div>
        </div>
    );
}
