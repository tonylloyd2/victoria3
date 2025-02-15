import React, { useState, useEffect } from 'react';
import axios from 'axios';
import EditEmployee from './EditEmployee';
import { AddEmployee } from './AddEmployee';

export const EmployeeList = () => {
  const [employees, setEmployees] = useState([]);
  const [selectedEmployee, setSelectedEmployee] = useState(null);
  const [showAddEmployee, setShowAddEmployee] = useState(false); // Popup state

  useEffect(() => {
    axios.get('/api/employees')
      .then(response => {
        setEmployees(response.data);
      })
      .catch(error => {
        console.error('There was an error fetching the employees!', error);
      });
  }, []);

  const handleEdit = (employee) => {
    setSelectedEmployee(employee); // Open edit form
  };

  const handleUpdate = () => {
    axios.get('/api/employees')
      .then(response => {
        setEmployees(response.data);
      })
      .catch(error => {
        console.error('There was an error fetching the updated employees!', error);
      });

    setSelectedEmployee(null); // Close edit form after update
  };

  const handleDelete = async (id) => {
    try {
      await axios.delete(`/api/employees/${id}`);
      setEmployees(employees.filter(employee => employee.id !== id));
    } catch (error) {
      console.error('Error deleting employee:', error);
    }
  };

  return (
    <div className="p-6">
      <h2 className="text-2xl font-semibold mb-4">Employee List</h2>

      {/* Add Employee Button */}
      <button
        onClick={() => setShowAddEmployee(true)}
        className="mb-4 px-4 py-2 bg-green-500 text-white rounded hover:bg-green-700 transition duration-300"
      >
        Add Employee
      </button>

      {/* Add Employee Popup */}
      {showAddEmployee && (
        <div className="fixed inset-0 flex items-center justify-center bg-gray-900 bg-opacity-50">
          <div className="bg-white p-6 rounded-lg shadow-lg w-96">
            <h3 className="text-lg font-semibold mb-4">Add Employee</h3>
            <AddEmployee />
            <button
              onClick={() => setShowAddEmployee(false)}
              className="mt-4 px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-700 transition duration-300"
            >
              Close
            </button>
          </div>
        </div>
      )}

      {selectedEmployee ? (
        <div>
          <button
            onClick={() => setSelectedEmployee(null)}
            className="mb-4 px-3 py-1 text-white bg-gray-500 rounded hover:bg-gray-700 transition duration-300"
          >
            Back to Employee List
          </button>
          <EditEmployee employee={selectedEmployee} onUpdate={handleUpdate} onDelete={handleDelete} />
        </div>
      ) : (
        <ul className="bg-white shadow-md rounded-lg overflow-hidden">
          {employees.map(employee => (
            <li key={employee.id} className="p-4 border-b flex justify-between items-center hover:bg-gray-100 transition duration-300">
              <div>
                <span className="font-medium">{employee.name}</span> - {employee.email} - {employee.factory} - 
                <span className={`ml-1 ${employee.is_active ? 'text-green-500' : 'text-red-500'}`}>
                  {employee.is_active ? 'Active' : 'Inactive'}
                </span> - ${employee.daily_wage}
              </div>
              <div>
                <button
                  onClick={() => handleEdit(employee)}
                  className="px-3 py-1 text-white bg-blue-500 rounded hover:bg-blue-700 transition duration-300 mr-2"
                >
                  Edit
                </button>
                <button
                  onClick={() => handleDelete(employee.id)}
                  className="px-3 py-1 text-white bg-red-500 rounded hover:bg-red-700 transition duration-300"
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