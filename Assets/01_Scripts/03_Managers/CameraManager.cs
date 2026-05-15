using UnityEngine;

public class CameraManager : MonoBehaviour
{
    [SerializeField] private GameObject[] _cameras;

    private void Start()
    {
        if (_cameras.Length > 0)
        {
            ActivateCamera(1);
        }
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.F1)) ActivateCamera(0);
        if (Input.GetKeyDown(KeyCode.F2)) ActivateCamera(1);
        if (Input.GetKeyDown(KeyCode.F3)) ActivateCamera(2);
    }

    private void ActivateCamera(int targetIndex)
    {
        for (int i = 0; i < _cameras.Length; i++)
        {
            if (_cameras[i] != null)
            {
                _cameras[i].SetActive(i == targetIndex);
            }
        }
    }
}