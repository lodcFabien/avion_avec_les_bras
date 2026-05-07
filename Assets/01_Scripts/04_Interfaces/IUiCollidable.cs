using UnityEngine;

public interface IUiCollidable
{
    void OnStartCollision(HandController collisionSource);
    void OnStopCollision(HandController collisionSource);

}
