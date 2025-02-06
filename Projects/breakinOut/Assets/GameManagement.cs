using UnityEngine;

public class GameManagement : MonoBehaviour
{

    public int points = 0;
    public int lives = 3;
    
    //singleton method, any script can point to this 
    public static GameManagement S;

    //used just for singletons
    void Awake()
    {
        S = this; 
    }

    public void LoseLife()
    {
        lives -= 1;
        Debug.Log(lives);
    }
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
