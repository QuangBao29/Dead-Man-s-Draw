Shader "Unlit/SparkleOutline"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _OutlineColor ("Outline Color", Color) = (1,1,1,1)
        _OutlineWidth ("Outline Width", Range(0.0, 0.5)) = 0.25
        _SparkleFrequency ("Sparkle Frequency", Range(0.0, 10.0)) = 5.0
        _SparkleIntensity ("Sparkle Intensity", Range(0.0, 1.0)) = 0.5
    }
    SubShader
    {
        Tags {"Queue" = "Transparent" }
        LOD 200

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                float4 screenPos : TEXCOORD1;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _OutlineColor;
            float _OutlineWidth;
            float _SparkleFrequency;
            float _SparkleIntensity;

            v2f vert (appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                o.screenPos = ComputeScreenPos(o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float2 uv = i.uv;
                float4 texColor = tex2D(_MainTex, uv);
                
                float2 screenUV = i.screenPos.xy / i.screenPos.w;
                screenUV.y = 1.0 - screenUV.y; // Flip y

                // Outline effect
                float edgeDist = min(screenUV.x, min(1.0 - screenUV.x, min(screenUV.y, 1.0 - screenUV.y)));
                float outline = smoothstep(_OutlineWidth, _OutlineWidth * 0.5, edgeDist);

                // Sparkle effect
                float sparkle = sin(_SparkleFrequency * (screenUV.x + screenUV.y + _Time.y)) * 0.5 + 0.5;
                sparkle = pow(sparkle, 4.0) * _SparkleIntensity;

                fixed4 outlineColor = _OutlineColor * (1.0 - outline + sparkle);

                return texColor + outlineColor;
            }
            ENDCG
        }
    }
}
