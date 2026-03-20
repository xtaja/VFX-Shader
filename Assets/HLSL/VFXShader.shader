Shader "Unlit/VFXShader"
{
    Properties
    {
        //Shader properties
        [Enum(UnityEngine.Rendering.CullMode)] _Cull ("Cull Mode", Float) = 2

        //Main 
        [NoScaleOffset] _Main_Texture ("Main Texture", 2D) = "white" {}
        [Toggle (_CLAMP_MAIN_TEXTURE_ON)]_Clamp_Main_Texture ("Clamp Main Texture", Float) = 0
        [HDR] _Color_0 ("Color 0", Color) = (0,0,0,1)
        [HDR] _Color_1 ("Color 1", Color) = (1,1,1,1)
        _Intensity ("Intensity", Range (0, 100)) = 1
        _Scroll_Speed_X ("Scroll Speed X", Float) = 0
        _Scroll_Speed_Y ("Scroll Speed Y", Float) = 0
        _Rotation_Speed ("Rotation Speed", Float) = 0
        [Toggle (_USE_LIFETIME_ON)] _Use_Lifetime ("Use Lifetime", Float) = 0

        //Distortion
        [Toggle (_DISTORTION_ON)] _Distortion ("Use Distortion", Float) = 0
        [Enum(2D_Texture, 0, Gradient_Noise, 1, Simple_Noise, 2, Voronoi, 3)] _DISTORTION_TYPE ("Distortion Type", Float) = 0
        [NoScaleOffset] _Distortion_Texture ("Distortion Texture", 2D) = "black" {}//2D Texture
        _Distortion_Scale ("Distortion Scale", Float) = 5 //Voronoi, Simple noise, Gradient noise
        _Angle_Offset ("Angle Offset", Float) = 0 //Voronoi
        _Distortion_Amount ("Distortion Amount", Range (0, 10)) = 0
        _Distortion_Scroll_Speed_X ("Distortion Scroll Speed X", Float) = 0
        _Distortion_Scroll_Speed_Y ("Distortion Scroll Speed Y", Float) = 0
        _Distortion_Rotation_Speed ("Distortion Rotation Speed", Float) = 0
        

        //Mask 
        [Toggle (_MASK_ON)] _Mask ("Use Mask", Float) = 0
        [NoScaleOffset] _Mask_Texture ("Mask Texture", 2D) = "white" {}   
        [Toggle (_CLAMP_MASK_ON)] _Clamp_Mask ("Clamp Mask Texture", Float) = 0
        _Mask_Gamma ("Mask Gamma", Range (0.001, 10)) = 1
        _Mask_Scroll_Speed_X ("Mask Scroll Speed X", Float) = 0
        _Mask_Scroll_Speed_Y ("Mask Scroll Speed Y", Float) = 0
        _Mask_Rotation_Speed ("Mask Rotation Speed", Float) = 0
        [Toggle (_MASK_DISTORTION_ON)] _Mask_Distortion ("Use Mask Distortion", Float) = 0
        [Enum(2D_Texture, 0, Gradient_Noise, 1, Simple_Noise, 2, Voronoi, 3)] _MASK_DISTORTION_TYPE ("Mask Distortion Type", Float) = 0
        [NoScaleOffset] _Mask_Distortion_Texture ("Mask Distortion Texture", 2D) = "black" {}
        _Mask_Distortion_Scale ("Mask Distortion Scale", Float) = 5
        _Mask_Angle_Offset ("Mask Angle Offset", Float) = 0
        _Mask_Distortion_Amount ("Mask Distortion Amount", Range (0, 10)) = 0
        _Mask_Distortion_Scroll_Speed_X ("Mask Distortion Scroll Speed X", Float) = 0
        _Mask_Distortion_Scroll_Speed_Y ("Mask Distortion Scroll Speed Y", Float) = 0
        _Mask_Distortion_Rotation_Speed ("Mask Distortion Rotation Speed", Float) = 0

        //Dissolve
        [Toggle (_DISSOLVE_ON)] _Dissolve ("Use Dissolve", Float) = 0
        [Toggle (_INVERT_DISSOLVE_ON)] _Invert_Dissolve ("Invert Dissolve", Float) = 0
        [NoScaleOffset] _Dissolve_Texture ("Dissolve Texture", 2D) = "white" {}
        _Dissolve_Gamma ("Dissolve Gamma", Range (0.001, 10)) = 1
        _Dissolve_Amount ("Dissolve Amount", Range (0, 1)) = 1
        _Edge_Width ("Edge Width", Range (0, 10)) = 0.05
        [Toggle (_DISSOLVE_OVER_LIFETIME_ON)] _Dissolve_Over_Lifetime ("Dissolve Over Lifetime", Float) = 0
        _Dissolve_Speed ("Dissolve Speed", Float) = 10

        //Depth Fade
        [Toggle (_DEPTH_FADE_ON)] _Depth_Fade ("Depth Fade", Float) = 0
        _Depth_Fade_Amount ("Depth Fade Amount", Range (0, 5)) = 0.05

        //Fresnel
        [Toggle (_FRESNEL_ON)] _Fresnel ("Use Fresnel", Float) = 0
        [Toggle (_INVERT_FRESNEL_ON)] _Invert_Fresnel ("Invert Fresnel", Float) = 0
        _Fresnel_Power ("Fresnel Power", Range (0.001, 10)) = 1
        _Edge_1 ("Edge 1", Range (0, 1)) = 0
        _Edge_2 ("Edge 2", Range (0, 1)) = 1

    }

    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalRenderPipeline"
            "RenderType"="Transparent"
            "Queue"="Transparent"
        }

        Cull [_Cull]
        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        Pass
        {
            Name "ForwardUnlit"
            Tags { "LightMode"="UniversalForward" }

            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
            #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DeclareDepthTexture.hlsl"
            #include "GradientNoise.hlsl"
            #include "SimpleNoise.hlsl"
            #include "Voronoi.hlsl"

            #pragma shader_feature_local _CLAMP_MAIN_TEXTURE_ON
            #pragma shader_feature_local _USE_LIFETIME_ON
            #pragma shader_feature_local _DISTORTION_ON
            #pragma shader_feature_local _DISTORTION_TYPE_TEXTURE2D _DISTORTION_TYPE_GRADIENTNOISE _DISTORTION_TYPE_SIMPLENOISE _DISTORTION_TYPE_VORONOI            
            #pragma shader_feature_local _MASK_ON
            #pragma shader_feature_local _CLAMP_MASK_ON
            #pragma shader_feature_local _MASK_DISTORTION_ON
            #pragma shader_feature_local _MASK_DISTORTION_TYPE_TEXTURE2D _MASK_DISTORTION_TYPE_GRADIENTNOISE _MASK_DISTORTION_TYPE_SIMPLENOISE _MASK_DISTORTION_TYPE_VORONOI            
            #pragma shader_feature_local _DISSOLVE_ON
            #pragma shader_feature_local _INVERT_DISSOLVE_ON
            #pragma shader_feature_local _DISSOLVE_OVER_LIFETIME_ON
            #pragma shader_feature_local _DEPTH_FADE_ON
            #pragma shader_feature_local _FRESNEL_ON
            #pragma shader_feature_local _INVERT_FRESNEL_ON

            CBUFFER_START(UnityPerMaterial)

                //Main
                float4 _Color_0;
                float4 _Color_1;
                float _Intensity;
                float _Scroll_Speed_X;
                float _Scroll_Speed_Y;
                float _Rotation_Speed;
                float _Clamp_Main_Texture;
                float _Use_Lifetime;

                //Distortion
                float _Distortion;
                float _DISTORTION_TYPE;
                float _Distortion_Scale;
                float _Angle_Offset;
                float _Distortion_Amount;
                float _Distortion_Scroll_Speed_X;
                float _Distortion_Scroll_Speed_Y;
                float _Distortion_Rotation_Speed;

                //Mask 
                float _Mask;
                float _Mask_Gamma;
                float _Mask_Scroll_Speed_X;
                float _Mask_Scroll_Speed_Y;
                float _Mask_Rotation_Speed;
                float _Clamp_Mask;
                //Mask Distortion
                float _Mask_Distortion;
                float _MASK_DISTORTION_TYPE;
                float _Mask_Distortion_Scale;
                float _Mask_Angle_Offset;
                float _Mask_Distortion_Amount;
                float _Mask_Distortion_Scroll_Speed_X;
                float _Mask_Distortion_Scroll_Speed_Y;
                float _Mask_Distortion_Rotation_Speed;

                //Dissolve
                float _Dissolve;
                float _Invert_Dissolve;
                float _Dissolve_Gamma;
                float _Dissolve_Amount;
                float _Edge_Width;
                float _Dissolve_Over_Lifetime;
                float _Dissolve_Speed;

                //Depth Fade
                float _Depth_Fade;
                float _Depth_Fade_Amount;

                //Fresnel
                float _Fresnel;
                float _Invert_Fresnel;
                float _Fresnel_Power;
                float _Edge_1;
                float _Edge_2;

            CBUFFER_END

            //Textures
            //Main
            TEXTURE2D(_Main_Texture);
            SAMPLER(sampler_Main_Texture);
            //Distortion
            TEXTURE2D(_Distortion_Texture);  
            SAMPLER(sampler_Distortion_Texture);
            //Mask 
            TEXTURE2D(_Mask_Texture);
            SAMPLER(sampler_Mask_Texture);
            //Mask Distortion
            TEXTURE2D(_Mask_Distortion_Texture);  
            SAMPLER(sampler_Mask_Distortion_Texture);
            //Dissolve
            TEXTURE2D(_Dissolve_Texture);
            SAMPLER(sampler_Dissolve_Texture);



            struct Attributes
            {
                float4 positionOS : POSITION;
                float3 uv_xyz : TEXCOORD0; //xy = UV, z = age%
                float3 normalOS : NORMAL;
                float4 color : COLOR;

            };

            struct Varyings
            {
                float4 positionHCS : SV_POSITION;
                float2 uv : TEXCOORD0;
                float agePercent : TEXCOORD1;
                float2 distortionUV : TEXCOORD2;
                float2 maskUV : TEXCOORD3;
                float2 maskDistortionUV : TEXCOORD4;
                float2 dissolveUV : TEXCOORD5;
                float4 color : COLOR;
                float3 positionVS : TEXCOORD6;
                float3 positionWS : TEXCOORD7;
                float4 screenPos : TEXCOORD8;
                float3 normalWS : TEXCOORD9;
            };

            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Functions  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

            float GetTime(float age)
            {
                #if defined(_USE_LIFETIME_ON)
                    return age; //use age% if using lifetime
                #else
                    return _Time.y;
                #endif 
            }

            float2 ScrollUV(float2 uv, float t, float scrollX, float scrollY)
            {
                #if defined (_USE_LIFETIME_ON)
                    return uv + float2(scrollX, scrollY) * t;

                #else
                    float x=(scrollX!=0) ? fmod(t, 1.0/scrollX)*scrollX : 0; 
                    float y= (scrollY!=0) ? fmod(t, 1.0/scrollY)*scrollY : 0;

                    return uv + float2(x, y);
                #endif
            }

            float2 RotateUV(float2 uv, float t, float rotationSpeed)
            {
                uv -= 0.5;
                #if !defined(_USE_LIFETIME_ON)
                    t= fmod(t, 360.0);
                #endif
                float angle = radians(rotationSpeed * t);
                float s = sin(angle);
                float c = cos(angle);

                float2 rotated = float2(
                    uv.x * c - uv.y * s,
                    uv.x * s + uv.y * c
                );

                return rotated + 0.5;
            }


            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Vertex Shader  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            Varyings vert(Attributes IN)
            {
                Varyings OUT;
                float agePercent = IN.uv_xyz.z;            
                float time = GetTime(agePercent);

                //Main Texture
                float2 uv = IN.uv_xyz.xy;
                uv = ScrollUV(uv, time, _Scroll_Speed_X, _Scroll_Speed_Y);
                uv = RotateUV(uv, time, _Rotation_Speed);

                //Distortion Texture
                float2 distortionUV = IN.uv_xyz.xy;
                #if defined(_DISTORTION_ON)
                    distortionUV = ScrollUV(distortionUV, time, _Distortion_Scroll_Speed_X, _Distortion_Scroll_Speed_Y);
                    distortionUV = RotateUV(distortionUV, time, _Distortion_Rotation_Speed); 
                #endif

                //Mask Texture
                float2 maskUV = IN.uv_xyz.xy;
                #if defined(_MASK_ON)
                    maskUV = ScrollUV(maskUV, time, _Mask_Scroll_Speed_X, _Mask_Scroll_Speed_Y);
                    maskUV = RotateUV(maskUV, time, _Mask_Rotation_Speed);
                #endif
                //Mask Distortion Texture
                float2 maskDistortionUV = IN.uv_xyz.xy;
                #if defined(_MASK_DISTORTION_ON)
                        maskDistortionUV = ScrollUV(maskDistortionUV, time, _Mask_Distortion_Scroll_Speed_X, _Mask_Distortion_Scroll_Speed_Y);
                        maskDistortionUV = RotateUV(maskDistortionUV, time, _Mask_Distortion_Rotation_Speed);
                    #endif

                //Dissolve Texture
                float2 dissolveUV = IN.uv_xyz.xy; 

                //Depth Fade
                float3 positionWS = TransformObjectToWorld(IN.positionOS.xyz); //local-> world position
                OUT.positionHCS = TransformWorldToHClip(positionWS);// world-> clip position
                OUT.screenPos = ComputeScreenPos(OUT.positionHCS); //clip-> screen position
                OUT.positionVS = TransformWorldToView(positionWS);//world-> view position

                //Fresnel
                OUT.positionWS = positionWS;
                OUT.normalWS = TransformObjectToWorldNormal(IN.normalOS);


                OUT.color = IN.color;
                OUT.uv = uv;
                OUT.agePercent = agePercent;
                OUT.distortionUV = distortionUV;
                OUT.maskUV = maskUV;
                OUT.maskDistortionUV = maskDistortionUV;
                OUT.dissolveUV = dissolveUV;

                
                return OUT;
            }

            // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  Fragment Shader  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
            
            float4 frag(Varyings IN) : SV_Target
            {
                float2 uv = IN.uv;
                float2 maskUV = IN.maskUV;

                //Clamp Texture
                float2 sampleUV = uv;
                #if defined(_CLAMP_MAIN_TEXTURE_ON)
                    uv = saturate(sampleUV);  //clamps to [0, 1]
                #endif
                float2 sampleMaskUV = maskUV;
                #if defined(_CLAMP_MASK_ON) && defined(_MASK_ON)
                    maskUV = saturate(sampleMaskUV);  //clamps to [0, 1]
                #endif

                // Distortion
                #if defined(_DISTORTION_ON)
                    #if defined(_DISTORTION_TYPE_GRADIENTNOISE) //Gradient Noise
                        float2 gradientNoiseUV = IN.distortionUV;
                        float gradientOut;
                        Unity_GradientNoise_float(gradientNoiseUV, _Distortion_Scale, gradientOut);
                        uv = uv + (gradientOut * _Distortion_Amount);
                    
                    #elif defined(_DISTORTION_TYPE_SIMPLENOISE)//Simple Noise
                        float2 simpleNoiseUV = IN.distortionUV;
                        float simpleOut;
                        Unity_SimpleNoise_float(simpleNoiseUV, _Distortion_Scale, simpleOut);
                        uv = uv + (simpleOut * _Distortion_Amount);

                    #elif defined(_DISTORTION_TYPE_VORONOI)//Voronoi
                        float2 voronoiUV = IN.distortionUV;
                        float voronoiOut;
                        float voronoiCells;
                        Unity_Voronoi_float(voronoiUV, _Angle_Offset, _Distortion_Scale, voronoiOut, voronoiCells);
                        uv = uv + (voronoiOut * _Distortion_Amount);
                    #else //defined(_DISTORTION_TYPE_TEXTURE2D) //2D Texture
                        float distSample = SAMPLE_TEXTURE2D(_Distortion_Texture, sampler_Distortion_Texture, IN.distortionUV).g;
                        uv = uv + (distSample * _Distortion_Amount);
                    #endif
                #endif

                //Mask Distortion
                #if defined(_MASK_DISTORTION_ON)                
                    #if defined(_MASK_DISTORTION_TYPE_GRADIENTNOISE) //Gradient Noise
                        float2 maskGradientNoiseUV = IN.maskDistortionUV;
                        float MaskGradientOut;
                        Unity_GradientNoise_float(maskGradientNoiseUV, _Mask_Distortion_Scale, MaskGradientOut);
                        maskUV = maskUV + (MaskGradientOut * _Mask_Distortion_Amount);
                    
                    #elif defined(_MASK_DISTORTION_TYPE_SIMPLENOISE)//Simple Noise
                        float2 maskSimpleNoiseUV = IN.maskDistortionUV;
                        float maskSimpleOut;
                        Unity_SimpleNoise_float(maskSimpleNoiseUV, _Mask_Distortion_Scale, maskSimpleOut);
                        maskUV = maskUV + (maskSimpleOut * _Mask_Distortion_Amount);
                    
                    #elif defined(_MASK_DISTORTION_TYPE_VORONOI)//Voronoi 
                        float2 maskVoronoiUV = IN.maskDistortionUV;
                        float maskVoronoiOut;
                        float maskVoronoiCells;
                        Unity_Voronoi_float(maskVoronoiUV, _Mask_Angle_Offset, _Mask_Distortion_Scale, maskVoronoiOut, maskVoronoiCells);
                        maskUV = maskUV + (maskVoronoiOut * _Mask_Distortion_Amount);
                    #else //defined(_MASK_DISTORTION_TYPE_TEXTURE2D) //2D Texture
                        float maskDistSample = SAMPLE_TEXTURE2D(_Mask_Distortion_Texture, sampler_Mask_Distortion_Texture, IN.maskDistortionUV).g;
                        maskUV = maskUV +(maskDistSample*_Mask_Distortion_Amount);
                    #endif
                #endif

                
                float4 tex = SAMPLE_TEXTURE2D(_Main_Texture, sampler_Main_Texture, uv);

                float3 gradient = lerp(_Color_0.rgb, _Color_1.rgb, tex.rgb);// remap black→Color0, white→Color1
                float3 finalRGB = gradient * IN.color.rgb* _Intensity;// combine gradient with particle color and intensity
                

                //Mask
                float mask = 1.0f;
                #if defined(_MASK_ON)
                    mask = SAMPLE_TEXTURE2D(_Mask_Texture, sampler_Mask_Texture, maskUV).r;
                    mask = pow(mask, _Mask_Gamma);
                    mask = saturate(mask);                    
                #endif

                //Dissolve
                float dissolve = 1.0f;
                #if defined(_DISSOLVE_ON)                
                    float dissolveSample = SAMPLE_TEXTURE2D(_Dissolve_Texture, sampler_Dissolve_Texture, IN.dissolveUV).b;
                    dissolveSample = pow(dissolveSample, _Dissolve_Gamma);
                    dissolveSample = saturate(dissolveSample);
                    float dissolveTime = 1;
                    #if defined(_DISSOLVE_OVER_LIFETIME_ON)
                        #if defined(_INVERT_DISSOLVE_ON)
                            dissolveTime = (1.0 - IN.agePercent) * _Dissolve_Speed;
                        
                        #else
                            dissolveTime = IN.agePercent * _Dissolve_Speed; 
                        #endif
                    #endif
                    float threshold = _Dissolve_Amount* dissolveTime;
                    dissolve = smoothstep(threshold, threshold + _Edge_Width, dissolveSample);
                    
                #endif
                

                //Depth Fade
                float depthFade = 1.0f;
                #if defined(_DEPTH_FADE_ON)
                    float2 screenUV = IN.screenPos.xy / IN.screenPos.w; 
                    float sceneDepthSample = SampleSceneDepth(screenUV); 
                    float sceneLinearDepth = LinearEyeDepth(sceneDepthSample, _ZBufferParams);
                    float fragmentLinearDepth = -IN.positionVS.z; 
                    float depthDistance = sceneLinearDepth - fragmentLinearDepth;
                    depthFade = saturate(depthDistance / max(_Depth_Fade_Amount, 1e-5));
                #endif
                
                //Fresnel
                float fresnel = 1.0f;
                #if defined(_FRESNEL_ON)
                    float3 V = normalize(_WorldSpaceCameraPos.xyz - IN.positionWS);
                    float3 N = normalize(IN.normalWS);
                    fresnel = pow(abs(dot(N, V)), _Fresnel_Power);
                    fresnel = smoothstep(_Edge_1, _Edge_2, fresnel);
                    #if defined(_INVERT_FRESNEL_ON)
                        fresnel = 1.0 - fresnel;
                    #endif
                #endif
                   

                //Final alpha = main texture alpha * particle alpha * mask * dissolve * depth fade * fresnel
                float finalA = tex.a * IN.color.a * mask * dissolve * depthFade * fresnel;

                return float4(finalRGB, finalA); 
            }

            ENDHLSL
        }
    }
    CustomEditor "VFXShaderGUI"
}
