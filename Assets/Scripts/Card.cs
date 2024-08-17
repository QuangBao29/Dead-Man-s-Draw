using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[CreateAssetMenu(fileName = "Card", menuName = "Card")]
public class Card : ScriptableObject
{
    public string CardName = "";
    public string CardEffect = "";
    public Sprite CardImage;
}
