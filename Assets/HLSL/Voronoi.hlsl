#ifndef VORONOI_INCLUDED
#define VORONOI_INCLUDED
//reworked from: https://docs.unity3d.com/Packages/com.unity.shadergraph@17.5/manual/Voronoi-Node.html

float2 unity_voronoi_noise_randomVector (float2 UV, float offset) 
{
    float2x2 m = float2x2(15.27, 47.63, 99.41, 89.98);
    UV = frac(sin(mul(UV, m)) * 46839.32);
    return float2(sin(UV.y*offset)*0.5+0.5, cos(UV.x*offset)*0.5+0.5);
}

void Unity_Voronoi_float(float2 UV, float AngleOffset, float CellDensity, out float Out, out float Cells)
{
    float2 g = floor(UV * CellDensity);
    float2 f = frac(UV * CellDensity);

    float minDist = 8.0;
    float2 cell = 0;

    for (int y = -1; y <= 1; y++)
    {
        for (int x = -1; x <= 1; x++)
        {
            float2 lattice = float2(x, y);
            float2 offset = unity_voronoi_noise_randomVector(g + lattice, AngleOffset);

            float2 diff = lattice + offset - f;
            float dist = dot(diff, diff);

            if (dist < minDist)
            {
                minDist = dist;
                cell = g + lattice;
            }
        }
    }

    Out = sqrt(minDist);
    Cells = frac(sin(dot(cell, float2(127.1, 311.7))) * 43758.5453);
}

#endif // VORONOI_INCLUDED
