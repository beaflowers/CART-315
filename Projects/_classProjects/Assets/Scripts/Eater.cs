using UnityEngine;

public class Eater : MonoBehaviour
{
    public float xLoc, yLoc, xScal, yScal, zScal;
    public float speed = 0.2f;
    
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        xLoc = 6;
        yLoc = 0;
        
        xScal = 1;
        yScal = 1;
        zScal = 1;
        
        
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.S) && yLoc > -4f)
        {
            Debug.Log("Down");
            yLoc -= speed;
        }
        if (Input.GetKey(KeyCode.W) && yLoc < 4f)
        {
            Debug.Log("Up");
            yLoc += speed;
        }
        if (Input.GetKey(KeyCode.A) && xLoc > -9f)
        {
            Debug.Log("Left");
            xLoc -= speed;
        }
        if (Input.GetKey(KeyCode.D) && xLoc < 9f)
        {
            Debug.Log("Right");
            xLoc += speed;
        }
        
        this.transform.position = new Vector3(xLoc, yLoc, 0);
    }

    private void OnCollisionEnter2D(Collision2D other)
    {
        Debug.Log(other.gameObject.tag);
        if (other.gameObject.tag == "Circle")
        {
            Destroy(other.gameObject);
            this.transform.localScale = new Vector3(xScal += .2f, yScal += .2f, zScal += .2f); //controller object grows in size
            speed = speed - .01f; //reduces speed 
        }
    }
}
