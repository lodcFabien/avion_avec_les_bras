using System.Collections.Generic;
using NUnit.Framework;
using UnityEngine;
using UnityEngine.Events;

public class ButtonController : MonoBehaviour, IUiCollidable
{
    [SerializeField] private ButtonView _view;
    [SerializeField] private float _upInterpSpeed = 1f;
    [SerializeField] private float _downInterpSpeed = 5f;
    [SerializeField] private UnityEvent _onFilled;

    private float _fillValue = 0f;
    private bool _isTriggered = false;
    private List<HandController> _collidingHands = new List<HandController>();

    public void OnStartCollision(HandController collisionSource)
    {
        Debug.Log("Enter");

        if (!_collidingHands.Contains(collisionSource))
        {
            _collidingHands.Add(collisionSource);
        }
    }

    public void OnStopCollision(HandController collisionSource)
    {
        Debug.Log("Exit");

        if (_collidingHands.Contains(collisionSource))
        {
            _collidingHands.Remove(collisionSource);
        }
    }

    private void Update()
    {
        bool fill = _collidingHands.Count > 0;
        _fillValue = Mathf.MoveTowards(_fillValue, fill ? 1 : 0, (fill ? _upInterpSpeed : _downInterpSpeed) * Time.deltaTime);
        _view.UpdateFill(_fillValue);
        if (_fillValue >= 1f && !_isTriggered)
        {
            _onFilled?.Invoke();
            _isTriggered = true;
        }
    }
}
