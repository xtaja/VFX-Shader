using UnityEngine;
using UnityEditor;

public class VFXShaderGUI : ShaderGUI
{
    //foldout keys  
    const string MAIN_KEY = "StylizedShaderGUI_Main_";
    const string DISTORTION_KEY = "StylizedShaderGUI_Distortion_";
    const string MASK_KEY = "StylizedShaderGUI_Mask_";
    const string DISSOLVE_KEY = "StylizedShaderGUI_Dissolve_";
    const string DEPTH_KEY = "StylizedShaderGUI_Depth_";
    const string FRESNEL_KEY = "StylizedShaderGUI_Fresnel_";

    //Main Settings
    MaterialProperty _Cull;
    MaterialProperty _MainTex;
    MaterialProperty _ClampMainTexture;
    MaterialProperty _Color0;
    MaterialProperty _Color1;
    MaterialProperty _Intensity;
    MaterialProperty _ScrollSpeedX;
    MaterialProperty _ScrollSpeedY;
    MaterialProperty _RotationSpeed;
    MaterialProperty _UseLifetime;
    

    //Distortion
    MaterialProperty _UseDistortion;
    MaterialProperty _DistortionType;
    MaterialProperty _DistortionScale;
    MaterialProperty _AngleOffset;
    MaterialProperty _DistortionTex;
    MaterialProperty _DistortionAmount;
    MaterialProperty _DistortionScrollX;
    MaterialProperty _DistortionScrollY;
    MaterialProperty _DistortionRotation;

    //Mask
    MaterialProperty _UseMask;
    MaterialProperty _MaskTex;
    MaterialProperty _ClampMask;
    MaterialProperty _MaskScrollX;
    MaterialProperty _MaskScrollY;
    MaterialProperty _MaskRotation;
    MaterialProperty _UseMaskDistortion;
    MaterialProperty _MaskDistortionType;
    MaterialProperty _MaskDistortionScale;
    MaterialProperty _MaskAngleOffset;
    MaterialProperty _MaskDistortionTex;
    MaterialProperty _MaskDistortionAmount;
    MaterialProperty _MaskDistortionScrollX;
    MaterialProperty _MaskDistortionScrollY;
    MaterialProperty _MaskDistortionRotation;
    

    //Dissolve
    MaterialProperty _UseDissolve;
    MaterialProperty _InvertDissolve;
    MaterialProperty _DissolveTex;
    MaterialProperty _DissolveAmount;
    MaterialProperty _EdgeWidth;   
    MaterialProperty _UseDissolveOverLife;
    MaterialProperty _DissolveSpeed;

    //Depth Fade
    MaterialProperty _UseDepthFade;
    MaterialProperty _DepthFadeAmount;

