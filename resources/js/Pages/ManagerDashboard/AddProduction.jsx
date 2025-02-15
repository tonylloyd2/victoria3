import React, { useState, useEffect } from 'react';
import axios from 'axios';

const AddProductionCost = () => {
    const [materials, setMaterials] = useState([]); // Store materials data
    const [factories, setFactories] = useState([]); // Store factory data
    const [selectedMaterials, setSelectedMaterials] = useState([]); // Store selected materials and their quantities
    const [materialTotalCost, setMaterialTotalCost] = useState(0); // Store total cost

    // Form states
    const [productId, setProductId] = useState('');
    const [productName, setProductName] = useState('');
    const [laborCost, setLaborCost] = useState('');
    const [energyCost, setEnergyCost] = useState('');
    const [maintenanceCost, setMaintenanceCost] = useState('');
    const [overheadCost, setOverheadCost] = useState('');
    const [adminCost, setAdminCost] = useState('');
    const [facilityCost, setFacilityCost] = useState('');
    const [additionalCost, setAdditionalCost] = useState('');
    const [revenue, setRevenue] = useState('');
    const [itemsProducedPerDay, setItemsProducedPerDay] = useState('');
    const [productionDate, setProductionDate] = useState('');
    const [factory, setFactory] = useState(''); // Factory field

    useEffect(() => {
        fetchMaterials();
        fetchFactories();  // Fetch factories when component mounts
    }, []);

    // Fetch materials from the backend
    const fetchMaterials = async () => {
        try {
            const response = await axios.get('/admin/materials');
            setMaterials(response.data); // Set materials data to state
        } catch (error) {
            console.error('Error fetching materials:', error);
        }
    };

    // Fetch factories from the backend
    const fetchFactories = async () => {
        try {
            const response = await axios.get('/api/factories');
            setFactories(response.data); // Set factories data to state
        } catch (error) {
            console.error('Error fetching factories:', error);
        }
    };

    // Handle quantity input change for materials
    const handleMaterialQuantityChange = (e, materialId) => {
        const quantityUsed = parseFloat(e.target.value) || 0; // Ensure the input is a number

        // Find the material and check if the entered quantity is valid
        const material = materials.find((m) => m.id === materialId);
        if (material && quantityUsed > material.material_quantity) {
            alert(`Quantity used cannot be more than the available quantity of ${material.material_quantity}`);
        } else {
            const updatedMaterials = selectedMaterials.map((material) => {
                if (material.id === materialId) {
                    material.quantity_used = quantityUsed;
                    material.cost = quantityUsed * parseFloat(material.material_price_perUnit || 0); // Calculate the cost
                }
                return material;
            });
            setSelectedMaterials(updatedMaterials);
            updateTotalCost(updatedMaterials);
        }
    };

    // Add material to selected materials
    const handleMaterialSelect = (materialId) => {
        const material = materials.find((m) => m.id === materialId);
        if (material && !selectedMaterials.some((m) => m.id === materialId)) {
            setSelectedMaterials([
                ...selectedMaterials,
                { ...material, quantity_used: 0, cost: 0 }, // Initialize quantity and cost to 0
            ]);
        }
    };

    // Update the total cost based on selected materials
    const updateTotalCost = (materialsList) => {
        const totalCost = materialsList.reduce((acc, material) => acc + (material.cost || 0), 0);
        setMaterialTotalCost(totalCost);
    };

    // Handle the form submission
    const handleSubmit = async (e) => {
        e.preventDefault();

        try {
            // Send production details to the backend
            const productionResponse = await axios.post('/api/productions', {
                product_id: productId,
                product_name: productName,
                material_total_cost: materialTotalCost,
                labor_cost: laborCost,
                energy_cost: energyCost,
                maintenance_cost: maintenanceCost,
                overhead_cost: overheadCost,
                admin_cost: adminCost,
                facility_cost: facilityCost,
                additional_cost: additionalCost,
                revenue: revenue,
                items_produced_perday: itemsProducedPerDay,
                production_date: productionDate,
                factory: factory, // Sending factory field
                materials_used: selectedMaterials.map((material) => ({
                    id: material.id,
                    quantity_used: material.quantity_used, // Send the quantity used field
                    cost: material.cost, // Send the cost field as well
                })),
            });

            console.log('Production cost added:', productionResponse.data);
            alert('Production added successfully');

            // Update material quantities in the backend
            for (const material of selectedMaterials) {
                const updatedQuantity = material.material_quantity - material.quantity_used;
                await axios.put(`/admin/materials/update-quantities/${material.id}`, {
                    quantity_used: material.quantity_used,
                });
            }

            console.log('Material quantities updated');
        } catch (error) {
            console.error('Error adding production cost:', error);
            alert('Error adding production');
        }
    };

    return (
        <div className="p-2">
            <h2 className="text-xl font-semibold mb-4">Add Production Cost</h2>
            <form onSubmit={handleSubmit} className="grid grid-cols-5 gap-2">
                <div>
                    <label className="block mb-2">Product ID:</label>
                    <input
                        type="number"
                        value={productId}
                        onChange={(e) => setProductId(e.target.value)}
                        required
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Product Name:</label>
                    <input
                        type="text"
                        value={productName}
                        onChange={(e) => setProductName(e.target.value)}
                        required
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Factory:</label>
                    <select
                        value={factory}
                        onChange={(e) => setFactory(e.target.value)}
                        required
                        className="w-full p-1 border border-gray-300 rounded"
                    >
                        <option value="">Select Factory</option>
                        {factories.map((factory) => (
                            <option key={factory.id} value={factory.id}>
                                {factory.name} - {factory.location}
                            </option>
                        ))}
                    </select>
                </div>
                <div>
                    <label className="block mb-2">Production Date:</label>
                    <input
                        type="date"
                        value={productionDate}
                        onChange={(e) => setProductionDate(e.target.value)}
                        required
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Labor Cost:</label>
                    <input
                        type="number"
                        value={laborCost}
                        onChange={(e) => setLaborCost(e.target.value)}
                        required
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Energy Cost:</label>
                    <input
                        type="number"
                        value={energyCost}
                        onChange={(e) => setEnergyCost(e.target.value)}
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Maintenance Cost:</label>
                    <input
                        type="number"
                        value={maintenanceCost}
                        onChange={(e) => setMaintenanceCost(e.target.value)}
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Overhead Cost:</label>
                    <input
                        type="number"
                        value={overheadCost}
                        onChange={(e) => setOverheadCost(e.target.value)}
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Admin Cost:</label>
                    <input
                        type="number"
                        value={adminCost}
                        onChange={(e) => setAdminCost(e.target.value)}
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Facility Cost:</label>
                    <input
                        type="number"
                        value={facilityCost}
                        onChange={(e) => setFacilityCost(e.target.value)}
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Additional Cost:</label>
                    <input
                        type="number"
                        value={additionalCost}
                        onChange={(e) => setAdditionalCost(e.target.value)}
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Revenue:</label>
                    <input
                        type="number"
                        value={revenue}
                        onChange={(e) => setRevenue(e.target.value)}
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div>
                    <label className="block mb-2">Items Produced/Day:</label>
                    <input
                        type="number"
                        value={itemsProducedPerDay}
                        onChange={(e) => setItemsProducedPerDay(e.target.value)}
                        required
                        className="w-full p-1 border border-gray-300 rounded"
                    />
                </div>
                <div className="col-span-5">
                    <label className="block mb-1">Total Material Cost: {materialTotalCost}</label>
                </div>
                <div className="col-span-5">
                    <h3 className="text-xl font-semibold mb-2">Materials List</h3>
                    <table className="w-full border-collapse border border-gray-300">
                        <thead>
                            <tr>
                                <th className="border p-2">Material Name</th>
                                <th className="border p-2">Price per Unit</th>
                                <th className="border p-2">Quantity Available</th>
                                <th className="border p-2">Quantity Used</th>
                                <th className="border p-2">Cost</th>
                                <th className="border p-2">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            {materials.map((material) => (
                                <tr key={material.id}>
                                    <td className="border p-2">{material.material_name}</td>
                                    <td className="border p-2">{material.material_price_perUnit}</td>
                                    <td className="border p-2">{material.material_quantity}</td>
                                    <td className="border p-2">
                                        <input
                                            type="number"
                                            value={selectedMaterials.find((m) => m.id === material.id)?.quantity_used || 0}
                                            onChange={(e) => handleMaterialQuantityChange(e, material.id)}
                                            placeholder="Quantity Used"
                                            className="w-full p-1 border border-gray-300 rounded"
                                        />
                                    </td>
                                    <td className="border p-2">
                                        {selectedMaterials.find((m) => m.id === material.id)?.cost || 0}
                                    </td>
                                    <td className="border p-2">
                                        <button
                                            type="button"
                                            onClick={() => handleMaterialSelect(material.id)}
                                            className="px-2 py-1 bg-green-500 text-white rounded hover:bg-green-700 transition duration-300"
                                        >
                                            Add
                                        </button>
                                    </td>
                                </tr>
                            ))}
                        </tbody>
                    </table>
                </div>
                <div className="col-span-5 mt-0">
                    <button
                        type="submit"
                        className=" px-2 py-0 bg-blue-500 text-white rounded hover:bg-blue-700 transition duration-300"
                    >
                        Add Production
                    </button>
                </div>
            </form>
        </div>
    );
};

export default AddProductionCost;