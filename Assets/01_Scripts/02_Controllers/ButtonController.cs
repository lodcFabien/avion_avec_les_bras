using NUnit.Framework;
using System.Collections.Generic;
using UnityEngine;

public class ButtonController : MonoBehaviour, IUiCollidable
{
    [SerializeField] private ButtonView _view;
    [SerializeField] private float _upInterpSpeed = 10f;
    [SerializeField] private float _downInterpSpeed = 60f;

    private float _fillValue = 0f;

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
    }
}
