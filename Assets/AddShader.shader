Shader "Hidden/AddShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
        Blend SrcAlpha OneMinusSrcAlpha  // enable alpha blending

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _Sample;

            fixed4 frag (v2f i) : SV_Target
            {
                // fixed4 col = tex2D(_MainTex, i.uv);
                // // just invert the colors
                // col.rgb = 1 - col.rgb;
                // return col;

                // ref: http://three-eyed-games.com/2018/05/03/gpu-ray-tracing-in-unity-part-1/
                // montecarlo integration over hemisphere of fragment, divide by 1/numsamples
                // per bound in ray path trace, will check another random direction per frame
                    // TODO: can this be improved? check multiple hemisphere directions per frame
                return float4(tex2D(_MainTex, i.uv).rgb, 1.0f / (_Sample + 1.0f));
                // return float4(tex2D(_MainTex, i.uv).rgb, 1.0f);
                
            }
            ENDCG
        }
    }
}
