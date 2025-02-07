using UnityEngine;
using UnityEngine.SceneManagement; // helps us move through scenes 

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

        if (lives <= 0) 
        {GameOver();}
    }

    public void GameOver()
    {
        SceneManager.LoadScene("GameOver");
    }

    public void AddPoint(int pointValue)
    {
        points += pointValue;
    }
}
