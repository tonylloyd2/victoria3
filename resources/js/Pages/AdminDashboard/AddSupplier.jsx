import React, { useState } from 'react';
import axios from 'axios';

export const AddSupplier = () => {
    const [formData, setFormData] = useState({
        name: '',
        email: '',
        mobileNumber: '',
        materialsSupplied: [{ material: '', price_per_unit: '' }] // Initialize with one material field
    });
    const [loading, setLoading] = useState(false);
    const [error, setError] = useState(null);

    // Handle input change for text fields
    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value
        });
    };

    // Handle input change for materials
    const handleMaterialChange = (index, e) => {
        const { name, value } = e.target;
        const updatedMaterials = [...formData.materialsSupplied];
        updatedMaterials[index][name] = value;
        setFormData({
            ...formData,
            materialsSupplied: updatedMaterials
        });
    };

    // Add new material input fields
    const addMaterialField = () => {
        setFormData({
            ...formData,
            materialsSupplied: [...formData.materialsSupplied, { material: '', price_per_unit: '' }]
        });
    };

    // Remove material input field
    const removeMaterialField = (index) => {
        const updatedMaterials = [...formData.materialsSupplied];
        updatedMaterials.splice(index, 1);
        setFormData({
            ...formData,
            materialsSupplied: updatedMaterials
        });
    };

    // Validate that material and price are entered correctly
    const validateMaterialFormat = (material) => {
        const materialPricePattern = /^[a-zA-Z0-9\s]+,\d+$/; // Format: "material_name, price"
        return materialPricePattern.test(material);
    };

    // Handle form submission
    const handleSubmit = async (e) => {
        e.preventDefault();

        // Validate materials format
        const invalidMaterials = formData.materialsSupplied.filter(
            (material) => !validateMaterialFormat(`${material.material},${material.price_per_unit}`)
        );
        if (invalidMaterials.length > 0) {
            setError('Each material must be entered with a price per unit, separated by a comma (e.g., "material, 60")');
            return;
        }

        // Prepare the supplier data for API submission
        const supplierData = {
            name: formData.name,
            email: formData.email,
            mobile_number: formData.mobileNumber,
            materials_supplied: formData.materialsSupplied.filter(
                (material) => material.material !== '' && material.price_per_unit !== ''
            ) // Filter out incomplete materials
        };

        setLoading(true);

        try {
            // Make the POST request
            const response = await axios.post('/admin/suppliers', supplierData, {
                headers: {
                    'Content-Type': 'application/json',
                },
            });

            // Clear form data and show success alert
            setFormData({
                name: '',
                email: '',
                mobileNumber: '',
                materialsSupplied: [{ material: '', price_per_unit: '' }]
            });
            alert('Supplier added successfully!');
        } catch (err) {
            setError('There was an error adding the supplier.');
            console.error(err);
        } finally {
            setLoading(false);
        }
    };

    return (
        <div>
            <h2>Add New Supplier</h2>

            {error && <p style={{ color: 'red' }}>{error}</p>} {/* Show error message */}

            <form onSubmit={handleSubmit}>
                <div>
                    <label>Supplier Name:</label>
                    <input
                        type="text"
                        name="name"
                        value={formData.name}
                        onChange={handleInputChange}
                        required
                    />
                </div>

                <div>
                    <label>Email:</label>
                    <input
                        type="email"
                        name="email"
                        value={formData.email}
                        onChange={handleInputChange}
                        required
                    />
                </div>

                <div>
                    <label>Mobile Number:</label>
                    <input
                        type="text"
                        name="mobileNumber"
                        value={formData.mobileNumber}
                        onChange={handleInputChange}
                        required
                    />
                </div>

                <div>
                    <label>Materials Supplied:</label>
                    {formData.materialsSupplied.map((material, index) => (
                        <div key={index}>
                            <input
                                type="text"
                                name="material"
                                value={material.material}
                                onChange={(e) => handleMaterialChange(index, e)}
                                placeholder="Material Name"
                                required
                            />
                            <input
                                type="number"
                                name="price_per_unit"
                                value={material.price_per_unit}
                                onChange={(e) => handleMaterialChange(index, e)}
                                placeholder="Price per Unit"
                                required
                            />
                            <button type="button" onClick={() => removeMaterialField(index)}>Remove</button>
                        </div>
                    ))}
                    <button type="button" onClick={addMaterialField}>Add Material</button>
                </div>

                <button type="submit" disabled={loading}>
                    {loading ? 'Adding Supplier...' : 'Add Supplier'}
                </button>
            </form>
        </div>
    );
};
