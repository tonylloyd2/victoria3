<?php

namespace App\Http\Controllers;

use App\Models\Materials;
use Illuminate\Http\Request;

class MaterialsController extends Controller
{
    // Add a new material to the stock
    public function add(Request $request)
    {
        $validated = $request->validate([
            'material_name' => 'required|string',
            'material_quantity' => 'required|integer',
            'supplier_name' => 'required|string',
            'material_price_perUnit' => 'required|numeric',
            'stock_value' => 'required|integer',
            'measurement_unit' => 'required|string',
        ]);

        try {
            $totalStockValue = $validated['stock_value'] * $validated['material_price_perUnit'];
            $validated['total_stock_value'] = $totalStockValue;

            $material = Materials::create($validated);

            return response()->json(['message' => 'Material added successfully', 'material' => $material], 201);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error adding material', 'error' => $e->getMessage()], 500);
        }
    }

    // Fetch all materials in the stock
    public function fetch()
    {
        try {
            $materials = Materials::all();
            return response()->json($materials, 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error fetching materials', 'error' => $e->getMessage()], 500);
        }
    }

    // Update material quantity and total stock value
    public function updateQuantities(Request $request, $id)
    {
        $validated = $request->validate([
            'quantity_used' => 'required|integer', // Amount of material used
        ]);

        try {
            // Find the material to be updated
            $material = Materials::find($id);

            if (!$material) {
                return response()->json(['message' => 'Material not found'], 404);
            }

            // Calculate the new material quantity after using the material
            $newQuantity = $material->material_quantity - $validated['quantity_used'];

            if ($newQuantity < 0) {
                return response()->json(['message' => 'Insufficient stock'], 400);
            }

            // Update material quantity
            $material->material_quantity = $newQuantity;

            // Recalculate total stock value based on the updated quantity and price per unit
            $newTotalStockValue = $newQuantity * $material->material_price_perUnit;
            $material->total_stock_value = $newTotalStockValue;

            // Save the updated material record
            $material->save();

            return response()->json(['message' => 'Material quantity updated successfully', 'material' => $material], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error updating material quantity', 'error' => $e->getMessage()], 500);
        }
    }

    // Delete a specific material from the stock
    public function delete($id)
    {
        try {
            $material = Materials::find($id);

            if (!$material) {
                return response()->json(['message' => 'Material not found'], 404);
            }

            $material->delete();

            return response()->json(['message' => 'Material deleted successfully'], 200);
        } catch (\Exception $e) {
            return response()->json(['message' => 'Error deleting material', 'error' => $e->getMessage()], 500);
        }
    }
}
