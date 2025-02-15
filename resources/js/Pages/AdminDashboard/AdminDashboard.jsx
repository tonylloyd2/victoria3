import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { AddEmployee } from './AddEmployee.jsx';
import { FactoryList } from './FactoryList.jsx';
import { EmployeeList } from './EmployeeList.jsx';
import { ProductionList } from './ProductionList.jsx';
import ProductList from './ProductList.jsx';
import MaterialList from './MaterialsList.jsx';
import SupplierList from './SupplierList.jsx';
import ManagersList from './ManagerList.jsx';
import WeeklyPlansList from './WeeklyPlanList.jsx'; // <-- Import Weekly Plans
import { Users, Factory, BarChart3, LogOut, ChevronDown, Package, Layers, Truck, Briefcase, Calendar } from 'lucide-react';

export default function AdminDashboard() {
  const [activePage, setActivePage] = useState('employees');
  const [showProfileMenu, setShowProfileMenu] = useState(false);

  const handleLogout = async () => {
    try {
      await axios.post('/logout');
      window.location.href = '/login';
    } catch (error) {
      console.error('Logout failed:', error);
    }
  };

  return (
    <div className="min-h-screen bg-[#f4f7fc]">
      {/* Sidebar */}
      <div className="fixed left-0 top-0 w-64 h-screen bg-[#2c3e50]">
        <div className="p-4">
          <h2 className="text-white text-xl font-semibold">Admin Panel</h2>
        </div>
        <div className="px-4 mt-6">
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'employees' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('employees')}
          >
            <Users className="w-5 h-5 mr-3" />
            Employees
          </button>
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'factories' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('factories')}
          >
            <Factory className="w-5 h-5 mr-3" />
            Factories
          </button>
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'production' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('production')}
          >
            <BarChart3 className="w-5 h-5 mr-3" />
            Production
          </button>
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'products' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('products')}
          >
            <Package className="w-5 h-5 mr-3" />
            Products
          </button>
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'materials' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('materials')}
          >
            <Layers className="w-5 h-5 mr-3" />
            Materials
          </button>
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'suppliers' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('suppliers')}
          >
            <Truck className="w-5 h-5 mr-3" />
            Suppliers
          </button>
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'managers' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('managers')}
          >
            <Briefcase className="w-5 h-5 mr-3" />
            Managers
          </button>
          <button
            className={`flex items-center p-3 w-full text-white rounded ${activePage === 'weekly-plans' ? 'bg-[#00b894]' : 'hover:bg-[#34495e]'}`}
            onClick={() => setActivePage('weekly-plans')}
          >
            <Calendar className="w-5 h-5 mr-3" />
            Weekly Plans
          </button>
        </div>
      </div>

      {/* Main Content */}
      <div className="ml-64">
        {/* Top Bar */}
        <div className="bg-white shadow-md border-b border-gray-200 w-full fixed z-10 top-0 left-0">
          <div className="flex justify-between items-center h-16 px-6">
            <h1 className="text-2xl font-semibold text-gray-800">
              {activePage.charAt(0).toUpperCase() + activePage.slice(1)}
            </h1>

            <div className="relative">
              <button
                onClick={() => setShowProfileMenu(!showProfileMenu)}
                className="inline-flex items-center px-4 py-2 border border-gray-300 text-sm font-medium rounded-md text-gray-700 bg-white hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
              >
                <span className="mr-2">Admin</span>
                <ChevronDown className="h-4 w-4" />
              </button>

              {showProfileMenu && (
                <div className="absolute right-0 mt-2 w-48 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5">
                  <div className="py-1">
                    <button
                      onClick={handleLogout}
                      className="flex items-center w-full px-4 py-2 text-sm text-gray-700 hover:bg-gray-100"
                    >
                      <LogOut className="w-4 h-4 mr-2" />
                      Logout
                    </button>
                  </div>
                </div>
              )}
            </div>
          </div>
        </div>

        {/* Page Content */}
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-6 pt-20">
          {activePage === 'employees' && <EmployeeList />}
          {activePage === 'factories' && <FactoryList />}
          {activePage === 'production' && <ProductionList />}
          {activePage === 'products' && <ProductList />}
          {activePage === 'materials' && <MaterialList />}
          {activePage === 'suppliers' && <SupplierList />}
          {activePage === 'managers' && <ManagersList />}
          {activePage === 'weekly-plans' && <WeeklyPlansList />}
          {activePage === 'add-employee' && <AddEmployee />}
        </div>
      </div>
    </div>
  );
}
