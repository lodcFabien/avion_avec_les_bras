using UnityEngine;
using Mediapipe.Tasks.Vision.PoseLandmarker;
using System.Collections.Generic;

public class InputController : MonoBehaviour
{
    [SerializeField] private float sensitivityHandsDown = 100;
    [SerializeField] private float sensitivityHandsUp = 100;

    [Header("Debug Keyboard")]
    [SerializeField] private bool useKeyboard = false;
    [SerializeField] private float maxKeyboardRoll = 45;
    [SerializeField] private float maxKeyboardPitch = 30;

    private float _targetRollAngle = 0;
    private float _targetPitchAngle = 0;

    public float TargetRollAngle => _targetRollAngle;
    public float TargetPitchAngle => _targetPitchAngle;

    public void UpdateRotation(PoseLandmarkerResult result)
    {
        if (useKeyboard) return;

        if (result.poseLandmarks != null && result.poseLandmarks.Count > 0)
        {
            List<Mediapipe.Tasks.Components.Containers.NormalizedLandmark> landmarks = result.poseLandmarks[0].landmarks;

            Vector2 leftShoulder = new Vector2(landmarks[11].x, landmarks[11].y);
            Vector2 rightShoulder = new Vector2(landmarks[12].x, landmarks[12].y);
            Vector2 leftHand = new Vector2(landmarks[15].x, landmarks[15].y);
            Vector2 rightHand = new Vector2(landmarks[16].x, landmarks[16].y);

            Vector2 direction = rightHand - leftHand;
            _targetRollAngle = -Mathf.Atan2(direction.y, -direction.x) * Mathf.Rad2Deg;

            float averageShoulderY = (leftShoulder.y + rightShoulder.y) / 2;
            float averageHandY = (leftHand.y + rightHand.y) / 2;

            if (averageShoulderY < averageHandY)
            {
                _targetPitchAngle = (averageShoulderY - averageHandY) * sensitivityHandsDown;
            }
            else
            {
                _targetPitchAngle = (averageShoulderY - averageHandY) * sensitivityHandsUp;
            }
        }
    }

    void Update()
    {
        if (useKeyboard)
        {
            float horizontal = Input.GetAxis("Horizontal");
            float vertical = Input.GetAxis("Vertical");
            _targetRollAngle = horizontal * maxKeyboardRoll;
            _targetPitchAngle = vertical * maxKeyboardPitch;
        }
    }
}