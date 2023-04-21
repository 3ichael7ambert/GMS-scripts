// Function to set the projection matrix based on the distance
function set_projection_matrix(distance)
{
    if (distance < PEAK_DISTANCE)
    {
        // Use the peak matrix if the distance is less than 20
        projection_set(peak_matrix);
    }
    else if (distance > NORMAL_DISTANCE)
    {
        // Use the normal matrix if the distance is greater than 100
        projection_set(normal_matrix);
    }
    else
    {
        // Calculate the lerp value based on the distance
        var lerp_val = (distance - PEAK_DISTANCE) / (NORMAL_DISTANCE - PEAK_DISTANCE);
        
        // Interpolate between the peak and normal matrices
        var interp_matrix = matrix_build_interpolate(peak_matrix, normal_matrix, lerp_val);
        
        // Set the projection matrix to the interpolated matrix
        projection_set(interp_matrix);
    }
}