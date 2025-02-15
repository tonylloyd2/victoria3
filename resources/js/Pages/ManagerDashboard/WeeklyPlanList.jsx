import React, { useState, useEffect } from 'react';
import axios from 'axios';

export const WeeklyPlanList = () => {
  const [weeklyPlans, setWeeklyPlans] = useState([]);
  const [selectedPlan, setSelectedPlan] = useState(null);
  const [formData, setFormData] = useState({
    factory: '',
    week_start_date: '',
    week_end_date: '',
    status: 'draft', // Default to 'draft'
    notes: '',
    materials_needed: [],
    total_cost: '',
  });
  const [error, setError] = useState(null);
  const [successMessage, setSuccessMessage] = useState(null);

  // Fetch all weekly plans
  useEffect(() => {
    fetchWeeklyPlans();
  }, []);

  const fetchWeeklyPlans = async () => {
    try {
      const response = await axios.get('/api/weeklyplans');
      setWeeklyPlans(response.data);
    } catch (error) {
      console.error('Error fetching weekly plans:', error);
    }
  };

  // Handle delete action
  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this weekly plan?')) {
      try {
        await axios.delete(`/api/weeklyplans/${id}`);
        setWeeklyPlans(weeklyPlans.filter((plan) => plan.id !== id));
        alert('Weekly plan deleted successfully');
      } catch (error) {
        console.error('Error deleting weekly plan:', error);
        alert('Failed to delete weekly plan');
      }
    }
  };

  // Handle edit button click to pre-fill the form
  const handleEdit = (plan) => {
    setSelectedPlan(plan.id);
    setFormData({
      factory: plan.factory,
      week_start_date: plan.week_start_date,
      week_end_date: plan.week_end_date,
      status: plan.status,
      notes: plan.notes || '',
      materials_needed: plan.materials_needed || [],
      total_cost: plan.total_cost || '',
    });
  };

  // Handle form data change
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  // Handle adding a new material to the list
  const addMaterial = () => {
    setFormData((prevData) => ({
      ...prevData,
      materials_needed: [
        ...prevData.materials_needed,
        { product_id: '', quantity: '' },
      ],
    }));
  };

  // Handle removing a material from the list
  const removeMaterial = (index) => {
    const updatedMaterials = formData.materials_needed.filter((_, i) => i !== index);
    setFormData((prevData) => ({
      ...prevData,
      materials_needed: updatedMaterials,
    }));
  };

  // Handle material field changes
  const handleMaterialChange = (index, e) => {
    const { name, value } = e.target;
    const updatedMaterials = [...formData.materials_needed];
    updatedMaterials[index][name] = value;
    setFormData((prevData) => ({
      ...prevData,
      materials_needed: updatedMaterials,
    }));
  };

  // Handle updating the weekly plan
  const handleUpdate = async (e) => {
    e.preventDefault();
    try {
      const updatedPlan = await axios.put(`/api/weeklyplans/${selectedPlan}`, formData);
      setSuccessMessage('Weekly plan updated successfully!');
      setSelectedPlan(null);
      fetchWeeklyPlans(); // Refresh the list
      setFormData({
        factory: '',
        week_start_date: '',
        week_end_date: '',
        status: 'draft',
        notes: '',
        materials_needed: [],
        total_cost: '',
      });
    } catch (error) {
      console.error('Error updating weekly plan:', error);
      setError('Failed to update weekly plan');
    }
  };

  // Render weekly plans list
  return (
    <div className="p-6 mt-78 bg-white rounded-lg shadow-md">
      <h2 className="text-2xl font-bold mb-4">Weekly Plans</h2>

      {error && <div className="mb-4 text-red-500">{error}</div>}
      {successMessage && <div className="mb-4 text-green-500">{successMessage}</div>}

      <table className="min-w-full bg-white border border-gray-300">
        <thead>
          <tr>
            <th className="py-2 px-4 border-b">Factory</th>
            <th className="py-2 px-4 border-b">Week Start Date</th>
            <th className="py-2 px-4 border-b">Week End Date</th>
            <th className="py-2 px-4 border-b">Status</th>
            <th className="py-2 px-4 border-b">Actions</th>
          </tr>
        </thead>
        <tbody>
          {weeklyPlans.length > 0 ? (
            weeklyPlans.map((plan) => (
              <tr key={plan.id}>
                <td className="py-2 px-4 border-b">{plan.factory}</td>
                <td className="py-2 px-4 border-b">{new Date(plan.week_start_date).toLocaleDateString()}</td>
                <td className="py-2 px-4 border-b">{new Date(plan.week_end_date).toLocaleDateString()}</td>
                <td className="py-2 px-4 border-b">{plan.status}</td>
                <td className="py-2 px-4 border-b">
                  <button
                    onClick={() => handleEdit(plan)}
                    className="px-2 py-1 bg-blue-500 text-white rounded-md hover:bg-blue-700 transition duration-300 mr-2"
                  >
                    Edit
                  </button>
                  <button
                    onClick={() => handleDelete(plan.id)}
                    className="px-2 py-1 bg-red-500 text-white rounded-md hover:bg-red-700 transition duration-300"
                  >
                    Delete
                  </button>
                </td>
              </tr>
            ))
          ) : (
            <tr>
              <td colSpan="5" className="py-2 px-4 text-center">No weekly plans found</td>
            </tr>
          )}
        </tbody>
      </table>

      {/* Edit Form */}
      {selectedPlan && (
        <div className="mt-6 p-4 bg-gray-100 rounded-lg shadow-inner">
          <h3 className="text-xl font-semibold mb-4">Edit Weekly Plan</h3>
          <form onSubmit={handleUpdate} className="space-y-4">
            <div>
              <label htmlFor="factory" className="block text-sm font-medium text-gray-700">Factory</label>
              <input
                type="text"
                id="factory"
                name="factory"
                value={formData.factory}
                onChange={handleChange}
                required
                className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              />
            </div>

            <div>
              <label htmlFor="week_start_date" className="block text-sm font-medium text-gray-700">Week Start Date</label>
              <input
                type="date"
                id="week_start_date"
                name="week_start_date"
                value={formData.week_start_date}
                onChange={handleChange}
                required
                className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              />
            </div>

            <div>
              <label htmlFor="week_end_date" className="block text-sm font-medium text-gray-700">Week End Date</label>
              <input
                type="date"
                id="week_end_date"
                name="week_end_date"
                value={formData.week_end_date}
                onChange={handleChange}
                required
                className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              />
            </div>

            <div>
              <label htmlFor="status" className="block text-sm font-medium text-gray-700">Status</label>
              <select
                id="status"
                name="status"
                value={formData.status}
                onChange={handleChange}
                required
                className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              >
                <option value="draft">Draft</option>
                <option value="pending">Pending</option>
                <option value="approved">Approved</option>
                <option value="rejected">Rejected</option>
              </select>
            </div>

            <div>
              <label htmlFor="notes" className="block text-sm font-medium text-gray-700">Notes</label>
              <textarea
                id="notes"
                name="notes"
                value={formData.notes}
                onChange={handleChange}
                className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              />
            </div>

            <div>
              <label htmlFor="materials_needed" className="block text-sm font-medium text-gray-700">Materials Needed</label>
              {formData.materials_needed.map((material, index) => (
                <div key={index} className="flex space-x-2 mt-2">
                  <input
                    type="text"
                    name="product_id"
                    placeholder="Product ID"
                    value={material.product_id}
                    onChange={(e) => handleMaterialChange(index, e)}
                    required
                    className="p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                  />
                  <input
                    type="number"
                    name="quantity"
                    placeholder="Quantity"
                    value={material.quantity}
                    onChange={(e) => handleMaterialChange(index, e)}
                    required
                    className="p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                  />
                  <button
                    type="button"
                    onClick={() => removeMaterial(index)}
                    className="px-2 py-1 bg-red-500 text-white rounded-md hover:bg-red-700 transition duration-300"
                  >
                    Remove
                  </button>
                </div>
              ))}
              <button
                type="button"
                onClick={addMaterial}
                className="mt-2 px-2 py-1 bg-green-500 text-white rounded-md hover:bg-green-700 transition duration-300"
              >
                Add Material
              </button>
            </div>

            <div>
              <label htmlFor="total_cost" className="block text-sm font-medium text-gray-700">Total Cost</label>
              <input
                type="number"
                id="total_cost"
                name="total_cost"
                value={formData.total_cost}
                onChange={handleChange}
                required
                className="mt-1 p-2 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              />
            </div>

            <div className="flex space-x-2 mt-4">
              <button
                type="submit"
                className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-700 transition duration-300"
              >
                Update Weekly Plan
              </button>
              <button
                type="button"
                onClick={() => setSelectedPlan(null)}
                className="px-4 py-2 bg-gray-500 text-white rounded-md hover:bg-gray-700 transition duration-300"
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
      )}
    </div>
  );
};

