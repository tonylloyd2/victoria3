import React from 'react';

const ProductCard = ({ product, onDelete, onEdit }) => {
    return (
        <div className="max-w-xs bg-white border rounded-lg shadow-md overflow-hidden">
            <img
                src={`/storage/${product.image_path.split('public/')[1]}`}
                alt={product.name}
                className="w-full h-48 object-cover"
            />
            <div className="p-4">
                <h3 className="text-lg font-semibold text-gray-800">{product.name}</h3>
                <p className="text-sm text-gray-500">{product.price_per_unit} USD</p>
                <p className="mt-2 text-sm text-gray-500">
                    {product.availability_in_stock ? 'In Stock' : 'Out of Stock'}
                </p>
                <div className="mt-4 flex justify-between">
                    <button
                        onClick={() => onEdit(product)}
                        className="px-4 py-2 bg-blue-500 text-white rounded-md hover:bg-blue-600"
                    >
                        Edit
                    </button>
                    <button
                        onClick={() => onDelete(product.id)}
                        className="px-4 py-2 bg-red-500 text-white rounded-md hover:bg-red-600"
                    >
                        Delete
                    </button>
                </div>
            </div>
        </div>
    );
};

export default ProductCard;