    //Fresnel
    MaterialProperty _Fresnel;
    MaterialProperty _InvertFresnel;
    MaterialProperty _FresnelPower;
    MaterialProperty _Edge1;
    MaterialProperty _Edge2;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
    {
        Material mat = (Material)materialEditor.target;
        string matName = mat.name;

        //foldout states
        bool mainOpen = EditorPrefs.GetBool(MAIN_KEY + matName, true);
        bool distortionOpen = EditorPrefs.GetBool(DISTORTION_KEY + matName, false);
        bool maskOpen = EditorPrefs.GetBool(MASK_KEY + matName, false);
        bool dissolveOpen = EditorPrefs.GetBool(DISSOLVE_KEY + matName, false);
        bool depthOpen = EditorPrefs.GetBool(DEPTH_KEY + matName, false);
        bool fresnelOpen =EditorPrefs.GetBool(FRESNEL_KEY +matName, false);

        _Cull = FindProperty("_Cull", properties, false);
        _MainTex = FindProperty("_Main_Texture", properties, false);
        _ClampMainTexture = FindProperty("_Clamp_Main_Texture",properties, false);
        _Color0 = FindProperty("_Color_0", properties, false);
        _Color1 = FindProperty("_Color_1", properties, false);
        _Intensity = FindProperty("_Intensity", properties, false);
        _ScrollSpeedX = FindProperty("_Scroll_Speed_X", properties, false);
        _ScrollSpeedY = FindProperty("_Scroll_Speed_Y", properties, false);
        _RotationSpeed = FindProperty ("_Rotation_Speed", properties, false);
        _UseLifetime = FindProperty("_Use_Lifetime",properties, false);

        _UseDistortion = FindProperty("_Distortion", properties, false);
        _DistortionType = FindProperty("_DISTORTION_TYPE", properties, false);
        _DistortionScale = FindProperty("_Distortion_Scale", properties, false);
        _AngleOffset = FindProperty("_Angle_Offset", properties, false);
        _DistortionTex = FindProperty("_Distortion_Texture", properties, false);
        _DistortionAmount = FindProperty("_Distortion_Amount", properties, false);
        _DistortionScrollX = FindProperty("_Distortion_Scroll_Speed_X", properties, false);
        _DistortionScrollY = FindProperty("_Distortion_Scroll_Speed_Y", properties, false);
        _DistortionRotation = FindProperty("_Distortion_Rotation_Speed", properties, false);

        _UseMask = FindProperty("_Mask", properties, false);
        _MaskTex = FindProperty("_Mask_Texture", properties, false);
        _ClampMask = FindProperty("_Clamp_Mask", properties, false);
        _MaskScrollX = FindProperty("_Mask_Scroll_Speed_X", properties, false);
        _MaskScrollY = FindProperty("_Mask_Scroll_Speed_Y", properties, false);
        _MaskRotation = FindProperty("_Mask_Rotation_Speed", properties, false);
        _UseMaskDistortion = FindProperty("_Mask_Distortion",properties, false);
        _MaskDistortionType = FindProperty("_MASK_DISTORTION_TYPE", properties, false);
        _MaskDistortionScale = FindProperty("_Mask_Distortion_Scale", properties, false);
        _MaskAngleOffset = FindProperty("_Mask_Angle_Offset", properties, false);
        _MaskDistortionTex = FindProperty("_Mask_Distortion_Texture", properties, false);
        _MaskDistortionAmount = FindProperty("_Mask_Distortion_Amount", properties, false);
        _MaskDistortionScrollX = FindProperty("_Mask_Distortion_Scroll_Speed_X", properties, false);
        _MaskDistortionScrollY = FindProperty("_Mask_Distortion_Scroll_Speed_Y", properties, false);
        _MaskDistortionRotation = FindProperty("_Mask_Distortion_Rotation_Speed", properties, false);

        _UseDissolve = FindProperty("_Dissolve", properties, false);
        _InvertDissolve = FindProperty("_Invert_Dissolve", properties, false);
        _DissolveTex = FindProperty("_Dissolve_Texture", properties, false);
        _DissolveAmount = FindProperty("_Dissolve_Amount", properties, false);
        _EdgeWidth = FindProperty("_Edge_Width", properties, false);
        _UseDissolveOverLife = FindProperty("_Dissolve_Over_Lifetime", properties, false);
        _DissolveSpeed = FindProperty("_Dissolve_Speed", properties, false);

        _UseDepthFade = FindProperty("_Depth_Fade", properties, false);
        _DepthFadeAmount = FindProperty("_Depth_Fade_Amount", properties, false);

        _Fresnel = FindProperty("_Fresnel", properties, false);
        _InvertFresnel = FindProperty("_Invert_Fresnel", properties, false);
        _FresnelPower = FindProperty("_Fresnel_Power", properties, false);
        _Edge1 = FindProperty("_Edge_1", properties, false);
        _Edge2 = FindProperty ("_Edge_2", properties, false);


        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MAIN SETTINGS ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        EditorGUILayout.BeginVertical();
        EditorGUILayout.BeginHorizontal();
        if(GUILayout.Button("Main Settings\n", EditorStyles.boldLabel))
        {
            mainOpen = !mainOpen;
            EditorPrefs.SetBool( MAIN_KEY + matName, mainOpen);
        }
        GUILayout.EndHorizontal();

        DrawIfValid(materialEditor, _MainTex);
        DrawIfValid(materialEditor, _ClampMainTexture);
        DrawIfValid(materialEditor, _Color0);
        DrawIfValid(materialEditor, _Color1);
        DrawIfValid(materialEditor, _Intensity);
        DrawIfValid(materialEditor, _ScrollSpeedX);
        DrawIfValid(materialEditor, _ScrollSpeedY);
        DrawIfValid(materialEditor, _RotationSpeed);
        DrawIfValid(materialEditor,_UseLifetime);

        EditorGUILayout.EndVertical();
       
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DISTORTION ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        EditorGUILayout.BeginHorizontal("button");
        bool distortionEnabled = _UseDistortion.floatValue == 1f;
        distortionEnabled = GUILayout.Toggle(distortionEnabled,"",GUILayout.MaxWidth(17));
        _UseDistortion.floatValue = distortionEnabled ? 1f : 0f;

        if(GUILayout.Button("Distortion", EditorStyles.boldLabel))
        {
            distortionOpen = !distortionOpen;
            EditorPrefs.SetBool( DISTORTION_KEY + matName, distortionOpen);
        }
        GUILayout.EndHorizontal();

        if (distortionOpen)
        {
            EditorGUILayout.BeginVertical("box");
            bool enabled = _UseDistortion != null && _UseDistortion.floatValue == 1f;
            EditorGUI.BeginDisabledGroup(!enabled);
            EditorGUI.BeginChangeCheck();
            materialEditor.ShaderProperty(_DistortionType, _DistortionType.displayName);

            if (EditorGUI.EndChangeCheck())
            {
                foreach (var obj in _DistortionType.targets)
                {
                    var matInstance = (Material)obj;   
                    matInstance.DisableKeyword("_DISTORTION_TYPE_TEXTURE2D");
                    matInstance.DisableKeyword("_DISTORTION_TYPE_GRADIENTNOISE");
                    matInstance.DisableKeyword("_DISTORTION_TYPE_SIMPLENOISE");
                    matInstance.DisableKeyword("_DISTORTION_TYPE_VORONOI");

                    switch ((int)_DistortionType.floatValue)
                    {
                        case 0:
                            matInstance.EnableKeyword("_DISTORTION_TYPE_TEXTURE2D");
                            break;
                        case 1:
                            matInstance.EnableKeyword("_DISTORTION_TYPE_GRADIENTNOISE");
                            break;
                        case 2:
                            matInstance.EnableKeyword("_DISTORTION_TYPE_SIMPLENOISE");
                            break;
                        case 3:
                            matInstance.EnableKeyword("_DISTORTION_TYPE_VORONOI");
                            break;
                    }

                    EditorUtility.SetDirty(matInstance);
                }  
            }
                
            if (_DistortionType != null)
            {
                int type = (int)_DistortionType.floatValue;
                switch (type)
                {
                    case 0: // Texture2D
                        DrawIfValid(materialEditor, _DistortionTex);
                        break;
                    case 1: // GradientNoise
                    case 2: // SimpleNoise
                        DrawIfValid(materialEditor, _DistortionScale);
                        break;
                    case 3: // Voronoi
                        DrawIfValid(materialEditor, _DistortionScale);
                        DrawIfValid(materialEditor, _AngleOffset);
                        break;
                }

                DrawIfValid(materialEditor, _DistortionAmount);
                DrawIfValid(materialEditor, _DistortionScrollX);
                DrawIfValid(materialEditor, _DistortionScrollY);
                DrawIfValid(materialEditor, _DistortionRotation);                
            }

            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndVertical();
        }
        
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ MASK ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        EditorGUILayout.BeginHorizontal("button");
        bool maskEnabled = _UseMask.floatValue == 1f;
        maskEnabled = GUILayout.Toggle(maskEnabled,"",GUILayout.MaxWidth(17));
        _UseMask.floatValue = maskEnabled ? 1f : 0f;

        if(GUILayout.Button("Mask", EditorStyles.boldLabel))
        {
            maskOpen = !maskOpen;
            EditorPrefs.SetBool( MASK_KEY + matName, maskOpen);
        }
        GUILayout.EndHorizontal();

        if (maskOpen) 
         { 
            EditorGUILayout.BeginVertical("box");
            bool enabled = _UseMask != null && _UseMask.floatValue == 1f;
            EditorGUI.BeginDisabledGroup(!enabled);

            DrawIfValid(materialEditor, _MaskTex);
            DrawIfValid(materialEditor,_ClampMask);
            DrawIfValid(materialEditor, _MaskScrollX); 
            DrawIfValid(materialEditor, _MaskScrollY); 
            DrawIfValid(materialEditor, _MaskRotation);

            DrawIfValid(materialEditor,_UseMaskDistortion);
            if (_UseMaskDistortion != null && _UseMaskDistortion.floatValue == 1)
            {
                EditorGUI.BeginChangeCheck();
                materialEditor.ShaderProperty(_MaskDistortionType, _MaskDistortionType.displayName);

                if (EditorGUI.EndChangeCheck())
                {
                    foreach (var obj in _MaskDistortionType.targets)
                    {
                        var matInstance = (Material)obj;

                        matInstance.DisableKeyword("_MASK_DISTORTION_TYPE_TEXTURE2D");
                        matInstance.DisableKeyword("_MASK_DISTORTION_TYPE_GRADIENTNOISE");
                        matInstance.DisableKeyword("_MASK_DISTORTION_TYPE_SIMPLENOISE");
                        matInstance.DisableKeyword("_MASK_DISTORTION_TYPE_VORONOI");

                        switch ((int)_MaskDistortionType.floatValue)
                        {
                            case 0:
                                matInstance.EnableKeyword("_MASK_DISTORTION_TYPE_TEXTURE2D");
                                break;
                            case 1:
                                matInstance.EnableKeyword("_MASK_DISTORTION_TYPE_GRADIENTNOISE");
                                break;
                            case 2:
                                matInstance.EnableKeyword("_MASK_DISTORTION_TYPE_SIMPLENOISE");
                                break;
                            case 3:
                                matInstance.EnableKeyword("_MASK_DISTORTION_TYPE_VORONOI");
                                break;
                        }

                        EditorUtility.SetDirty(matInstance);
                    }
                }
                    
                if (_MaskDistortionType != null)
                {
                    int type = (int)_MaskDistortionType.floatValue;
                    switch (type)
                    {
                        case 0: // Texture2D
                            DrawIfValid(materialEditor, _MaskDistortionTex);
                            break;
                        case 1: // GradientNoise
                        case 2: // SimpleNoise
                            DrawIfValid(materialEditor, _MaskDistortionScale);
                            break;
                        case 3: // Voronoi
                            DrawIfValid(materialEditor, _MaskDistortionScale);
                            DrawIfValid(materialEditor, _MaskAngleOffset);
                            break;
                    }
                    
                    DrawIfValid(materialEditor, _MaskDistortionAmount);
                    DrawIfValid(materialEditor, _MaskDistortionScrollX);
                    DrawIfValid(materialEditor, _MaskDistortionScrollY);
                    DrawIfValid(materialEditor, _MaskDistortionRotation);                    
                }
            }

            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndVertical();
        }   
           
        

        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DISSOLVE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        EditorGUILayout.BeginHorizontal("button");
        bool dissolveEnabled = _UseDissolve.floatValue == 1f;
        dissolveEnabled = GUILayout.Toggle(dissolveEnabled,"",GUILayout.MaxWidth(17));
        _UseDissolve.floatValue = dissolveEnabled ? 1f : 0f;

        if(GUILayout.Button("Dissolve", EditorStyles.boldLabel))
        {
            dissolveOpen = !dissolveOpen;
            EditorPrefs.SetBool( DISSOLVE_KEY + matName, dissolveOpen);
        }
        GUILayout.EndHorizontal();

        if (dissolveOpen)
        {
            EditorGUILayout.BeginVertical("box");
            bool enabled = _UseDissolve != null && _UseDissolve.floatValue == 1f;
            EditorGUI.BeginDisabledGroup(!enabled);

            DrawIfValid(materialEditor, _InvertDissolve);
            DrawIfValid(materialEditor, _DissolveTex);
            DrawIfValid(materialEditor, _DissolveAmount);
            DrawIfValid(materialEditor, _EdgeWidth);

            if (_UseDissolveOverLife != null)
                materialEditor.ShaderProperty(_UseDissolveOverLife, _UseDissolveOverLife.displayName);
            if (_UseDissolveOverLife != null && _UseDissolveOverLife.floatValue == 1)
                DrawIfValid(materialEditor, _DissolveSpeed);

            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndVertical();
        }

        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ DEPTH FADE ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        
        EditorGUILayout.BeginHorizontal("button");
        bool depthfadeEnabled = _UseDepthFade.floatValue == 1f;
        depthfadeEnabled = GUILayout.Toggle(depthfadeEnabled,"",GUILayout.MaxWidth(17));
        _UseDepthFade.floatValue = depthfadeEnabled ? 1f : 0f;

        if(GUILayout.Button("Depth Fade", EditorStyles.boldLabel))
        {
            depthOpen = !depthOpen;
            EditorPrefs.SetBool( DEPTH_KEY + matName, depthOpen);
        }
        GUILayout.EndHorizontal();

        if (depthOpen)
        {
            EditorGUILayout.BeginVertical("box");
            bool enabled = _UseDepthFade != null && _UseDepthFade.floatValue == 1f;
            EditorGUI.BeginDisabledGroup(!enabled);

            DrawIfValid(materialEditor, _DepthFadeAmount);

            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndVertical();
        }

        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ FRESNEL ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        EditorGUILayout.BeginHorizontal("button");
        bool fresnelEnabled = _Fresnel.floatValue == 1f;
        fresnelEnabled = GUILayout.Toggle(fresnelEnabled,"",GUILayout.MaxWidth(17));
        _Fresnel.floatValue = fresnelEnabled ? 1f : 0f;

        if(GUILayout.Button("Fresnel", EditorStyles.boldLabel))
        {
            fresnelOpen = !fresnelOpen;
            EditorPrefs.SetBool( FRESNEL_KEY + matName, fresnelOpen);
        }
        GUILayout.EndHorizontal();

        if (fresnelOpen)
        {
            EditorGUILayout.BeginVertical("box");
            bool enabled = _Fresnel != null && _Fresnel.floatValue == 1f;
            EditorGUI.BeginDisabledGroup(!enabled);

            DrawIfValid(materialEditor, _InvertFresnel);
            DrawIfValid(materialEditor, _FresnelPower);
            DrawIfValid(materialEditor, _Edge1);
            DrawIfValid(materialEditor, _Edge2);

            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndVertical();
        }
        
        // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ SHADER PROPERTIES ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

        DrawIfValid(materialEditor, _Cull);

    }

    void DrawIfValid(MaterialEditor editor, MaterialProperty prop) 
    { 
        if (prop != null) 
        editor.ShaderProperty(prop, prop.displayName); 
        
    }

}
