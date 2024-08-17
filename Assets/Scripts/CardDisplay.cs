using System.Collections;
using System.Collections.Generic;
using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class CardDisplay : MonoBehaviour
{
    public Card Card;

    [Header("Display Card Info")]
    public TextMeshProUGUI CardName;
    public TextMeshProUGUI CardEffect;
    public Image CardImage;

    private void Start()
    {
        CardName.text = Card.CardName;
        CardEffect.text = Card.CardEffect;
        CardImage.sprite = Card.CardImage;
    }

}
