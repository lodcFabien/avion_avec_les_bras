using UnityEngine;

public class FanRotatorController : MonoBehaviour
{
    [SerializeField] private float _rotationRate = 1.0f;

    // Update is called once per frame
    void Update()
    {
        this.transform.Rotate(new Vector3(0,0,_rotationRate * Time.deltaTime));
    }
}
