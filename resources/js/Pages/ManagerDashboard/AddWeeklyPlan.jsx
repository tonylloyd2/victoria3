import React, { useState, useEffect } from 'react';
import axios from 'axios';

export const AddWeeklyPlan = () => {
  const [formData, setFormData] = useState({
    factory: '',
    week_start_date: '',
    week_end_date: '',
    status: 'draft', // Default to 'draft'
    notes: '',
    materials_needed: [],
    total_cost: '',
  });

  const [materials, setMaterials] = useState([]); // Store materials data
  const [error, setError] = useState(null);
  const [successMessage, setSuccessMessage] = useState(null);

  useEffect(() => {
    fetchMaterials();
  }, []);

  // Fetch materials from the backend
  const fetchMaterials = async () => {
    try {
      const response = await axios.get('/admin/materials');
      setMaterials(response.data);
    } catch (error) {
      console.error('Error fetching materials:', error);
    }
  };

  // Handle input changes
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData((prevData) => ({
      ...prevData,
      [name]: value,
    }));
  };

  // Handle adding new product to materials_needed (if needed)
  const handleMaterialChange = (index, e) => {
    const { name, value } = e.target;
    const updatedMaterials = [...formData.materials_needed];
    updatedMaterials[index][name] = value;
    setFormData((prevData) => ({
      ...prevData,
      materials_needed: updatedMaterials,
    }));
  };

  const addMaterial = () => {
    setFormData((prevData) => ({
      ...prevData,
      materials_needed: [
        ...prevData.materials_needed,
        { material_id: '', quantity: '' },
      ],
    }));
  };

  const removeMaterial = (index) => {
    const updatedMaterials = formData.materials_needed.filter((_, i) => i !== index);
    setFormData((prevData) => ({
      ...prevData,
      materials_needed: updatedMaterials,
    }));
  };

  // Handle form submission
  const handleSubmit = async (e) => {
    e.preventDefault();

    // Check for empty fields
    if (!formData.factory || !formData.week_start_date || !formData.week_end_date || !formData.total_cost) {
      setError('Please fill in all required fields.');
      return;
    }

    try {
      // Clear any previous errors or success messages
      setError(null);
      setSuccessMessage(null);

      // Send POST request to create weekly plan
      const response = await axios.post('/api/weeklyplans', formData);
      
      setSuccessMessage('Weekly Plan created successfully!');
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
      // Handle error response from API
      if (error.response) {
        setError(error.response.data.message || 'An error occurred');
      } else {
        setError('An error occurred while submitting the form.');
      }
    }
  };

  return (
    <div className="p-4 bg-white rounded-lg shadow-md">
      <h2 className="text-xl font-bold mb-3">Add Weekly Plan</h2>
      
      {error && <div className="mb-3 text-red-500">{error}</div>}
      {successMessage && <div className="mb-3 text-green-500">{successMessage}</div>}
      
      <form onSubmit={handleSubmit} className="grid grid-cols-5 gap-3">
        <div className="col-span-5 sm:col-span-2">
          <label htmlFor="factory" className="block text-sm font-medium text-gray-700">Factory</label>
          <input
            type="text"
            id="factory"
            name="factory"
            value={formData.factory}
            onChange={handleChange}
            required
            className="mt-1 p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          />
        </div>

        <div className="col-span-5 sm:col-span-2">
          <label htmlFor="week_start_date" className="block text-sm font-medium text-gray-700">Week Start Date</label>
          <input
            type="date"
            id="week_start_date"
            name="week_start_date"
            value={formData.week_start_date}
            onChange={handleChange}
            required
            className="mt-1 p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          />
        </div>

        <div className="col-span-5 sm:col-span-2">
          <label htmlFor="week_end_date" className="block text-sm font-medium text-gray-700">Week End Date</label>
          <input
            type="date"
            id="week_end_date"
            name="week_end_date"
            value={formData.week_end_date}
            onChange={handleChange}
            required
            className="mt-1 p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          />
        </div>

        <div className="col-span-5 sm:col-span-2">
          <label htmlFor="status" className="block text-sm font-medium text-gray-700">Status</label>
          <select
            id="status"
            name="status"
            value={formData.status}
            onChange={handleChange}
            required
            className="mt-1 p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          >
            <option value="draft">Draft</option>
            <option value="pending">Pending</option>
          </select>
        </div>

        <div className="col-span-5">
          <label htmlFor="notes" className="block text-sm font-medium text-gray-700">Notes</label>
          <textarea
            id="notes"
            name="notes"
            value={formData.notes}
            onChange={handleChange}
            className="mt-1 p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          />
        </div>

        <div className="col-span-5">
          <label className="block text-sm font-medium text-gray-700">Materials Needed</label>
          {formData.materials_needed.map((material, index) => (
            <div key={index} className="flex space-x-2 mt-2">
              <select
                name="material_id"
                value={material.material_id}
                onChange={(e) => handleMaterialChange(index, e)}
                required
                className="p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
              >
                <option value="">Select Material</option>
                {materials.map((material) => (
                  <option key={material.id} value={material.id}>
                    {material.material_name}
                  </option>
                ))}
              </select>
              <input
                type="number"
                name="quantity"
                placeholder="Quantity"
                value={material.quantity}
                onChange={(e) => handleMaterialChange(index, e)}
                required
                className="p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
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

        <div className="col-span-5">
          <label htmlFor="total_cost" className="block text-sm font-medium text-gray-700">Total Cost</label>
          <input
            type="number"
            id="total_cost"
            name="total_cost"
            value={formData.total_cost}
            onChange={handleChange}
            required
            className="mt-1 p-1 block w-full border border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
          />
        </div>

        <div className="col-span-5">
          <button
            type="submit"
            className="mt-4 px-3 py-1 bg-blue-500 text-white rounded-md hover:bg-blue-700 transition duration-300"
          >
            Create Weekly Plan
          </button>
        </div>
      </form>
    </div>
  );
};
