using System.Data;
using UnityEngine;

public class BrickLayer : MonoBehaviour

{
    public GameObject brick;
    public int rows, columns;
    public int numBricks;
    public float bs_h, bs_v; //for spacing/padding/buffer around bricks
    
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        Lay();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    //puts down da bricks
    public void Lay()
    {
        for (int i = 0; i <= columns; i++)
        {
            for (int j = 0; j <= rows; j++)
            {
                float xPos = -columns + (i * bs_h);
                float yPos = rows - (j * bs_v);
                Debug.Log(xPos + ":" + yPos);
                
                Instantiate(brick, new Vector3(xPos, yPos, 0), transform.rotation, this.transform);
                //a parent has to be the transform of a game object
                //gameobject.go to change individual things like color of dif rows 


            }
        }
    }
}
