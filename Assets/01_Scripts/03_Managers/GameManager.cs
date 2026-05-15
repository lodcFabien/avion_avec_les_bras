using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.SceneManagement;

public class GameManager : MonoBehaviour
{
    private static int _selectedLevelIndex = 1;

    public static int SelectedLevelIndex
    {
        get => _selectedLevelIndex;
        set => _selectedLevelIndex = value;
    }

    [SerializeField] private List<Transform> _levelManagers;
    [SerializeField] private CameraController _cameraController;

    private AirplaneController _activeAirplane;
    public AirplaneController ActiveAirplane => _activeAirplane;

    private List<PortalController> _portals = new List<PortalController>();
    private int _currentPortalIndex = 0;

    void Start()
    {
        for (int i = 0; i < _levelManagers.Count; i++)
        {
            _levelManagers[i].gameObject.SetActive(i == SelectedLevelIndex);
        }

        Transform activeManager = _levelManagers[SelectedLevelIndex];
        LevelData levelData = activeManager.GetComponent<LevelData>();

        _activeAirplane = Instantiate(levelData.airplanePrefab, levelData.spawnPoint.position, levelData.spawnPoint.rotation);

        _cameraController.Airplane = _activeAirplane;

        _portals = new List<PortalController>(activeManager.GetComponentsInChildren<PortalController>());
        _portals.Sort((p1, p2) => p1.PortalIndex.CompareTo(p2.PortalIndex));
        _portals.ForEach(x => x.PortalCrossedEvent.AddListener(ActionOnPortalCrossed));

        UpdatePortalsState();
    }

    private void ActionOnPortalCrossed(PortalController portal)
    {
        if (portal.PortalIndex == _currentPortalIndex)
        {
            _currentPortalIndex++;

            UpdatePortalsState();

            if (_currentPortalIndex >= _portals.Count)
            {
                _currentPortalIndex = 0;
                GoToMenu();
            }
        }
    }
    private void UpdatePortalsState()
    {
        for (int i = 0; i < _portals.Count; i++)
        {
            _portals[i].SetActiveState(i == _currentPortalIndex);
        }
    }

    public void RestartLevel()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

    public void GoToMenu()
    {
        SceneManager.LoadScene("Menu");
    }
}