using Mediapipe.Tasks.Components.Containers;
using Mediapipe.Tasks.Vision.PoseLandmarker;
using System.Collections.Generic;
using UnityEngine;

public class InputManager : Singleton<InputManager>
{
    [SerializeField] private RectTransform _canvasRect;

    [SerializeField] private float _sensitivityHandsUpAndDown = 100;

    public float _armsAngle = 0;
    public float ArmsAngle => _armsAngle;

    private float _targetPitchAngle = 0;
    public float TargetPitchAngle => _targetPitchAngle;

    private Vector2 _leftHandCanvasPos;
    public Vector2 LeftHandCanvasPos => _leftHandCanvasPos;

    private Vector2 _rightHandCanvasPos;
    public Vector2 RightHandCanvasPos => _rightHandCanvasPos;

    private WebcamDataModel _pendingWebcamData;
    private bool _validData = false;

    public bool _playerActive = false;
    public bool PlayerActive => _playerActive;

    [Header("Debug Keyboard")]
    [SerializeField] private bool _useKeyboard = false;
    public bool UseKeyboard => _useKeyboard;

    [SerializeField] private float _maxKeyboardRoll = 45;
    [SerializeField] private float _maxKeyboardPitch = 10;

    [SerializeField] private float _handDepth = 5f;


    void Update()
    {
        if (_useKeyboard)
        {
            SetMovementValueFromKeyboard();
        }
        else if(_validData)
        {
            SetMovementValueFromWebcam();
        }
    }

    public void UpdateLandmarks(PoseLandmarkerResult result)
    {
        List<NormalizedLandmarks> poseLandmarks = result.poseLandmarks;

        if (_useKeyboard || poseLandmarks == null || poseLandmarks.Count <= 0)
        {
            return;
        }

        if (!_validData)
        {
            _validData = true;
        }


        List<Mediapipe.Tasks.Components.Containers.NormalizedLandmark> landmarks = result.poseLandmarks[0].landmarks;

        _pendingWebcamData = new WebcamDataModel
        {
            LeftHand = new Vector2(landmarks[15].x, landmarks[15].y),
            RightHand = new Vector2(landmarks[16].x, landmarks[16].y),
            LeftShoulder = new Vector2(landmarks[11].x, landmarks[11].y),
            RightShoulder = new Vector2(landmarks[12].x, landmarks[12].y),
        };

        _playerActive = landmarks[15].visibility > .5f && landmarks[16].visibility > .5f;

    }

    private void SetMovementValueFromKeyboard()
    {
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");
        _armsAngle = horizontal * _maxKeyboardRoll;
        _targetPitchAngle = vertical * _maxKeyboardPitch;
    }

    private void SetMovementValueFromWebcam()
    {
        Vector2 direction = _pendingWebcamData.RightHand - _pendingWebcamData.LeftHand;


        float averageShoulderY = (_pendingWebcamData.LeftShoulder.y + _pendingWebcamData.RightShoulder.y) / 2;
        float averageHandY = (_pendingWebcamData.LeftHand.y + _pendingWebcamData.RightHand.y) / 2;


        _armsAngle = _playerActive ? -Mathf.Atan2(direction.y, -direction.x) * Mathf.Rad2Deg : 0;
        _targetPitchAngle = _playerActive ? (averageShoulderY - averageHandY) * _sensitivityHandsUpAndDown : 0;


        _leftHandCanvasPos = GetCanvasPos(_pendingWebcamData.RightHand);
        _rightHandCanvasPos = GetCanvasPos(_pendingWebcamData.LeftHand);
    }

    private Vector2 GetCanvasPos(Vector2 normalizedPos)
    {
        return new Vector2(normalizedPos.x * Screen.width, (1-normalizedPos.y) * Screen.height);
    }
}