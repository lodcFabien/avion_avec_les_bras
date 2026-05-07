using UnityEngine;
using UnityEngine.UI;

public class CompassController : MonoBehaviour
{
    [SerializeField] private Transform _camera;
    [SerializeField] private CompassView _view;


    private void Update()
    {
        float offset = -_camera.eulerAngles.y;
        if (offset > 180f) offset -= 360f;

        offset = offset.Remap(-180, 180, -.5f, .5f);

        _view.UpdateCompass(offset);
    }
}
