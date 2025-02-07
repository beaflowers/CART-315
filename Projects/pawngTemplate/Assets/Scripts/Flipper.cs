using UnityEngine;

public class Flipper2D : MonoBehaviour { 
    
    public KeyCode flipKey; 
    public float flipTorque; 
    public float releaseTorque;

private HingeJoint2D hinge;

void Start()
{
    hinge = GetComponent<HingeJoint2D>();
    hinge.useMotor = true;
}

void Update()
{
    JointMotor2D motor = hinge.motor;

    if (Input.GetKey(flipKey))
    {
        motor.motorSpeed = flipTorque;
    }
    else
    {
        motor.motorSpeed = releaseTorque;
    }

    motor.maxMotorTorque = 3000f;
    hinge.motor = motor;
}
}