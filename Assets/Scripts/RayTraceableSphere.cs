using UnityEngine;

public class RayTraceableSphere : MonoBehaviour
{
    // Start is called before the first frame update
    public Color albedo, specular, emission;

    public Sphere ToSphere() {
        return new Sphere() {
            center = transform.position,
            radius = transform.localScale.x / 2f,
            albedo = (Vector3)(Vector4)albedo,
            specular = (Vector3)(Vector4)specular,
            emission = (Vector3)(Vector4)emission
        };
    }
}
