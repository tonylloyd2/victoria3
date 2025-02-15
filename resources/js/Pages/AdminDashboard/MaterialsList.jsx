import React, { useState, useEffect } from 'react';
import axios from 'axios';
import AddMaterial from './AddMaterial';

const MaterialList = () => {
  const [materials, setMaterials] = useState([]);
  const [showAddMaterial, setShowAddMaterial] = useState(false); // Popup state
  const [editMaterial, setEditMaterial] = useState(null); // State to hold material for editing

  useEffect(() => {
    fetchMaterials();
  }, []);

  const fetchMaterials = async () => {
    try {
      const response = await axios.get('/admin/materials');
      setMaterials(response.data);
    } catch (error) {
      console.error('Error fetching materials:', error);
    }
  };

  const handleDelete = async (id) => {
    try {
      await axios.delete(`/admin/materials/${id}`);
      fetchMaterials(); // Refresh the list after deletion
      alert('Material deleted successfully');
    } catch (error) {
      console.error('Error deleting material:', error);
      alert('Error deleting material');
    }
  };

  const handleEdit = (material) => {
    setEditMaterial(material);
    setShowAddMaterial(true); // Show the modal for editing
  };

  return (
    <div>
      <h2 className="text-xl font-semibold">Material List</h2>

      {/* Add Material Button */}
      <button
        onClick={() => setShowAddMaterial(true)}
        className="mb-4 px-4 py-2 bg-green-500 text-white rounded"
      >
        Add Material
      </button>

      {/* Add or Edit Material Popup */}
      {showAddMaterial && (
        <div className="fixed inset-0 flex items-center justify-center bg-gray-900 bg-opacity-50">
          <div className="bg-white p-6 rounded-lg shadow-lg w-96">
            <h3 className="text-lg font-semibold mb-4">{editMaterial ? 'Edit Material' : 'Add Material'}</h3>
            <AddMaterial
              setIsAdding={setShowAddMaterial}
              fetchMaterials={fetchMaterials}
              material={editMaterial} // Pass the material to edit if it exists
            />
            <button
              onClick={() => setShowAddMaterial(false)}
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
            <th className="border border-gray-300 px-4 py-2">Material Name</th>
            <th className="border border-gray-300 px-4 py-2">Material Quantity</th>
            <th className="border border-gray-300 px-4 py-2">Supplier Name</th>
            <th className="border border-gray-300 px-4 py-2">Price per Unit</th>
            <th className="border border-gray-300 px-4 py-2">Stock Value</th>
            <th className="border border-gray-300 px-4 py-2">Measurement Unit</th>
            {/* Add the Total Stock Value Column */}
            <th className="border border-gray-300 px-4 py-2">Total Stock Value</th>
            <th className="border border-gray-300 px-4 py-2">Actions</th>
          </tr>
        </thead>
        <tbody>
          {materials.map((material) => (
            <tr key={material.id} className="border border-gray-300">
              <td className="border border-gray-300 px-4 py-2">{material.material_name}</td>
              <td className="border border-gray-300 px-4 py-2">{material.material_quantity}</td>
              <td className="border border-gray-300 px-4 py-2">{material.supplier_name}</td>
              <td className="border border-gray-300 px-4 py-2">{material.material_price_perUnit}</td>
              <td className="border border-gray-300 px-4 py-2">{material.stock_value}</td>
              <td className="border border-gray-300 px-4 py-2">{material.measurement_unit}</td>
              {/* Add the Total Stock Value */}
              <td className="border border-gray-300 px-4 py-2">{material.total_stock_value}</td>
              <td className="border border-gray-300 px-4 py-2">
                <button
                  onClick={() => handleEdit(material)}
                  className="px-4 py-2 bg-blue-500 text-white rounded"
                >
                  Edit
                </button>
                <button
                  onClick={() => handleDelete(material.id)}
                  className="ml-2 px-4 py-2 bg-red-500 text-white rounded"
                >
                  Delete
                </button>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default MaterialList;
