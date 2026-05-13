using UnityEngine;
using static Unity.Burst.Intrinsics.X86.Avx;

public class AltitudeIndicatorController : MonoBehaviour
{
    [SerializeField] private GameManager _gameManager;

    [SerializeField] ValueSlideController altitudeDisplay;

    [SerializeField] ValueSlideController speedDisplay;

    [Header("Roll")]

    [SerializeField] private RectTransform _artificialHorizon;

    [SerializeField] private RectTransform _rollDisplay;

    [Header("PitchMeter")]

    [SerializeField] private float _minValue;

    [SerializeField] private float _minPosition;

    [SerializeField] private float _maxValue;

    [SerializeField] private float _maxPosition;

    [Header("Decorations")]

    [SerializeField] Transform grandCircle;
    [Range(0, 1)] [SerializeField] float grandCircleRatio;

    [SerializeField] Transform smallCircle;
    [Range(0, 1)] [SerializeField] float smallCircleRatio;

    // Update is called once per frame
    void Update()
    {
        //Altitude
        float altitude = _gameManager.ActiveAirplane.transform.position.y;
        altitudeDisplay.SetValue(altitude * 2);

        //Speed
        // speedDisplay.SetValue(Control.currentSpeed * 2);//speedDisplay.SetValue(Settings.Instance.currentObj.currentSpeed * 2);

        //Rotations
        float roll = _gameManager.ActiveAirplane.transform.eulerAngles.z;
        float pitch = _gameManager.ActiveAirplane.transform.eulerAngles.x;

        roll = AngleAround(roll, 0);
        pitch = AngleAround(pitch, 0);

        //Security check fpr the arduino card (motor going from 0 to 180)
        roll = Mathf.Clamp(roll, -90, 90);
        pitch = Mathf.Clamp(pitch, -90, 90);


        //Display the roll value on the artificial horizon
        _artificialHorizon.localRotation = Quaternion.Euler(Vector3.forward * -roll);
        _rollDisplay.localRotation = _artificialHorizon.localRotation;

        //Display the picth value
        //Get the ratio of the y position of the bar in it's box
        float positionRatio = (pitch - _minValue) / (_maxValue - _minValue);
        Debug.Log(positionRatio);

        //Set the position in y
        _artificialHorizon.localPosition = Vector3.down * Mathf.Lerp(_minPosition, _maxPosition, positionRatio);

        //Rotate the decorations
        grandCircle.localRotation = Quaternion.Euler(Vector3.forward * roll * grandCircleRatio);
        smallCircle.localRotation = Quaternion.Euler(Vector3.forward * pitch * smallCircleRatio);
    }

    float AngleAround(float angle, float center)
    {
        if (angle < center - 180)
        {
            angle += 360;
        }
        else if (angle > center + 180)
        {
            angle -= 360;
        }

        return angle;
    }
}
