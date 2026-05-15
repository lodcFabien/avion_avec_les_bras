Shader "NatureManufacture/URP/Foliage/Cross 2 WS"
{
    Properties
    {
        [NoScaleOffset]_Mask("Backface (R) Leaves (G) Trunk (B) Thickness Map (A)", 2D) = "white" {}
        _AlphaCutoff("Alpha Cutoff", Float) = 0.5
        [NoScaleOffset]_BaseColorMap("Base Map", 2D) = "white" {}
        _TilingOffset("Tiling and Offset", Vector) = (1, 1, 0, 0)
        _TrunkBaseColor("Trunk Base Color", Color) = (1, 1, 1, 0)
        _BarkBaseColor("Bark Base Color", Color) = (1, 1, 1, 0)
        _Global_Base_Brightness("Global Base Brightness", Range(0, 2)) = 1
        _HealthyColor("Healthy Color", Color) = (1, 1, 1, 0)
        _DryColor("Dry Color", Color) = (0.8196079, 0.8196079, 0.8196079, 0)
        _ColorNoiseTilling("Healthy and Dry Color Noise Tilling", Float) = 2
        _HealthyandDryColorNoisePower("Healthy and Dry Color Noise Power", Range(0.01, 10)) = 1
        _Cross_Backface_Mask_Power("Cross Backface Mask Power", Range(0, 3)) = 1
        _Backface_Saturation("Backface Saturation", Range(0, 2)) = 1
        _Backface_Brightness("Backface Brightness", Range(-1, 1)) = 0
        _Backface_Thickness_Mask_Remap("Backface Thickness Mask Remap", Vector) = (0.01, 1, 0, 0)
        _Backface_Thickness_Mask_Threshold("Backface Thickness Mask Threshold", Range(0.01, 1)) = 1
        [Normal][NoScaleOffset]_NormalMap("Normal Map", 2D) = "bump" {}
        _NormalScale("Leaves Normal Scale", Range(0, 10)) = 6
        _Trunk_Normal_Scale("Trunk Normal Scale", Range(0, 5)) = 1
        _MeshNormalMultiply("3D Mesh Normal Multiply", Vector) = (1, 1, 1, 0)
        _AORemapMax("AO Remap Max", Range(0, 1)) = 1
        _SmoothnessRemapMax("Leaves Smoothness Remap Max", Range(0, 1)) = 1
        _Trunk_Smoothness_Remap_Max("Trunk Smoothness Remap Max", Range(0, 1)) = 1
        _Leaves_Specular("Leaves Specular", Color) = (0.03921569, 0.03921569, 0.07843129, 0)
        _Trunk_Specular("Trunk Specular", Color) = (0, 0, 0, 0)
        _Trunk_Metallic("Trunk Metallic", Range(0, 1)) = 0
        _Leaves_Metallic("Leaves Metallic", Range(0, 1)) = 0
        [Toggle(_USE_TRANSLUCENCY)]_USE_TRANSLUCENCY("Use Translucency", Float) = 1
        _ThicknessRemapMin("Thickness Remap Min", Float) = 0
        _ThicknessRemapMax("Thickness Remap Max", Float) = 1
        _Thickness("Thickness", Range(0, 1)) = 1
        _Translucency_Color("Translucency Color", Color) = (1, 1, 1, 0)
        _Translucency_Intensivity("Translucency Leaves Intensivity", Range(0, 100)) = 0
        _Translucency_Intensivity_1("Translucency Trunk Intensivity", Range(0, 100)) = 0
        _Translucency_Shadow_Reduction("Translucency Shadow Reduction", Range(0, 1)) = 0
        _Translucency_Self_Shadow_Reduction("Translucency Self Shadow Reduction", Range(0, 1)) = 1
        _Translucency_Self_Shadow_Reduction_Smooth("Translucency Self Shadow Reduction Smooth", Range(0, 1)) = 1
        [HideInInspector]_WorkflowMode("_WorkflowMode", Float) = 0
        [HideInInspector]_CastShadows("_CastShadows", Float) = 1
        [HideInInspector]_ReceiveShadows("_ReceiveShadows", Float) = 1
        [HideInInspector]_Surface("_Surface", Float) = 0
        [HideInInspector]_Blend("_Blend", Float) = 0
        [HideInInspector]_AlphaClip("_AlphaClip", Float) = 1
        [HideInInspector]_BlendModePreserveSpecular("_BlendModePreserveSpecular", Float) = 1
        [HideInInspector]_SrcBlend("_SrcBlend", Float) = 1
        [HideInInspector]_DstBlend("_DstBlend", Float) = 0
        [HideInInspector][ToggleUI]_ZWrite("_ZWrite", Float) = 1
        [HideInInspector]_ZWriteControl("_ZWriteControl", Float) = 0
        [HideInInspector]_ZTest("_ZTest", Float) = 4
        [HideInInspector]_Cull("_Cull", Float) = 2
        [HideInInspector]_AlphaToMask("_AlphaToMask", Float) = 1
        [HideInInspector]_QueueOffset("_QueueOffset", Float) = 0
        [HideInInspector]_QueueControl("_QueueControl", Float) = -1
        [HideInInspector][NoScaleOffset]unity_Lightmaps("unity_Lightmaps", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_LightmapsInd("unity_LightmapsInd", 2DArray) = "" {}
        [HideInInspector][NoScaleOffset]unity_ShadowMasks("unity_ShadowMasks", 2DArray) = "" {}
    }
    SubShader
    {
        Tags
        {
            "RenderPipeline"="UniversalPipeline"
            "RenderType"="Opaque"
            "UniversalMaterialType" = "Lit"
            "Queue"="AlphaTest"
            "DisableBatching"="LODFading"
            "ShaderGraphShader"="true"
            "ShaderGraphTargetId"="UniversalLitSubTarget"
        }
        Pass
        {
            Name "Universal Forward"
            Tags
            {
                "LightMode" = "UniversalForward"
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]
        ZWrite [_ZWrite]
        AlphaToMask [_AlphaToMask]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ USE_LEGACY_LIGHTMAPS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile _ _ADDITIONAL_LIGHTS_VERTEX _ADDITIONAL_LIGHTS
        #pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _LIGHT_LAYERS
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma multi_compile_fragment _ _LIGHT_COOKIES
        #pragma multi_compile _ _FORWARD_PLUS
        #pragma multi_compile _ EVALUATE_SH_MIXED EVALUATE_SH_VERTEX
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHAMODULATE_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local_fragment _ _SPECULAR_SETUP
        #pragma shader_feature_local _ _RECEIVE_SHADOWS_OFF
        #pragma multi_compile _ LOD_FADE_CROSSFADE
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        #pragma shader_feature _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma shader_feature _ _SHADOWS_SOFT
        #pragma shader_feature _ _ADDITIONAL_LIGHT
        #pragma shader_feature _ _MAIN_LIGHT_SHADOW
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_SHADOW_COORD
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_FORWARD
        #define _FOG_FRAGMENT 1
        #define USE_UNITY_CROSSFADE 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 staticLightmapUV;
            #endif
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 dynamicLightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 sh;
            #endif
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 probeOcclusion;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 fogFactorAndVertexLight;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 shadowCoord;
            #endif
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float FaceSign;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 staticLightmapUV : INTERP0;
            #endif
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 dynamicLightmapUV : INTERP1;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 sh : INTERP2;
            #endif
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 probeOcclusion : INTERP3;
            #endif
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 shadowCoord : INTERP4;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS : INTERP5;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP6;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 fogFactorAndVertexLight : INTERP7;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS : INTERP8;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS : INTERP9;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            output.probeOcclusion = input.probeOcclusion;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            output.probeOcclusion = input.probeOcclusion;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Hashes.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        float Unity_SimpleNoise_ValueNoise_LegacySine_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0; Hash_LegacySine_2_1_float(c0, r0);
            float r1; Hash_LegacySine_2_1_float(c1, r1);
            float r2; Hash_LegacySine_2_1_float(c2, r2);
            float r3; Hash_LegacySine_2_1_float(c3, r3);
            float bottomOfGrid = lerp(r0, r1, f.x);
            float topOfGrid = lerp(r2, r3, f.x);
            float t = lerp(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        
        void Unity_SimpleNoise_LegacySine_float(float2 UV, float Scale, out float Out)
        {
            float freq, amp;
            Out = 0.0f;
            freq = pow(2.0, float(0));
            amp = pow(0.5, float(3-0));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Saturation_float(float3 In, float Saturation, out float3 Out)
        {
            float luma = dot(In, float3(0.2126729, 0.7151522, 0.0721750));
            Out =  luma.xxx + Saturation.xxx * (In - luma.xxx);
        }
        
        void Unity_Blend_Screen_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = 1.0 - (1.0 - Blend) * (1.0 - Base);
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_Clamp_float3(float3 In, float3 Min, float3 Max, out float3 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void MainLightDirection_float(out float3 Direction)
        {
            #if SHADERGRAPH_PREVIEW
            Direction = half3(-0.5, -0.5, 0);
            #else
            Direction = SHADERGRAPH_MAIN_LIGHT_DIRECTION();
            #endif
        }
        
        // unity-custom-func-begin
        void GetLightData_float(float3 positionWS, out float3 lightDir, out float3 color, out float distanceAttenuation, out float shadowAttenuation){
        color = float3(0, 0, 0);
        distanceAttenuation = 0;
        shadowAttenuation =  0;
        #ifdef SHADERGRAPH_PREVIEW
        
            lightDir = float3(0.707, 0.707, 0);
        
            color = 128000;
            distanceAttenuation = 0;
            shadowAttenuation =  0;
        
        #else
        
          
        
        
        
                Light mainLight = GetMainLight(TransformWorldToShadowCoord(positionWS));
        
                lightDir = -mainLight.direction;
        
                color = mainLight.color;
               distanceAttenuation = mainLight.distanceAttenuation;
               shadowAttenuation =  mainLight.shadowAttenuation;
                
        
          
        
        #endif
        }
        // unity-custom-func-end
        
        struct Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float
        {
        float3 AbsoluteWorldSpacePosition;
        };
        
        void SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float IN, out float3 Direction_1, out float3 Color_2, out float distanceAttenuation_3, out float shadowAttenuation_4)
        {
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3;
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        GetLightData_float(IN.AbsoluteWorldSpacePosition, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float);
        float3 _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, float3(-1, -1, -1), float3(1, 1, 1), _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3);
        float3 _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, float3(0.01, 0.01, 0.01), float3(1000000, 100000, 100000), _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3);
        Direction_1 = _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Color_2 = _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        distanceAttenuation_3 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        shadowAttenuation_4 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
        Out = A * B;
        }
        
        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_MatrixConstruction_Row_float (float4 M0, float4 M1, float4 M2, float4 M3, out float4x4 Out4x4, out float3x3 Out3x3, out float2x2 Out2x2)
        {
        Out4x4 = float4x4(M0.x, M0.y, M0.z, M0.w, M1.x, M1.y, M1.z, M1.w, M2.x, M2.y, M2.z, M2.w, M3.x, M3.y, M3.z, M3.w);
        Out3x3 = float3x3(M0.x, M0.y, M0.z, M1.x, M1.y, M1.z, M2.x, M2.y, M2.z);
        Out2x2 = float2x2(M0.x, M0.y, M1.x, M1.y);
        }
        
        void Unity_Multiply_float3_float3x3(float3 A, float3x3 B, out float3 Out)
        {
        Out = mul(A, B);
        }
        
        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }
        
        void Unity_Negate_float(float In, out float Out)
        {
            Out = -1 * In;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        struct Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float
        {
        float3 WorldSpaceNormal;
        float3 WorldSpaceTangent;
        float3 WorldSpaceBiTangent;
        float3 AbsoluteWorldSpacePosition;
        float FaceSign;
        };
        
        void SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(float3 _Albedo_Map, float _Translucency_Intensivity, float4 _Translucency_Color, float3 _NormalMap, float _Thickness_Map, float _Thickness, float _Thickness_Remap_Min, float _Thickness_Remap_Max, float _Shadow_Reduction, float _Self_Shadow_Reduction_Smooth, float _Self_Shadow_Reduction, float3 _Main_Lght_Direction, Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float IN, out float3 Out_Vector4_1, out float Light_Direction_2, out float Mesh_Normal_3)
        {
        float _Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float = _Translucency_Intensivity;
        float3 _Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3 = _Albedo_Map;
        float4 _Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4 = _Translucency_Color;
        Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float _LightDataURP_18a0698558bb40bcadea0e6e303e48db;
        _LightDataURP_18a0698558bb40bcadea0e6e303e48db.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float;
        SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float);
        float _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float = _Shadow_Reduction;
        float _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float;
        Unity_Add_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float, _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float, _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float);
        float _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float;
        Unity_Clamp_float(_Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float, float(0), float(1), _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float);
        float _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float;
        Unity_Multiply_float_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float, _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float);
        float4 _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4;
        Unity_Multiply_float4_float4(_Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4, (_Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float.xxxx), _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4);
        float3 _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3;
        Unity_Multiply_float3_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, (_Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float.xxx), _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3);
        float3 _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3, _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3);
        float3 _Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3 = _NormalMap;
        float _IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean = max(0, IN.FaceSign.x);
        float3 _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3;
        Unity_Multiply_float3_float3(IN.WorldSpaceNormal, float3(-1, -1, -1), _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3);
        float3 _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3;
        Unity_Branch_float3(_IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean, IN.WorldSpaceNormal, _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3, _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3);
        float4x4 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4;
        float3x3 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3;
        float2x2 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2;
        Unity_MatrixConstruction_Row_float((float4(IN.WorldSpaceTangent, 1.0)), (float4(IN.WorldSpaceBiTangent, 1.0)), (float4(_Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3, 1.0)), float4 (0, 0, 0, 0), _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2);
        float3 _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3;
        Unity_Multiply_float3_float3x3(_Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3);
        float3 _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3);
        float _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float;
        Unity_DotProduct_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3, _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float);
        float _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float = _Self_Shadow_Reduction;
        float _Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float = _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float;
        float _Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float = _Self_Shadow_Reduction_Smooth;
        float _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float;
        Unity_Negate_float(_Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float, _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float);
        float3 _Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3 = _Main_Lght_Direction;
        float _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float;
        Unity_DotProduct_float3(_Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float);
        float _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float;
        Unity_Smoothstep_float(_Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float, float(1), _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float, _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float);
        float _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float;
        Unity_Saturate_float(_Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float);
        float _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float;
        Unity_Multiply_float_float(_Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float);
        float _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float;
        Unity_Add_float(_DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float, _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float);
        float _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float;
        Unity_Saturate_float(_Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float, _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float);
        float _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Unity_Absolute_float(_Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float, _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float);
        float _Property_31bac462a2614697a42f18be112dd99d_Out_0_Float = _Thickness;
        float _Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float = _Thickness_Map;
        float _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float;
        Unity_OneMinus_float(_Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float, _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float);
        float _Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float = _Thickness_Remap_Min;
        float _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float = _Thickness_Remap_Max;
        float2 _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2 = float2(_Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float, _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float);
        float _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float;
        Unity_Remap_float(_OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float, float2 (0, 1), _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float);
        float _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float;
        Unity_Multiply_float_float(_Property_31bac462a2614697a42f18be112dd99d_Out_0_Float, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float, _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float);
        float _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float;
        Unity_Clamp_float(_Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float, float(0.001), float(1), _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float);
        float _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float;
        Unity_Power_float(_Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float, _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float, _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float);
        float3 _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3, (_Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float.xxx), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3);
        float3 _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4.xyz), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3, _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3);
        float3 _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3;
        Unity_Clamp_float3(_Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3);
        float3 _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3, _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3, _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3);
        float3 _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float.xxx), _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3, _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3);
        Out_Vector4_1 = _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Light_Direction_2 = _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Mesh_Normal_3 = (_Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3).x;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float3 Specular;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4 = _BarkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4, _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4 = _TrunkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Mask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.r;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.g;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.b;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4;
            Unity_Lerp_float4(_Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float.xxxx), _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4 = _DryColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4 = _HealthyColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_99caf98864a9e980997a02cedd282dd0_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_99caf98864a9e980997a02cedd282dd0_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_99caf98864a9e980997a02cedd282dd0_A_4_Float = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2 = float2(_Split_99caf98864a9e980997a02cedd282dd0_R_1_Float, _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float = _ColorNoiseTilling;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float;
            Unity_SimpleNoise_LegacySine_float(_Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2, _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float, _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float;
            Unity_Absolute_float(_SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float, _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float = _HealthyandDryColorNoisePower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float;
            Unity_Power_float(_Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float, _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float, _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float;
            Unity_Clamp_float(_Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float, float(0), float(1), _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4;
            Unity_Lerp_float4(_Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4, _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4, (_Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float.xxxx), _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4, _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_a52cc4db448642208842be98e18796fb_Out_0_Float = _Backface_Saturation;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3;
            Unity_Saturation_float((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Property_a52cc4db448642208842be98e18796fb_Out_0_Float, _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_547f6c365f204d14a383183448811966_Out_0_Float = _Backface_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3;
            Unity_Blend_Screen_float3(_Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3, (_Property_547f6c365f204d14a383183448811966_Out_0_Float.xxx), _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float(1));
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3;
            Unity_Clamp_float3(_Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2 = _Backface_Thickness_Mask_Remap;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float;
            Unity_Remap_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, float2 (0, 1), _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2, _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float;
            Unity_Clamp_float(_Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float, float(0), float(1), _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float = _Backface_Thickness_Mask_Threshold;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float;
            Unity_Power_float(_Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float, _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float, _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float;
            Unity_Clamp_float(_Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float, float(0), float(1), _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float;
            Unity_OneMinus_float(_Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float, _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3;
            Unity_Lerp_float3((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3, (_OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float.xxx), _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float;
            Unity_Absolute_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float, _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float = _Cross_Backface_Mask_Power;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float;
            Unity_Power_float(_Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float, _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float, _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float;
            Unity_Clamp_float(_Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float, float(0), float(1), _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3;
            Unity_Lerp_float3(_Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3, (_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), (_Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float.xxx), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3;
            Unity_Lerp_float3((_Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4.xyz), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float.xxx), _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float = _Global_Base_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3, (_Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float.xxx), _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            Unity_Clamp_float3(_Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float = _Translucency_Intensivity_1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float = _Translucency_Intensivity;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float;
            Unity_Lerp_float(_Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float, _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4 = _Translucency_Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4);
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_R_4_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.r;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_G_5_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.g;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_B_6_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.b;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_A_7_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float = _Trunk_Normal_Scale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float = _NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float;
            Unity_Lerp_float(_Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float, _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            Unity_NormalStrength_float((_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.xyz), _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float = _ThicknessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float = _ThicknessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float = _Translucency_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float = _Translucency_Self_Shadow_Reduction_Smooth;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float = _Translucency_Self_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3;
            MainLightDirection_float(_MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float _URPTranslucency_1984a38cc4724c849f275126c28b8205;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceNormal = IN.WorldSpaceNormal;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceTangent = IN.WorldSpaceTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.FaceSign = IN.FaceSign;
            float3 _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float;
            SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float, _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float, _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float, _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float, _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float, _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float, _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float, _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float, _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            Unity_Add_float3(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USE_TRANSLUCENCY)
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            #else
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c6c3d685f67147a9b84e1a1946ae28d5_Out_0_Float = _Trunk_Metallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_233f3cd6af114a68a2de4c2d54bc7975_Out_0_Float = _Leaves_Metallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_5b344b20b9c449d28ec9041d374043db_Out_3_Float;
            Unity_Lerp_float(_Property_c6c3d685f67147a9b84e1a1946ae28d5_Out_0_Float, _Property_233f3cd6af114a68a2de4c2d54bc7975_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_5b344b20b9c449d28ec9041d374043db_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_ea6a8984d2894e7ba96cfdd016f4489d_Out_0_Vector4 = _Trunk_Specular;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_943fee20617e476ba4261d4d9be42bbf_Out_0_Vector4 = _Leaves_Specular;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_6b513f146d3e4900a0a12f15afd2841a_Out_3_Vector4;
            Unity_Lerp_float4(_Property_ea6a8984d2894e7ba96cfdd016f4489d_Out_0_Vector4, _Property_943fee20617e476ba4261d4d9be42bbf_Out_0_Vector4, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float.xxxx), _Lerp_6b513f146d3e4900a0a12f15afd2841a_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c35305c7157c4d3ba1db4ba61b2e2ebc_Out_0_Float = _Trunk_Smoothness_Remap_Max;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0edea7916ed7a189a62b0faf2c274601_Out_0_Float = _SmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_bfff2d3ace4b4da580b3543a67649ae1_Out_3_Float;
            Unity_Lerp_float(_Property_c35305c7157c4d3ba1db4ba61b2e2ebc_Out_0_Float, _Property_0edea7916ed7a189a62b0faf2c274601_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_bfff2d3ace4b4da580b3543a67649ae1_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_48e1c5285b48c78e8af19e38f4bd77f9_Out_0_Float = _AORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.BaseColor = _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3;
            surface.NormalTS = _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Lerp_5b344b20b9c449d28ec9041d374043db_Out_3_Float;
            surface.Specular = (_Lerp_6b513f146d3e4900a0a12f15afd2841a_Out_3_Vector4.xyz);
            surface.Smoothness = _Lerp_bfff2d3ace4b4da580b3543a67649ae1_Out_3_Float;
            surface.Occlusion = _Property_48e1c5285b48c78e8af19e38f4bd77f9_Out_0_Float;
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0)* GetOddNegativeScale();
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to pr               eserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This                is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent = renormFactor * bitang;
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition = GetAbsolutePositionWS(input.positionWS);
        #endif
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRForwardPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "GBuffer"
            Tags
            {
                "LightMode" = "UniversalGBuffer"
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]
        ZWrite [_ZWrite]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 4.5
        #pragma exclude_renderers gles3 glcore
        #pragma multi_compile_instancing
        #pragma multi_compile_fog
        #pragma instancing_options renderinglayer
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile _ LIGHTMAP_ON
        #pragma multi_compile _ DYNAMICLIGHTMAP_ON
        #pragma multi_compile _ DIRLIGHTMAP_COMBINED
        #pragma multi_compile _ USE_LEGACY_LIGHTMAPS
        #pragma multi_compile _ _MAIN_LIGHT_SHADOWS _MAIN_LIGHT_SHADOWS_CASCADE _MAIN_LIGHT_SHADOWS_SCREEN
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BLENDING
        #pragma multi_compile_fragment _ _REFLECTION_PROBE_BOX_PROJECTION
        #pragma multi_compile_fragment _ _SHADOWS_SOFT _SHADOWS_SOFT_LOW _SHADOWS_SOFT_MEDIUM _SHADOWS_SOFT_HIGH
        #pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
        #pragma multi_compile _ SHADOWS_SHADOWMASK
        #pragma multi_compile _ _MIXED_LIGHTING_SUBTRACTIVE
        #pragma multi_compile_fragment _ _DBUFFER_MRT1 _DBUFFER_MRT2 _DBUFFER_MRT3
        #pragma multi_compile_fragment _ _GBUFFER_NORMALS_OCT
        #pragma multi_compile_fragment _ _RENDER_PASS_ENABLED
        #pragma multi_compile_fragment _ DEBUG_DISPLAY
        #pragma shader_feature_fragment _ _SURFACE_TYPE_TRANSPARENT
        #pragma shader_feature_local_fragment _ _ALPHAPREMULTIPLY_ON
        #pragma shader_feature_local_fragment _ _ALPHAMODULATE_ON
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local_fragment _ _SPECULAR_SETUP
        #pragma shader_feature_local _ _RECEIVE_SHADOWS_OFF
        #pragma multi_compile _ LOD_FADE_CROSSFADE
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        #pragma shader_feature _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma shader_feature _ _SHADOWS_SOFT
        #pragma shader_feature _ _ADDITIONAL_LIGHT
        #pragma shader_feature _ _MAIN_LIGHT_SHADOW
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_FOG_AND_VERTEX_LIGHT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_SHADOW_COORD
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_GBUFFER
        #define _FOG_FRAGMENT 1
        #define USE_UNITY_CROSSFADE 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ProbeVolumeVariants.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 staticLightmapUV;
            #endif
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 dynamicLightmapUV;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 sh;
            #endif
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 probeOcclusion;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 fogFactorAndVertexLight;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 shadowCoord;
            #endif
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float FaceSign;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 staticLightmapUV : INTERP0;
            #endif
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float2 dynamicLightmapUV : INTERP1;
            #endif
            #endif
            #if !defined(LIGHTMAP_ON)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 sh : INTERP2;
            #endif
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 probeOcclusion : INTERP3;
            #endif
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 shadowCoord : INTERP4;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS : INTERP5;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP6;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 fogFactorAndVertexLight : INTERP7;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS : INTERP8;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS : INTERP9;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            output.probeOcclusion = input.probeOcclusion;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.fogFactorAndVertexLight.xyzw = input.fogFactorAndVertexLight;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            #if defined(LIGHTMAP_ON)
            output.staticLightmapUV = input.staticLightmapUV;
            #endif
            #if defined(DYNAMICLIGHTMAP_ON)
            output.dynamicLightmapUV = input.dynamicLightmapUV;
            #endif
            #if !defined(LIGHTMAP_ON)
            output.sh = input.sh;
            #endif
            #if defined(USE_APV_PROBE_OCCLUSION)
            output.probeOcclusion = input.probeOcclusion;
            #endif
            #if defined(REQUIRES_VERTEX_SHADOW_COORD_INTERPOLATOR)
            output.shadowCoord = input.shadowCoord;
            #endif
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.fogFactorAndVertexLight = input.fogFactorAndVertexLight.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Hashes.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        float Unity_SimpleNoise_ValueNoise_LegacySine_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0; Hash_LegacySine_2_1_float(c0, r0);
            float r1; Hash_LegacySine_2_1_float(c1, r1);
            float r2; Hash_LegacySine_2_1_float(c2, r2);
            float r3; Hash_LegacySine_2_1_float(c3, r3);
            float bottomOfGrid = lerp(r0, r1, f.x);
            float topOfGrid = lerp(r2, r3, f.x);
            float t = lerp(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        
        void Unity_SimpleNoise_LegacySine_float(float2 UV, float Scale, out float Out)
        {
            float freq, amp;
            Out = 0.0f;
            freq = pow(2.0, float(0));
            amp = pow(0.5, float(3-0));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Saturation_float(float3 In, float Saturation, out float3 Out)
        {
            float luma = dot(In, float3(0.2126729, 0.7151522, 0.0721750));
            Out =  luma.xxx + Saturation.xxx * (In - luma.xxx);
        }
        
        void Unity_Blend_Screen_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = 1.0 - (1.0 - Blend) * (1.0 - Base);
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_Clamp_float3(float3 In, float3 Min, float3 Max, out float3 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void MainLightDirection_float(out float3 Direction)
        {
            #if SHADERGRAPH_PREVIEW
            Direction = half3(-0.5, -0.5, 0);
            #else
            Direction = SHADERGRAPH_MAIN_LIGHT_DIRECTION();
            #endif
        }
        
        // unity-custom-func-begin
        void GetLightData_float(float3 positionWS, out float3 lightDir, out float3 color, out float distanceAttenuation, out float shadowAttenuation){
        color = float3(0, 0, 0);
        distanceAttenuation = 0;
        shadowAttenuation =  0;
        #ifdef SHADERGRAPH_PREVIEW
        
            lightDir = float3(0.707, 0.707, 0);
        
            color = 128000;
            distanceAttenuation = 0;
            shadowAttenuation =  0;
        
        #else
        
          
        
        
        
                Light mainLight = GetMainLight(TransformWorldToShadowCoord(positionWS));
        
                lightDir = -mainLight.direction;
        
                color = mainLight.color;
               distanceAttenuation = mainLight.distanceAttenuation;
               shadowAttenuation =  mainLight.shadowAttenuation;
                
        
          
        
        #endif
        }
        // unity-custom-func-end
        
        struct Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float
        {
        float3 AbsoluteWorldSpacePosition;
        };
        
        void SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float IN, out float3 Direction_1, out float3 Color_2, out float distanceAttenuation_3, out float shadowAttenuation_4)
        {
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3;
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        GetLightData_float(IN.AbsoluteWorldSpacePosition, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float);
        float3 _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, float3(-1, -1, -1), float3(1, 1, 1), _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3);
        float3 _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, float3(0.01, 0.01, 0.01), float3(1000000, 100000, 100000), _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3);
        Direction_1 = _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Color_2 = _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        distanceAttenuation_3 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        shadowAttenuation_4 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
        Out = A * B;
        }
        
        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_MatrixConstruction_Row_float (float4 M0, float4 M1, float4 M2, float4 M3, out float4x4 Out4x4, out float3x3 Out3x3, out float2x2 Out2x2)
        {
        Out4x4 = float4x4(M0.x, M0.y, M0.z, M0.w, M1.x, M1.y, M1.z, M1.w, M2.x, M2.y, M2.z, M2.w, M3.x, M3.y, M3.z, M3.w);
        Out3x3 = float3x3(M0.x, M0.y, M0.z, M1.x, M1.y, M1.z, M2.x, M2.y, M2.z);
        Out2x2 = float2x2(M0.x, M0.y, M1.x, M1.y);
        }
        
        void Unity_Multiply_float3_float3x3(float3 A, float3x3 B, out float3 Out)
        {
        Out = mul(A, B);
        }
        
        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }
        
        void Unity_Negate_float(float In, out float Out)
        {
            Out = -1 * In;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        struct Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float
        {
        float3 WorldSpaceNormal;
        float3 WorldSpaceTangent;
        float3 WorldSpaceBiTangent;
        float3 AbsoluteWorldSpacePosition;
        float FaceSign;
        };
        
        void SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(float3 _Albedo_Map, float _Translucency_Intensivity, float4 _Translucency_Color, float3 _NormalMap, float _Thickness_Map, float _Thickness, float _Thickness_Remap_Min, float _Thickness_Remap_Max, float _Shadow_Reduction, float _Self_Shadow_Reduction_Smooth, float _Self_Shadow_Reduction, float3 _Main_Lght_Direction, Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float IN, out float3 Out_Vector4_1, out float Light_Direction_2, out float Mesh_Normal_3)
        {
        float _Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float = _Translucency_Intensivity;
        float3 _Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3 = _Albedo_Map;
        float4 _Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4 = _Translucency_Color;
        Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float _LightDataURP_18a0698558bb40bcadea0e6e303e48db;
        _LightDataURP_18a0698558bb40bcadea0e6e303e48db.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float;
        SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float);
        float _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float = _Shadow_Reduction;
        float _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float;
        Unity_Add_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float, _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float, _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float);
        float _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float;
        Unity_Clamp_float(_Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float, float(0), float(1), _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float);
        float _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float;
        Unity_Multiply_float_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float, _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float);
        float4 _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4;
        Unity_Multiply_float4_float4(_Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4, (_Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float.xxxx), _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4);
        float3 _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3;
        Unity_Multiply_float3_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, (_Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float.xxx), _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3);
        float3 _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3, _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3);
        float3 _Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3 = _NormalMap;
        float _IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean = max(0, IN.FaceSign.x);
        float3 _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3;
        Unity_Multiply_float3_float3(IN.WorldSpaceNormal, float3(-1, -1, -1), _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3);
        float3 _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3;
        Unity_Branch_float3(_IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean, IN.WorldSpaceNormal, _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3, _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3);
        float4x4 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4;
        float3x3 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3;
        float2x2 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2;
        Unity_MatrixConstruction_Row_float((float4(IN.WorldSpaceTangent, 1.0)), (float4(IN.WorldSpaceBiTangent, 1.0)), (float4(_Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3, 1.0)), float4 (0, 0, 0, 0), _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2);
        float3 _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3;
        Unity_Multiply_float3_float3x3(_Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3);
        float3 _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3);
        float _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float;
        Unity_DotProduct_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3, _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float);
        float _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float = _Self_Shadow_Reduction;
        float _Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float = _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float;
        float _Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float = _Self_Shadow_Reduction_Smooth;
        float _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float;
        Unity_Negate_float(_Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float, _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float);
        float3 _Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3 = _Main_Lght_Direction;
        float _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float;
        Unity_DotProduct_float3(_Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float);
        float _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float;
        Unity_Smoothstep_float(_Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float, float(1), _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float, _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float);
        float _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float;
        Unity_Saturate_float(_Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float);
        float _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float;
        Unity_Multiply_float_float(_Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float);
        float _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float;
        Unity_Add_float(_DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float, _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float);
        float _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float;
        Unity_Saturate_float(_Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float, _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float);
        float _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Unity_Absolute_float(_Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float, _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float);
        float _Property_31bac462a2614697a42f18be112dd99d_Out_0_Float = _Thickness;
        float _Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float = _Thickness_Map;
        float _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float;
        Unity_OneMinus_float(_Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float, _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float);
        float _Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float = _Thickness_Remap_Min;
        float _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float = _Thickness_Remap_Max;
        float2 _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2 = float2(_Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float, _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float);
        float _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float;
        Unity_Remap_float(_OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float, float2 (0, 1), _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float);
        float _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float;
        Unity_Multiply_float_float(_Property_31bac462a2614697a42f18be112dd99d_Out_0_Float, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float, _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float);
        float _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float;
        Unity_Clamp_float(_Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float, float(0.001), float(1), _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float);
        float _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float;
        Unity_Power_float(_Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float, _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float, _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float);
        float3 _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3, (_Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float.xxx), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3);
        float3 _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4.xyz), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3, _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3);
        float3 _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3;
        Unity_Clamp_float3(_Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3);
        float3 _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3, _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3, _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3);
        float3 _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float.xxx), _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3, _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3);
        Out_Vector4_1 = _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Light_Direction_2 = _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Mesh_Normal_3 = (_Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3).x;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 NormalTS;
            float3 Emission;
            float Metallic;
            float3 Specular;
            float Smoothness;
            float Occlusion;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4 = _BarkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4, _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4 = _TrunkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Mask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.r;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.g;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.b;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4;
            Unity_Lerp_float4(_Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float.xxxx), _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4 = _DryColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4 = _HealthyColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_99caf98864a9e980997a02cedd282dd0_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_99caf98864a9e980997a02cedd282dd0_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_99caf98864a9e980997a02cedd282dd0_A_4_Float = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2 = float2(_Split_99caf98864a9e980997a02cedd282dd0_R_1_Float, _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float = _ColorNoiseTilling;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float;
            Unity_SimpleNoise_LegacySine_float(_Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2, _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float, _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float;
            Unity_Absolute_float(_SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float, _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float = _HealthyandDryColorNoisePower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float;
            Unity_Power_float(_Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float, _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float, _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float;
            Unity_Clamp_float(_Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float, float(0), float(1), _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4;
            Unity_Lerp_float4(_Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4, _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4, (_Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float.xxxx), _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4, _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_a52cc4db448642208842be98e18796fb_Out_0_Float = _Backface_Saturation;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3;
            Unity_Saturation_float((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Property_a52cc4db448642208842be98e18796fb_Out_0_Float, _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_547f6c365f204d14a383183448811966_Out_0_Float = _Backface_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3;
            Unity_Blend_Screen_float3(_Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3, (_Property_547f6c365f204d14a383183448811966_Out_0_Float.xxx), _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float(1));
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3;
            Unity_Clamp_float3(_Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2 = _Backface_Thickness_Mask_Remap;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float;
            Unity_Remap_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, float2 (0, 1), _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2, _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float;
            Unity_Clamp_float(_Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float, float(0), float(1), _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float = _Backface_Thickness_Mask_Threshold;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float;
            Unity_Power_float(_Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float, _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float, _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float;
            Unity_Clamp_float(_Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float, float(0), float(1), _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float;
            Unity_OneMinus_float(_Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float, _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3;
            Unity_Lerp_float3((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3, (_OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float.xxx), _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float;
            Unity_Absolute_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float, _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float = _Cross_Backface_Mask_Power;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float;
            Unity_Power_float(_Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float, _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float, _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float;
            Unity_Clamp_float(_Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float, float(0), float(1), _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3;
            Unity_Lerp_float3(_Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3, (_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), (_Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float.xxx), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3;
            Unity_Lerp_float3((_Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4.xyz), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float.xxx), _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float = _Global_Base_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3, (_Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float.xxx), _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            Unity_Clamp_float3(_Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float = _Translucency_Intensivity_1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float = _Translucency_Intensivity;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float;
            Unity_Lerp_float(_Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float, _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4 = _Translucency_Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4);
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_R_4_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.r;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_G_5_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.g;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_B_6_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.b;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_A_7_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float = _Trunk_Normal_Scale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float = _NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float;
            Unity_Lerp_float(_Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float, _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            Unity_NormalStrength_float((_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.xyz), _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float = _ThicknessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float = _ThicknessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float = _Translucency_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float = _Translucency_Self_Shadow_Reduction_Smooth;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float = _Translucency_Self_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3;
            MainLightDirection_float(_MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float _URPTranslucency_1984a38cc4724c849f275126c28b8205;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceNormal = IN.WorldSpaceNormal;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceTangent = IN.WorldSpaceTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.FaceSign = IN.FaceSign;
            float3 _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float;
            SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float, _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float, _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float, _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float, _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float, _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float, _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float, _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float, _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            Unity_Add_float3(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USE_TRANSLUCENCY)
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            #else
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c6c3d685f67147a9b84e1a1946ae28d5_Out_0_Float = _Trunk_Metallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_233f3cd6af114a68a2de4c2d54bc7975_Out_0_Float = _Leaves_Metallic;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_5b344b20b9c449d28ec9041d374043db_Out_3_Float;
            Unity_Lerp_float(_Property_c6c3d685f67147a9b84e1a1946ae28d5_Out_0_Float, _Property_233f3cd6af114a68a2de4c2d54bc7975_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_5b344b20b9c449d28ec9041d374043db_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_ea6a8984d2894e7ba96cfdd016f4489d_Out_0_Vector4 = _Trunk_Specular;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_943fee20617e476ba4261d4d9be42bbf_Out_0_Vector4 = _Leaves_Specular;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_6b513f146d3e4900a0a12f15afd2841a_Out_3_Vector4;
            Unity_Lerp_float4(_Property_ea6a8984d2894e7ba96cfdd016f4489d_Out_0_Vector4, _Property_943fee20617e476ba4261d4d9be42bbf_Out_0_Vector4, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float.xxxx), _Lerp_6b513f146d3e4900a0a12f15afd2841a_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_c35305c7157c4d3ba1db4ba61b2e2ebc_Out_0_Float = _Trunk_Smoothness_Remap_Max;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0edea7916ed7a189a62b0faf2c274601_Out_0_Float = _SmoothnessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_bfff2d3ace4b4da580b3543a67649ae1_Out_3_Float;
            Unity_Lerp_float(_Property_c35305c7157c4d3ba1db4ba61b2e2ebc_Out_0_Float, _Property_0edea7916ed7a189a62b0faf2c274601_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_bfff2d3ace4b4da580b3543a67649ae1_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_48e1c5285b48c78e8af19e38f4bd77f9_Out_0_Float = _AORemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.BaseColor = _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3;
            surface.NormalTS = _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            surface.Emission = float3(0, 0, 0);
            surface.Metallic = _Lerp_5b344b20b9c449d28ec9041d374043db_Out_3_Float;
            surface.Specular = (_Lerp_6b513f146d3e4900a0a12f15afd2841a_Out_3_Vector4.xyz);
            surface.Smoothness = _Lerp_bfff2d3ace4b4da580b3543a67649ae1_Out_3_Float;
            surface.Occlusion = _Property_48e1c5285b48c78e8af19e38f4bd77f9_Out_0_Float;
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0)* GetOddNegativeScale();
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to pr               eserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This                is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent = renormFactor * bitang;
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition = GetAbsolutePositionWS(input.positionWS);
        #endif
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/UnityGBuffer.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBRGBufferPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ShadowCaster"
            Tags
            {
                "LightMode" = "ShadowCaster"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask 0
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma multi_compile_vertex _ _CASTING_PUNCTUAL_LIGHT_SHADOW
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma multi_compile _ LOD_FADE_CROSSFADE
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_SHADOWCASTER
        #define USE_UNITY_CROSSFADE 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS : INTERP1;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShadowCasterPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "MotionVectors"
            Tags
            {
                "LightMode" = "MotionVectors"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask RG
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 3.5
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma multi_compile _ LOD_FADE_CROSSFADE
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_MOTION_VECTORS
        #define USE_UNITY_CROSSFADE 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            description.Position = IN.ObjectSpacePosition;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/MotionVectorPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthOnly"
            Tags
            {
                "LightMode" = "DepthOnly"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        ColorMask R
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma multi_compile _ LOD_FADE_CROSSFADE
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define USE_UNITY_CROSSFADE 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "DepthNormals"
            Tags
            {
                "LightMode" = "DepthNormals"
            }
        
        // Render State
        Cull [_Cull]
        ZTest LEqual
        ZWrite On
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma multi_compile_instancing
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma multi_compile _ LOD_FADE_CROSSFADE
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHNORMALS
        #define USE_UNITY_CROSSFADE 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/RenderingLayers.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/LODCrossFade.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv1 : TEXCOORD1;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 TangentSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS : INTERP0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS : INTERP2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 NormalTS;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4);
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_R_4_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.r;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_G_5_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.g;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_B_6_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.b;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_A_7_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float = _Trunk_Normal_Scale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float = _NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Mask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.r;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.g;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.b;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float;
            Unity_Lerp_float(_Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float, _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            Unity_NormalStrength_float((_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.xyz), _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.NormalTS = _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.TangentSpaceNormal = float3(0.0f, 0.0f, 1.0f);
        #endif
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/DepthNormalsOnlyPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Meta"
            Tags
            {
                "LightMode" = "Meta"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature _ EDITOR_VISUALIZATION
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        #pragma shader_feature _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma shader_feature _ _SHADOWS_SOFT
        #pragma shader_feature _ _ADDITIONAL_LIGHT
        #pragma shader_feature _ _MAIN_LIGHT_SHADOW
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD2
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_INSTANCEID
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD2
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_META
        #define _FOG_FRAGMENT 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv1 : TEXCOORD1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv2 : TEXCOORD2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord2;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float FaceSign;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS : INTERP0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord1 : INTERP2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord2 : INTERP3;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS : INTERP4;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS : INTERP5;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.texCoord1.xyzw = input.texCoord1;
            output.texCoord2.xyzw = input.texCoord2;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.texCoord1 = input.texCoord1.xyzw;
            output.texCoord2 = input.texCoord2.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Hashes.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        float Unity_SimpleNoise_ValueNoise_LegacySine_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0; Hash_LegacySine_2_1_float(c0, r0);
            float r1; Hash_LegacySine_2_1_float(c1, r1);
            float r2; Hash_LegacySine_2_1_float(c2, r2);
            float r3; Hash_LegacySine_2_1_float(c3, r3);
            float bottomOfGrid = lerp(r0, r1, f.x);
            float topOfGrid = lerp(r2, r3, f.x);
            float t = lerp(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        
        void Unity_SimpleNoise_LegacySine_float(float2 UV, float Scale, out float Out)
        {
            float freq, amp;
            Out = 0.0f;
            freq = pow(2.0, float(0));
            amp = pow(0.5, float(3-0));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Saturation_float(float3 In, float Saturation, out float3 Out)
        {
            float luma = dot(In, float3(0.2126729, 0.7151522, 0.0721750));
            Out =  luma.xxx + Saturation.xxx * (In - luma.xxx);
        }
        
        void Unity_Blend_Screen_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = 1.0 - (1.0 - Blend) * (1.0 - Base);
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_Clamp_float3(float3 In, float3 Min, float3 Max, out float3 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void MainLightDirection_float(out float3 Direction)
        {
            #if SHADERGRAPH_PREVIEW
            Direction = half3(-0.5, -0.5, 0);
            #else
            Direction = SHADERGRAPH_MAIN_LIGHT_DIRECTION();
            #endif
        }
        
        // unity-custom-func-begin
        void GetLightData_float(float3 positionWS, out float3 lightDir, out float3 color, out float distanceAttenuation, out float shadowAttenuation){
        color = float3(0, 0, 0);
        distanceAttenuation = 0;
        shadowAttenuation =  0;
        #ifdef SHADERGRAPH_PREVIEW
        
            lightDir = float3(0.707, 0.707, 0);
        
            color = 128000;
            distanceAttenuation = 0;
            shadowAttenuation =  0;
        
        #else
        
          
        
        
        
                Light mainLight = GetMainLight(TransformWorldToShadowCoord(positionWS));
        
                lightDir = -mainLight.direction;
        
                color = mainLight.color;
               distanceAttenuation = mainLight.distanceAttenuation;
               shadowAttenuation =  mainLight.shadowAttenuation;
                
        
          
        
        #endif
        }
        // unity-custom-func-end
        
        struct Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float
        {
        float3 AbsoluteWorldSpacePosition;
        };
        
        void SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float IN, out float3 Direction_1, out float3 Color_2, out float distanceAttenuation_3, out float shadowAttenuation_4)
        {
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3;
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        GetLightData_float(IN.AbsoluteWorldSpacePosition, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float);
        float3 _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, float3(-1, -1, -1), float3(1, 1, 1), _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3);
        float3 _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, float3(0.01, 0.01, 0.01), float3(1000000, 100000, 100000), _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3);
        Direction_1 = _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Color_2 = _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        distanceAttenuation_3 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        shadowAttenuation_4 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
        Out = A * B;
        }
        
        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_MatrixConstruction_Row_float (float4 M0, float4 M1, float4 M2, float4 M3, out float4x4 Out4x4, out float3x3 Out3x3, out float2x2 Out2x2)
        {
        Out4x4 = float4x4(M0.x, M0.y, M0.z, M0.w, M1.x, M1.y, M1.z, M1.w, M2.x, M2.y, M2.z, M2.w, M3.x, M3.y, M3.z, M3.w);
        Out3x3 = float3x3(M0.x, M0.y, M0.z, M1.x, M1.y, M1.z, M2.x, M2.y, M2.z);
        Out2x2 = float2x2(M0.x, M0.y, M1.x, M1.y);
        }
        
        void Unity_Multiply_float3_float3x3(float3 A, float3x3 B, out float3 Out)
        {
        Out = mul(A, B);
        }
        
        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }
        
        void Unity_Negate_float(float In, out float Out)
        {
            Out = -1 * In;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        struct Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float
        {
        float3 WorldSpaceNormal;
        float3 WorldSpaceTangent;
        float3 WorldSpaceBiTangent;
        float3 AbsoluteWorldSpacePosition;
        float FaceSign;
        };
        
        void SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(float3 _Albedo_Map, float _Translucency_Intensivity, float4 _Translucency_Color, float3 _NormalMap, float _Thickness_Map, float _Thickness, float _Thickness_Remap_Min, float _Thickness_Remap_Max, float _Shadow_Reduction, float _Self_Shadow_Reduction_Smooth, float _Self_Shadow_Reduction, float3 _Main_Lght_Direction, Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float IN, out float3 Out_Vector4_1, out float Light_Direction_2, out float Mesh_Normal_3)
        {
        float _Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float = _Translucency_Intensivity;
        float3 _Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3 = _Albedo_Map;
        float4 _Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4 = _Translucency_Color;
        Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float _LightDataURP_18a0698558bb40bcadea0e6e303e48db;
        _LightDataURP_18a0698558bb40bcadea0e6e303e48db.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float;
        SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float);
        float _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float = _Shadow_Reduction;
        float _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float;
        Unity_Add_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float, _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float, _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float);
        float _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float;
        Unity_Clamp_float(_Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float, float(0), float(1), _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float);
        float _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float;
        Unity_Multiply_float_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float, _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float);
        float4 _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4;
        Unity_Multiply_float4_float4(_Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4, (_Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float.xxxx), _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4);
        float3 _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3;
        Unity_Multiply_float3_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, (_Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float.xxx), _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3);
        float3 _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3, _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3);
        float3 _Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3 = _NormalMap;
        float _IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean = max(0, IN.FaceSign.x);
        float3 _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3;
        Unity_Multiply_float3_float3(IN.WorldSpaceNormal, float3(-1, -1, -1), _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3);
        float3 _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3;
        Unity_Branch_float3(_IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean, IN.WorldSpaceNormal, _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3, _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3);
        float4x4 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4;
        float3x3 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3;
        float2x2 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2;
        Unity_MatrixConstruction_Row_float((float4(IN.WorldSpaceTangent, 1.0)), (float4(IN.WorldSpaceBiTangent, 1.0)), (float4(_Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3, 1.0)), float4 (0, 0, 0, 0), _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2);
        float3 _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3;
        Unity_Multiply_float3_float3x3(_Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3);
        float3 _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3);
        float _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float;
        Unity_DotProduct_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3, _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float);
        float _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float = _Self_Shadow_Reduction;
        float _Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float = _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float;
        float _Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float = _Self_Shadow_Reduction_Smooth;
        float _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float;
        Unity_Negate_float(_Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float, _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float);
        float3 _Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3 = _Main_Lght_Direction;
        float _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float;
        Unity_DotProduct_float3(_Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float);
        float _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float;
        Unity_Smoothstep_float(_Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float, float(1), _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float, _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float);
        float _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float;
        Unity_Saturate_float(_Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float);
        float _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float;
        Unity_Multiply_float_float(_Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float);
        float _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float;
        Unity_Add_float(_DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float, _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float);
        float _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float;
        Unity_Saturate_float(_Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float, _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float);
        float _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Unity_Absolute_float(_Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float, _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float);
        float _Property_31bac462a2614697a42f18be112dd99d_Out_0_Float = _Thickness;
        float _Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float = _Thickness_Map;
        float _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float;
        Unity_OneMinus_float(_Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float, _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float);
        float _Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float = _Thickness_Remap_Min;
        float _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float = _Thickness_Remap_Max;
        float2 _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2 = float2(_Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float, _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float);
        float _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float;
        Unity_Remap_float(_OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float, float2 (0, 1), _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float);
        float _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float;
        Unity_Multiply_float_float(_Property_31bac462a2614697a42f18be112dd99d_Out_0_Float, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float, _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float);
        float _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float;
        Unity_Clamp_float(_Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float, float(0.001), float(1), _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float);
        float _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float;
        Unity_Power_float(_Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float, _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float, _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float);
        float3 _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3, (_Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float.xxx), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3);
        float3 _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4.xyz), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3, _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3);
        float3 _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3;
        Unity_Clamp_float3(_Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3);
        float3 _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3, _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3, _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3);
        float3 _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float.xxx), _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3, _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3);
        Out_Vector4_1 = _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Light_Direction_2 = _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Mesh_Normal_3 = (_Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3).x;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float3 Emission;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4 = _BarkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4, _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4 = _TrunkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Mask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.r;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.g;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.b;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4;
            Unity_Lerp_float4(_Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float.xxxx), _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4 = _DryColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4 = _HealthyColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_99caf98864a9e980997a02cedd282dd0_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_99caf98864a9e980997a02cedd282dd0_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_99caf98864a9e980997a02cedd282dd0_A_4_Float = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2 = float2(_Split_99caf98864a9e980997a02cedd282dd0_R_1_Float, _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float = _ColorNoiseTilling;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float;
            Unity_SimpleNoise_LegacySine_float(_Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2, _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float, _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float;
            Unity_Absolute_float(_SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float, _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float = _HealthyandDryColorNoisePower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float;
            Unity_Power_float(_Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float, _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float, _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float;
            Unity_Clamp_float(_Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float, float(0), float(1), _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4;
            Unity_Lerp_float4(_Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4, _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4, (_Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float.xxxx), _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4, _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_a52cc4db448642208842be98e18796fb_Out_0_Float = _Backface_Saturation;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3;
            Unity_Saturation_float((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Property_a52cc4db448642208842be98e18796fb_Out_0_Float, _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_547f6c365f204d14a383183448811966_Out_0_Float = _Backface_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3;
            Unity_Blend_Screen_float3(_Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3, (_Property_547f6c365f204d14a383183448811966_Out_0_Float.xxx), _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float(1));
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3;
            Unity_Clamp_float3(_Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2 = _Backface_Thickness_Mask_Remap;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float;
            Unity_Remap_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, float2 (0, 1), _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2, _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float;
            Unity_Clamp_float(_Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float, float(0), float(1), _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float = _Backface_Thickness_Mask_Threshold;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float;
            Unity_Power_float(_Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float, _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float, _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float;
            Unity_Clamp_float(_Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float, float(0), float(1), _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float;
            Unity_OneMinus_float(_Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float, _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3;
            Unity_Lerp_float3((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3, (_OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float.xxx), _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float;
            Unity_Absolute_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float, _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float = _Cross_Backface_Mask_Power;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float;
            Unity_Power_float(_Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float, _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float, _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float;
            Unity_Clamp_float(_Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float, float(0), float(1), _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3;
            Unity_Lerp_float3(_Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3, (_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), (_Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float.xxx), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3;
            Unity_Lerp_float3((_Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4.xyz), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float.xxx), _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float = _Global_Base_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3, (_Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float.xxx), _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            Unity_Clamp_float3(_Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float = _Translucency_Intensivity_1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float = _Translucency_Intensivity;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float;
            Unity_Lerp_float(_Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float, _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4 = _Translucency_Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4);
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_R_4_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.r;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_G_5_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.g;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_B_6_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.b;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_A_7_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float = _Trunk_Normal_Scale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float = _NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float;
            Unity_Lerp_float(_Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float, _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            Unity_NormalStrength_float((_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.xyz), _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float = _ThicknessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float = _ThicknessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float = _Translucency_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float = _Translucency_Self_Shadow_Reduction_Smooth;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float = _Translucency_Self_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3;
            MainLightDirection_float(_MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float _URPTranslucency_1984a38cc4724c849f275126c28b8205;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceNormal = IN.WorldSpaceNormal;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceTangent = IN.WorldSpaceTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.FaceSign = IN.FaceSign;
            float3 _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float;
            SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float, _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float, _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float, _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float, _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float, _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float, _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float, _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float, _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            Unity_Add_float3(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USE_TRANSLUCENCY)
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            #else
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.BaseColor = _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3;
            surface.Emission = float3(0, 0, 0);
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0)* GetOddNegativeScale();
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to pr               eserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This                is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent = renormFactor * bitang;
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition = GetAbsolutePositionWS(input.positionWS);
        #endif
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/LightingMetaPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "SceneSelectionPass"
            Tags
            {
                "LightMode" = "SceneSelectionPass"
            }
        
        // Render State
        Cull Off
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENESELECTIONPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.texCoord0.xyzw = input.texCoord0;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.texCoord0 = input.texCoord0.xyzw;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        // GraphIncludes: <None>
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        
        
        
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "ScenePickingPass"
            Tags
            {
                "LightMode" = "Picking"
            }
        
        // Render State
        Cull [_Cull]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        #pragma shader_feature _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma shader_feature _ _SHADOWS_SOFT
        #pragma shader_feature _ _ADDITIONAL_LIGHT
        #pragma shader_feature _ _MAIN_LIGHT_SHADOW
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_DEPTHONLY
        #define SCENEPICKINGPASS 1
        #define ALPHA_CLIP_THRESHOLD 1
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DOTS.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float FaceSign;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS : INTERP0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS : INTERP2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS : INTERP3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Hashes.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        float Unity_SimpleNoise_ValueNoise_LegacySine_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0; Hash_LegacySine_2_1_float(c0, r0);
            float r1; Hash_LegacySine_2_1_float(c1, r1);
            float r2; Hash_LegacySine_2_1_float(c2, r2);
            float r3; Hash_LegacySine_2_1_float(c3, r3);
            float bottomOfGrid = lerp(r0, r1, f.x);
            float topOfGrid = lerp(r2, r3, f.x);
            float t = lerp(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        
        void Unity_SimpleNoise_LegacySine_float(float2 UV, float Scale, out float Out)
        {
            float freq, amp;
            Out = 0.0f;
            freq = pow(2.0, float(0));
            amp = pow(0.5, float(3-0));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Saturation_float(float3 In, float Saturation, out float3 Out)
        {
            float luma = dot(In, float3(0.2126729, 0.7151522, 0.0721750));
            Out =  luma.xxx + Saturation.xxx * (In - luma.xxx);
        }
        
        void Unity_Blend_Screen_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = 1.0 - (1.0 - Blend) * (1.0 - Base);
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_Clamp_float3(float3 In, float3 Min, float3 Max, out float3 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void MainLightDirection_float(out float3 Direction)
        {
            #if SHADERGRAPH_PREVIEW
            Direction = half3(-0.5, -0.5, 0);
            #else
            Direction = SHADERGRAPH_MAIN_LIGHT_DIRECTION();
            #endif
        }
        
        // unity-custom-func-begin
        void GetLightData_float(float3 positionWS, out float3 lightDir, out float3 color, out float distanceAttenuation, out float shadowAttenuation){
        color = float3(0, 0, 0);
        distanceAttenuation = 0;
        shadowAttenuation =  0;
        #ifdef SHADERGRAPH_PREVIEW
        
            lightDir = float3(0.707, 0.707, 0);
        
            color = 128000;
            distanceAttenuation = 0;
            shadowAttenuation =  0;
        
        #else
        
          
        
        
        
                Light mainLight = GetMainLight(TransformWorldToShadowCoord(positionWS));
        
                lightDir = -mainLight.direction;
        
                color = mainLight.color;
               distanceAttenuation = mainLight.distanceAttenuation;
               shadowAttenuation =  mainLight.shadowAttenuation;
                
        
          
        
        #endif
        }
        // unity-custom-func-end
        
        struct Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float
        {
        float3 AbsoluteWorldSpacePosition;
        };
        
        void SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float IN, out float3 Direction_1, out float3 Color_2, out float distanceAttenuation_3, out float shadowAttenuation_4)
        {
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3;
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        GetLightData_float(IN.AbsoluteWorldSpacePosition, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float);
        float3 _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, float3(-1, -1, -1), float3(1, 1, 1), _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3);
        float3 _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, float3(0.01, 0.01, 0.01), float3(1000000, 100000, 100000), _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3);
        Direction_1 = _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Color_2 = _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        distanceAttenuation_3 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        shadowAttenuation_4 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
        Out = A * B;
        }
        
        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_MatrixConstruction_Row_float (float4 M0, float4 M1, float4 M2, float4 M3, out float4x4 Out4x4, out float3x3 Out3x3, out float2x2 Out2x2)
        {
        Out4x4 = float4x4(M0.x, M0.y, M0.z, M0.w, M1.x, M1.y, M1.z, M1.w, M2.x, M2.y, M2.z, M2.w, M3.x, M3.y, M3.z, M3.w);
        Out3x3 = float3x3(M0.x, M0.y, M0.z, M1.x, M1.y, M1.z, M2.x, M2.y, M2.z);
        Out2x2 = float2x2(M0.x, M0.y, M1.x, M1.y);
        }
        
        void Unity_Multiply_float3_float3x3(float3 A, float3x3 B, out float3 Out)
        {
        Out = mul(A, B);
        }
        
        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }
        
        void Unity_Negate_float(float In, out float Out)
        {
            Out = -1 * In;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        struct Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float
        {
        float3 WorldSpaceNormal;
        float3 WorldSpaceTangent;
        float3 WorldSpaceBiTangent;
        float3 AbsoluteWorldSpacePosition;
        float FaceSign;
        };
        
        void SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(float3 _Albedo_Map, float _Translucency_Intensivity, float4 _Translucency_Color, float3 _NormalMap, float _Thickness_Map, float _Thickness, float _Thickness_Remap_Min, float _Thickness_Remap_Max, float _Shadow_Reduction, float _Self_Shadow_Reduction_Smooth, float _Self_Shadow_Reduction, float3 _Main_Lght_Direction, Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float IN, out float3 Out_Vector4_1, out float Light_Direction_2, out float Mesh_Normal_3)
        {
        float _Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float = _Translucency_Intensivity;
        float3 _Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3 = _Albedo_Map;
        float4 _Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4 = _Translucency_Color;
        Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float _LightDataURP_18a0698558bb40bcadea0e6e303e48db;
        _LightDataURP_18a0698558bb40bcadea0e6e303e48db.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float;
        SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float);
        float _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float = _Shadow_Reduction;
        float _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float;
        Unity_Add_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float, _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float, _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float);
        float _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float;
        Unity_Clamp_float(_Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float, float(0), float(1), _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float);
        float _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float;
        Unity_Multiply_float_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float, _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float);
        float4 _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4;
        Unity_Multiply_float4_float4(_Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4, (_Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float.xxxx), _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4);
        float3 _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3;
        Unity_Multiply_float3_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, (_Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float.xxx), _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3);
        float3 _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3, _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3);
        float3 _Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3 = _NormalMap;
        float _IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean = max(0, IN.FaceSign.x);
        float3 _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3;
        Unity_Multiply_float3_float3(IN.WorldSpaceNormal, float3(-1, -1, -1), _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3);
        float3 _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3;
        Unity_Branch_float3(_IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean, IN.WorldSpaceNormal, _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3, _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3);
        float4x4 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4;
        float3x3 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3;
        float2x2 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2;
        Unity_MatrixConstruction_Row_float((float4(IN.WorldSpaceTangent, 1.0)), (float4(IN.WorldSpaceBiTangent, 1.0)), (float4(_Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3, 1.0)), float4 (0, 0, 0, 0), _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2);
        float3 _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3;
        Unity_Multiply_float3_float3x3(_Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3);
        float3 _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3);
        float _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float;
        Unity_DotProduct_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3, _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float);
        float _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float = _Self_Shadow_Reduction;
        float _Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float = _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float;
        float _Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float = _Self_Shadow_Reduction_Smooth;
        float _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float;
        Unity_Negate_float(_Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float, _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float);
        float3 _Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3 = _Main_Lght_Direction;
        float _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float;
        Unity_DotProduct_float3(_Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float);
        float _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float;
        Unity_Smoothstep_float(_Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float, float(1), _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float, _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float);
        float _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float;
        Unity_Saturate_float(_Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float);
        float _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float;
        Unity_Multiply_float_float(_Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float);
        float _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float;
        Unity_Add_float(_DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float, _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float);
        float _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float;
        Unity_Saturate_float(_Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float, _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float);
        float _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Unity_Absolute_float(_Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float, _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float);
        float _Property_31bac462a2614697a42f18be112dd99d_Out_0_Float = _Thickness;
        float _Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float = _Thickness_Map;
        float _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float;
        Unity_OneMinus_float(_Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float, _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float);
        float _Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float = _Thickness_Remap_Min;
        float _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float = _Thickness_Remap_Max;
        float2 _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2 = float2(_Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float, _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float);
        float _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float;
        Unity_Remap_float(_OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float, float2 (0, 1), _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float);
        float _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float;
        Unity_Multiply_float_float(_Property_31bac462a2614697a42f18be112dd99d_Out_0_Float, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float, _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float);
        float _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float;
        Unity_Clamp_float(_Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float, float(0.001), float(1), _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float);
        float _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float;
        Unity_Power_float(_Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float, _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float, _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float);
        float3 _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3, (_Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float.xxx), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3);
        float3 _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4.xyz), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3, _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3);
        float3 _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3;
        Unity_Clamp_float3(_Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3);
        float3 _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3, _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3, _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3);
        float3 _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float.xxx), _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3, _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3);
        Out_Vector4_1 = _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Light_Direction_2 = _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Mesh_Normal_3 = (_Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3).x;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4 = _BarkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4, _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4 = _TrunkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Mask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.r;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.g;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.b;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4;
            Unity_Lerp_float4(_Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float.xxxx), _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4 = _DryColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4 = _HealthyColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_99caf98864a9e980997a02cedd282dd0_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_99caf98864a9e980997a02cedd282dd0_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_99caf98864a9e980997a02cedd282dd0_A_4_Float = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2 = float2(_Split_99caf98864a9e980997a02cedd282dd0_R_1_Float, _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float = _ColorNoiseTilling;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float;
            Unity_SimpleNoise_LegacySine_float(_Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2, _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float, _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float;
            Unity_Absolute_float(_SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float, _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float = _HealthyandDryColorNoisePower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float;
            Unity_Power_float(_Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float, _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float, _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float;
            Unity_Clamp_float(_Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float, float(0), float(1), _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4;
            Unity_Lerp_float4(_Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4, _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4, (_Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float.xxxx), _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4, _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_a52cc4db448642208842be98e18796fb_Out_0_Float = _Backface_Saturation;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3;
            Unity_Saturation_float((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Property_a52cc4db448642208842be98e18796fb_Out_0_Float, _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_547f6c365f204d14a383183448811966_Out_0_Float = _Backface_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3;
            Unity_Blend_Screen_float3(_Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3, (_Property_547f6c365f204d14a383183448811966_Out_0_Float.xxx), _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float(1));
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3;
            Unity_Clamp_float3(_Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2 = _Backface_Thickness_Mask_Remap;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float;
            Unity_Remap_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, float2 (0, 1), _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2, _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float;
            Unity_Clamp_float(_Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float, float(0), float(1), _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float = _Backface_Thickness_Mask_Threshold;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float;
            Unity_Power_float(_Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float, _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float, _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float;
            Unity_Clamp_float(_Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float, float(0), float(1), _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float;
            Unity_OneMinus_float(_Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float, _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3;
            Unity_Lerp_float3((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3, (_OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float.xxx), _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float;
            Unity_Absolute_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float, _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float = _Cross_Backface_Mask_Power;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float;
            Unity_Power_float(_Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float, _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float, _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float;
            Unity_Clamp_float(_Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float, float(0), float(1), _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3;
            Unity_Lerp_float3(_Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3, (_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), (_Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float.xxx), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3;
            Unity_Lerp_float3((_Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4.xyz), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float.xxx), _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float = _Global_Base_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3, (_Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float.xxx), _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            Unity_Clamp_float3(_Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float = _Translucency_Intensivity_1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float = _Translucency_Intensivity;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float;
            Unity_Lerp_float(_Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float, _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4 = _Translucency_Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4);
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_R_4_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.r;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_G_5_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.g;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_B_6_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.b;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_A_7_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float = _Trunk_Normal_Scale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float = _NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float;
            Unity_Lerp_float(_Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float, _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            Unity_NormalStrength_float((_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.xyz), _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float = _ThicknessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float = _ThicknessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float = _Translucency_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float = _Translucency_Self_Shadow_Reduction_Smooth;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float = _Translucency_Self_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3;
            MainLightDirection_float(_MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float _URPTranslucency_1984a38cc4724c849f275126c28b8205;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceNormal = IN.WorldSpaceNormal;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceTangent = IN.WorldSpaceTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.FaceSign = IN.FaceSign;
            float3 _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float;
            SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float, _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float, _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float, _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float, _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float, _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float, _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float, _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float, _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            Unity_Add_float3(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USE_TRANSLUCENCY)
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            #else
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.BaseColor = _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3;
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0)* GetOddNegativeScale();
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to pr               eserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This                is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent = renormFactor * bitang;
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition = GetAbsolutePositionWS(input.positionWS);
        #endif
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/SelectionPickingPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
        Pass
        {
            Name "Universal 2D"
            Tags
            {
                "LightMode" = "Universal2D"
            }
        
        // Render State
        Cull [_Cull]
        Blend [_SrcBlend] [_DstBlend]
        ZTest [_ZTest]
        ZWrite [_ZWrite]
        
        // Debug
        // <None>
        
        // --------------------------------------------------
        // Pass
        
        HLSLPROGRAM
        
        // Pragmas
        #pragma target 2.0
        #pragma vertex vert
        #pragma fragment frag
        
        // Keywords
        #pragma shader_feature_local_fragment _ _ALPHATEST_ON
        #pragma shader_feature_local _ _USE_TRANSLUCENCY
        #pragma shader_feature _ _MAIN_LIGHT_SHADOWS_CASCADE
        #pragma shader_feature _ _SHADOWS_SOFT
        #pragma shader_feature _ _ADDITIONAL_LIGHT
        #pragma shader_feature _ _MAIN_LIGHT_SHADOW
        
        #if defined(_USE_TRANSLUCENCY)
            #define KEYWORD_PERMUTATION_0
        #else
            #define KEYWORD_PERMUTATION_1
        #endif
        
        
        // Defines
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMALMAP 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define _NORMAL_DROPOFF_TS 1
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_NORMAL
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TANGENT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define ATTRIBUTES_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_NORMAL_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define FEATURES_GRAPH_VERTEX_TANGENT_OUTPUT
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_POSITION_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_NORMAL_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TANGENT_WS
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_TEXCOORD0
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        #define VARYINGS_NEED_CULLFACE
        #endif
        
        #define FEATURES_GRAPH_VERTEX
        /* WARNING: $splice Could not find named fragment 'PassInstancing' */
        #define SHADERPASS SHADERPASS_2D
        
        
        // custom interpolator pre-include
        /* WARNING: $splice Could not find named fragment 'sgci_CustomInterpolatorPreInclude' */
        
        // Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
        #include_with_pragmas "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRenderingKeywords.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/FoveatedRendering.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Input.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/DebugMipmapStreamingMacros.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
        
        // --------------------------------------------------
        // Structs and Packing
        
        // custom interpolators pre packing
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPrePacking' */
        
        struct Attributes
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionOS : POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalOS : NORMAL;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentOS : TANGENT;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0 : TEXCOORD0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(ATTRIBUTES_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : INSTANCEID_SEMANTIC;
            #endif
            #endif
        };
        struct Varyings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        struct SurfaceDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 WorldSpaceBiTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 AbsoluteWorldSpacePosition;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 uv0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float FaceSign;
            #endif
        };
        struct VertexDescriptionInputs
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceNormal;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpaceTangent;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 ObjectSpacePosition;
            #endif
        };
        struct PackedVaryings
        {
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 positionCS : SV_POSITION;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 tangentWS : INTERP0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float4 texCoord0 : INTERP1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 positionWS : INTERP2;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             float3 normalWS : INTERP3;
            #endif
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint instanceID : CUSTOM_INSTANCE_ID;
            #endif
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsBlendIdx0 : BLENDINDICES0;
            #endif
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             uint stereoTargetEyeIndexAsRTArrayIdx : SV_RenderTargetArrayIndex;
            #endif
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
             FRONT_FACE_TYPE cullFace : FRONT_FACE_SEMANTIC;
            #endif
            #endif
        };
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        PackedVaryings PackVaryings (Varyings input)
        {
            PackedVaryings output;
            ZERO_INITIALIZE(PackedVaryings, output);
            output.positionCS = input.positionCS;
            output.tangentWS.xyzw = input.tangentWS;
            output.texCoord0.xyzw = input.texCoord0;
            output.positionWS.xyz = input.positionWS;
            output.normalWS.xyz = input.normalWS;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        
        Varyings UnpackVaryings (PackedVaryings input)
        {
            Varyings output;
            output.positionCS = input.positionCS;
            output.tangentWS = input.tangentWS.xyzw;
            output.texCoord0 = input.texCoord0.xyzw;
            output.positionWS = input.positionWS.xyz;
            output.normalWS = input.normalWS.xyz;
            #if UNITY_ANY_INSTANCING_ENABLED || defined(VARYINGS_NEED_INSTANCEID)
            output.instanceID = input.instanceID;
            #endif
            #if (defined(UNITY_STEREO_MULTIVIEW_ENABLED)) || (defined(UNITY_STEREO_INSTANCING_ENABLED) && (defined(SHADER_API_GLES3) || defined(SHADER_API_GLCORE)))
            output.stereoTargetEyeIndexAsBlendIdx0 = input.stereoTargetEyeIndexAsBlendIdx0;
            #endif
            #if (defined(UNITY_STEREO_INSTANCING_ENABLED))
            output.stereoTargetEyeIndexAsRTArrayIdx = input.stereoTargetEyeIndexAsRTArrayIdx;
            #endif
            #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
            output.cullFace = input.cullFace;
            #endif
            return output;
        }
        #endif
        
        // --------------------------------------------------
        // Graph
        
        // Graph Properties
        CBUFFER_START(UnityPerMaterial)
        float _Translucency_Intensivity_1;
        float _Translucency_Intensivity;
        float _Translucency_Self_Shadow_Reduction_Smooth;
        float _Translucency_Self_Shadow_Reduction;
        float _Translucency_Shadow_Reduction;
        float4 _Leaves_Specular;
        float _ThicknessRemapMin;
        float _ThicknessRemapMax;
        float4 _Translucency_Color;
        float4 _Trunk_Specular;
        float _Leaves_Metallic;
        float _Trunk_Metallic;
        float4 _TrunkBaseColor;
        float4 _BarkBaseColor;
        float _Backface_Thickness_Mask_Threshold;
        float2 _Backface_Thickness_Mask_Remap;
        float _Backface_Brightness;
        float _Cross_Backface_Mask_Power;
        float _Backface_Saturation;
        float4 _HealthyColor;
        float4 _DryColor;
        float _AlphaCutoff;
        float4 _BaseColorMap_TexelSize;
        float4 _TilingOffset;
        float _HealthyandDryColorNoisePower;
        float4 _NormalMap_TexelSize;
        float _NormalScale;
        float _AORemapMax;
        float _SmoothnessRemapMax;
        float4 _Mask_TexelSize;
        float _Thickness;
        float4 _MeshNormalMultiply;
        float _ColorNoiseTilling;
        float _Trunk_Normal_Scale;
        float _Global_Base_Brightness;
        float _Trunk_Smoothness_Remap_Max;
        UNITY_TEXTURE_STREAMING_DEBUG_VARS;
        CBUFFER_END
        
        
        // Object and Global properties
        SAMPLER(SamplerState_Linear_Repeat);
        SAMPLER(SamplerState_Linear_Repeat_Aniso8);
        TEXTURE2D(_BaseColorMap);
        SAMPLER(sampler_BaseColorMap);
        TEXTURE2D(_NormalMap);
        SAMPLER(sampler_NormalMap);
        TEXTURE2D(_Mask);
        SAMPLER(sampler_Mask);
        
        // Graph Includes
        #include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Hashes.hlsl"
        
        // -- Property used by ScenePickingPass
        #ifdef SCENEPICKINGPASS
        float4 _SelectionID;
        #endif
        
        // -- Properties used by SceneSelectionPass
        #ifdef SCENESELECTIONPASS
        int _ObjectId;
        int _PassValue;
        #endif
        
        // Graph Functions
        
        void Unity_Multiply_float3_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A * B;
        }
        
        void Unity_TilingAndOffset_float(float2 UV, float2 Tiling, float2 Offset, out float2 Out)
        {
            Out = UV * Tiling + Offset;
        }
        
        void Unity_Multiply_float4_float4(float4 A, float4 B, out float4 Out)
        {
            Out = A * B;
        }
        
        void Unity_Lerp_float4(float4 A, float4 B, float4 T, out float4 Out)
        {
            Out = lerp(A, B, T);
        }
        
        float Unity_SimpleNoise_ValueNoise_LegacySine_float (float2 uv)
        {
            float2 i = floor(uv);
            float2 f = frac(uv);
            f = f * f * (3.0 - 2.0 * f);
            uv = abs(frac(uv) - 0.5);
            float2 c0 = i + float2(0.0, 0.0);
            float2 c1 = i + float2(1.0, 0.0);
            float2 c2 = i + float2(0.0, 1.0);
            float2 c3 = i + float2(1.0, 1.0);
            float r0; Hash_LegacySine_2_1_float(c0, r0);
            float r1; Hash_LegacySine_2_1_float(c1, r1);
            float r2; Hash_LegacySine_2_1_float(c2, r2);
            float r3; Hash_LegacySine_2_1_float(c3, r3);
            float bottomOfGrid = lerp(r0, r1, f.x);
            float topOfGrid = lerp(r2, r3, f.x);
            float t = lerp(bottomOfGrid, topOfGrid, f.y);
            return t;
        }
        
        void Unity_SimpleNoise_LegacySine_float(float2 UV, float Scale, out float Out)
        {
            float freq, amp;
            Out = 0.0f;
            freq = pow(2.0, float(0));
            amp = pow(0.5, float(3-0));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(1));
            amp = pow(0.5, float(3-1));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
            freq = pow(2.0, float(2));
            amp = pow(0.5, float(3-2));
            Out += Unity_SimpleNoise_ValueNoise_LegacySine_float(float2(UV.xy*(Scale/freq)))*amp;
        }
        
        void Unity_Absolute_float(float In, out float Out)
        {
            Out = abs(In);
        }
        
        void Unity_Power_float(float A, float B, out float Out)
        {
            Out = pow(A, B);
        }
        
        void Unity_Clamp_float(float In, float Min, float Max, out float Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Saturation_float(float3 In, float Saturation, out float3 Out)
        {
            float luma = dot(In, float3(0.2126729, 0.7151522, 0.0721750));
            Out =  luma.xxx + Saturation.xxx * (In - luma.xxx);
        }
        
        void Unity_Blend_Screen_float3(float3 Base, float3 Blend, out float3 Out, float Opacity)
        {
            Out = 1.0 - (1.0 - Blend) * (1.0 - Base);
            Out = lerp(Base, Out, Opacity);
        }
        
        void Unity_Clamp_float3(float3 In, float3 Min, float3 Max, out float3 Out)
        {
            Out = clamp(In, Min, Max);
        }
        
        void Unity_Remap_float(float In, float2 InMinMax, float2 OutMinMax, out float Out)
        {
            Out = OutMinMax.x + (In - InMinMax.x) * (OutMinMax.y - OutMinMax.x) / (InMinMax.y - InMinMax.x);
        }
        
        void Unity_OneMinus_float(float In, out float Out)
        {
            Out = 1 - In;
        }
        
        void Unity_Lerp_float3(float3 A, float3 B, float3 T, out float3 Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_Lerp_float(float A, float B, float T, out float Out)
        {
            Out = lerp(A, B, T);
        }
        
        void Unity_NormalStrength_float(float3 In, float Strength, out float3 Out)
        {
            Out = float3(In.rg * Strength, lerp(1, In.b, saturate(Strength)));
        }
        
        void MainLightDirection_float(out float3 Direction)
        {
            #if SHADERGRAPH_PREVIEW
            Direction = half3(-0.5, -0.5, 0);
            #else
            Direction = SHADERGRAPH_MAIN_LIGHT_DIRECTION();
            #endif
        }
        
        // unity-custom-func-begin
        void GetLightData_float(float3 positionWS, out float3 lightDir, out float3 color, out float distanceAttenuation, out float shadowAttenuation){
        color = float3(0, 0, 0);
        distanceAttenuation = 0;
        shadowAttenuation =  0;
        #ifdef SHADERGRAPH_PREVIEW
        
            lightDir = float3(0.707, 0.707, 0);
        
            color = 128000;
            distanceAttenuation = 0;
            shadowAttenuation =  0;
        
        #else
        
          
        
        
        
                Light mainLight = GetMainLight(TransformWorldToShadowCoord(positionWS));
        
                lightDir = -mainLight.direction;
        
                color = mainLight.color;
               distanceAttenuation = mainLight.distanceAttenuation;
               shadowAttenuation =  mainLight.shadowAttenuation;
                
        
          
        
        #endif
        }
        // unity-custom-func-end
        
        struct Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float
        {
        float3 AbsoluteWorldSpacePosition;
        };
        
        void SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float IN, out float3 Direction_1, out float3 Color_2, out float distanceAttenuation_3, out float shadowAttenuation_4)
        {
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3;
        float3 _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        float _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        GetLightData_float(IN.AbsoluteWorldSpacePosition, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float, _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float);
        float3 _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_lightDir_0_Vector3, float3(-1, -1, -1), float3(1, 1, 1), _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3);
        float3 _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        Unity_Clamp_float3(_GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_color_1_Vector3, float3(0.01, 0.01, 0.01), float3(1000000, 100000, 100000), _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3);
        Direction_1 = _Clamp_d0e121f15e9b4bc78655a4ed324774b9_Out_3_Vector3;
        Color_2 = _Clamp_cae8c421a0c141f79e638702618f11ad_Out_3_Vector3;
        distanceAttenuation_3 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_distanceAttenuation_2_Float;
        shadowAttenuation_4 = _GetLightDataCustomFunction_7080735260b3168baa0a08cab565a2c1_shadowAttenuation_3_Float;
        }
        
        void Unity_Add_float(float A, float B, out float Out)
        {
            Out = A + B;
        }
        
        void Unity_Multiply_float_float(float A, float B, out float Out)
        {
        Out = A * B;
        }
        
        void Unity_Normalize_float3(float3 In, out float3 Out)
        {
            Out = normalize(In);
        }
        
        void Unity_Branch_float3(float Predicate, float3 True, float3 False, out float3 Out)
        {
            Out = Predicate ? True : False;
        }
        
        void Unity_MatrixConstruction_Row_float (float4 M0, float4 M1, float4 M2, float4 M3, out float4x4 Out4x4, out float3x3 Out3x3, out float2x2 Out2x2)
        {
        Out4x4 = float4x4(M0.x, M0.y, M0.z, M0.w, M1.x, M1.y, M1.z, M1.w, M2.x, M2.y, M2.z, M2.w, M3.x, M3.y, M3.z, M3.w);
        Out3x3 = float3x3(M0.x, M0.y, M0.z, M1.x, M1.y, M1.z, M2.x, M2.y, M2.z);
        Out2x2 = float2x2(M0.x, M0.y, M1.x, M1.y);
        }
        
        void Unity_Multiply_float3_float3x3(float3 A, float3x3 B, out float3 Out)
        {
        Out = mul(A, B);
        }
        
        void Unity_DotProduct_float3(float3 A, float3 B, out float Out)
        {
            Out = dot(A, B);
        }
        
        void Unity_Negate_float(float In, out float Out)
        {
            Out = -1 * In;
        }
        
        void Unity_Smoothstep_float(float Edge1, float Edge2, float In, out float Out)
        {
            Out = smoothstep(Edge1, Edge2, In);
        }
        
        void Unity_Saturate_float(float In, out float Out)
        {
            Out = saturate(In);
        }
        
        struct Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float
        {
        float3 WorldSpaceNormal;
        float3 WorldSpaceTangent;
        float3 WorldSpaceBiTangent;
        float3 AbsoluteWorldSpacePosition;
        float FaceSign;
        };
        
        void SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(float3 _Albedo_Map, float _Translucency_Intensivity, float4 _Translucency_Color, float3 _NormalMap, float _Thickness_Map, float _Thickness, float _Thickness_Remap_Min, float _Thickness_Remap_Max, float _Shadow_Reduction, float _Self_Shadow_Reduction_Smooth, float _Self_Shadow_Reduction, float3 _Main_Lght_Direction, Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float IN, out float3 Out_Vector4_1, out float Light_Direction_2, out float Mesh_Normal_3)
        {
        float _Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float = _Translucency_Intensivity;
        float3 _Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3 = _Albedo_Map;
        float4 _Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4 = _Translucency_Color;
        Bindings_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float _LightDataURP_18a0698558bb40bcadea0e6e303e48db;
        _LightDataURP_18a0698558bb40bcadea0e6e303e48db.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3;
        float3 _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float;
        float _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float;
        SG_LightDataURP_a02ff11a29d676645b44ec159fdb9001_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float);
        float _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float = _Shadow_Reduction;
        float _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float;
        Unity_Add_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_shadowAttenuation_4_Float, _Property_0a2d718b2f8f455fbfdac3cef7c875ec_Out_0_Float, _Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float);
        float _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float;
        Unity_Clamp_float(_Add_322384c8c5e7456ea7b1d6557df6b36d_Out_2_Float, float(0), float(1), _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float);
        float _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float;
        Unity_Multiply_float_float(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_distanceAttenuation_3_Float, _Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float, _Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float);
        float4 _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4;
        Unity_Multiply_float4_float4(_Property_5384c4698735466180a39bb0691b2c7c_Out_0_Vector4, (_Multiply_e12e91cea15a449f8096069f8de15e94_Out_2_Float.xxxx), _Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4);
        float3 _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3;
        Unity_Multiply_float3_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Color_2_Vector3, (_Clamp_85f0232f3a6a4786990b72bcfd98bbaf_Out_3_Float.xxx), _Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3);
        float3 _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_e74733b1199f46cbb8bd5631d52588c9_Out_2_Vector3, _Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3);
        float3 _Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3 = _NormalMap;
        float _IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean = max(0, IN.FaceSign.x);
        float3 _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3;
        Unity_Multiply_float3_float3(IN.WorldSpaceNormal, float3(-1, -1, -1), _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3);
        float3 _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3;
        Unity_Branch_float3(_IsFrontFace_77dba0f9505d413aaa60f445d57696eb_Out_0_Boolean, IN.WorldSpaceNormal, _Multiply_b7a2cc57a821462aada3308dceec169a_Out_2_Vector3, _Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3);
        float4x4 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4;
        float3x3 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3;
        float2x2 _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2;
        Unity_MatrixConstruction_Row_float((float4(IN.WorldSpaceTangent, 1.0)), (float4(IN.WorldSpaceBiTangent, 1.0)), (float4(_Branch_9152cadb48274cfc9331dc693968bcef_Out_3_Vector3, 1.0)), float4 (0, 0, 0, 0), _MatrixConstruction_11b91528c0a5419e96c558434747436e_var4x4_4_Matrix4, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var2x2_6_Matrix2);
        float3 _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3;
        Unity_Multiply_float3_float3x3(_Property_cde8e63e8f6a450180db5036a04f4b55_Out_0_Vector3, _MatrixConstruction_11b91528c0a5419e96c558434747436e_var3x3_5_Matrix3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3);
        float3 _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3;
        Unity_Normalize_float3(_Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3);
        float _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float;
        Unity_DotProduct_float3(_LightDataURP_18a0698558bb40bcadea0e6e303e48db_Direction_1_Vector3, _Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3, _DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float);
        float _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float = _Self_Shadow_Reduction;
        float _Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float = _Property_087d4c85fd2f4d039d272b3a196eb656_Out_0_Float;
        float _Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float = _Self_Shadow_Reduction_Smooth;
        float _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float;
        Unity_Negate_float(_Property_3a8c46fa8c134e17982651d5ae847932_Out_0_Float, _Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float);
        float3 _Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3 = _Main_Lght_Direction;
        float _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float;
        Unity_DotProduct_float3(_Property_77f4a8973ff8464da1ebb5e20c52aa5b_Out_0_Vector3, _Multiply_0e03e5004eae4201b2744f04cd4451d9_Out_2_Vector3, _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float);
        float _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float;
        Unity_Smoothstep_float(_Negate_0f6179f9503f4e71b77f476a6cadb4e9_Out_1_Float, float(1), _DotProduct_ce471773965a47e78b4a908c6eff9cb7_Out_2_Float, _Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float);
        float _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float;
        Unity_Saturate_float(_Smoothstep_cbf45539144e42ca87933c1527686982_Out_3_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float);
        float _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float;
        Unity_Multiply_float_float(_Float_752b940fcecd45b58a3b5a607b8767fe_Out_0_Float, _Saturate_6a049c8a26e44c56a46f64d412a2b7a2_Out_1_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float);
        float _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float;
        Unity_Add_float(_DotProduct_694d55fe0e41469cbe7db21856a622c7_Out_2_Float, _Multiply_055da99ef814454d944b7cd7319f713c_Out_2_Float, _Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float);
        float _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float;
        Unity_Saturate_float(_Add_72ee09afd21b4008b3ccc9dfbb04ad7f_Out_2_Float, _Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float);
        float _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Unity_Absolute_float(_Saturate_0183449b3a254cbf8b25279d4945c7b4_Out_1_Float, _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float);
        float _Property_31bac462a2614697a42f18be112dd99d_Out_0_Float = _Thickness;
        float _Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float = _Thickness_Map;
        float _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float;
        Unity_OneMinus_float(_Property_8b7a05b2f71641fcb14bb72c68dd10ac_Out_0_Float, _OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float);
        float _Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float = _Thickness_Remap_Min;
        float _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float = _Thickness_Remap_Max;
        float2 _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2 = float2(_Property_ccd1574a314345f7972e8ebaca8e3cbf_Out_0_Float, _Property_933b6b2ae78c4454a3bd5744c89bb5ee_Out_0_Float);
        float _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float;
        Unity_Remap_float(_OneMinus_073db2f035df424ab73a4b110337839e_Out_1_Float, float2 (0, 1), _Vector2_fa44725051d84e9bb63ca5aacd0b06af_Out_0_Vector2, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float);
        float _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float;
        Unity_Multiply_float_float(_Property_31bac462a2614697a42f18be112dd99d_Out_0_Float, _Remap_702eb3e3ac384634a03f86fc2c48e044_Out_3_Float, _Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float);
        float _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float;
        Unity_Clamp_float(_Multiply_baa0ebd43dac45efa77d5d8d1df626a7_Out_2_Float, float(0.001), float(1), _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float);
        float _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float;
        Unity_Power_float(_Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float, _Clamp_68337ad48f9348c1aa7da3c9fc7723b7_Out_3_Float, _Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float);
        float3 _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Normalize_519e9892cb5c45489e04951119885813_Out_1_Vector3, (_Power_851881cb21bf493eaa3cb10cc37d855a_Out_2_Float.xxx), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3);
        float3 _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Multiply_8e7244414f0a4608954a512f16daf8a9_Out_2_Vector4.xyz), _Multiply_4419883baeab40e3ba45b9a07ac34120_Out_2_Vector3, _Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3);
        float3 _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3;
        Unity_Clamp_float3(_Multiply_263c016ac4b941adbf9a5ff45712e2be_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3);
        float3 _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3;
        Unity_Multiply_float3_float3(_Property_6b00ad1066fe4d1a9f79d55927408dbe_Out_0_Vector3, _Clamp_390dd194f56744c69f71815f10695944_Out_3_Vector3, _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3);
        float3 _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Unity_Multiply_float3_float3((_Property_7c3e64eaf19e43d18d246a106c6007f3_Out_0_Float.xxx), _Multiply_b3138be36a7741fcb5b9e3b791361307_Out_2_Vector3, _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3);
        Out_Vector4_1 = _Multiply_2f54f43921ca4f7ea1c37d115507642b_Out_2_Vector3;
        Light_Direction_2 = _Absolute_affc08fb766a4bda95409881a2aef6ca_Out_1_Float;
        Mesh_Normal_3 = (_Normalize_5fceb331d66a402e89c79c877e09650d_Out_1_Vector3).x;
        }
        
        void Unity_Add_float3(float3 A, float3 B, out float3 Out)
        {
            Out = A + B;
        }
        
        // Custom interpolators pre vertex
        /* WARNING: $splice Could not find named fragment 'CustomInterpolatorPreVertex' */
        
        // Graph Vertex
        struct VertexDescription
        {
            float3 Position;
            float3 Normal;
            float3 Tangent;
        };
        
        VertexDescription VertexDescriptionFunction(VertexDescriptionInputs IN)
        {
            VertexDescription description = (VertexDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4 = _MeshNormalMultiply;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            Unity_Multiply_float3_float3(IN.ObjectSpaceNormal, (_Property_059fd38b073cfc899ebb9fdfb49a2189_Out_0_Vector4.xyz), _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3);
            #endif
            description.Position = IN.ObjectSpacePosition;
            description.Normal = _Multiply_97069a070ca647ef8152caa72a04ef8a_Out_2_Vector3;
            description.Tangent = IN.ObjectSpaceTangent;
            return description;
        }
        
        // Custom interpolators, pre surface
        #ifdef FEATURES_GRAPH_VERTEX
        Varyings CustomInterpolatorPassThroughFunc(inout Varyings output, VertexDescription input)
        {
        return output;
        }
        #define CUSTOMINTERPOLATOR_VARYPASSTHROUGH_FUNC
        #endif
        
        // Graph Pixel
        struct SurfaceDescription
        {
            float3 BaseColor;
            float Alpha;
            float AlphaClipThreshold;
        };
        
        SurfaceDescription SurfaceDescriptionFunction(SurfaceDescriptionInputs IN)
        {
            SurfaceDescription surface = (SurfaceDescription)0;
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_BaseColorMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4 = _TilingOffset;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_60538633130155809820b3185c81057f_R_1_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[0];
            float _Split_60538633130155809820b3185c81057f_G_2_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[1];
            float _Split_60538633130155809820b3185c81057f_B_3_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[2];
            float _Split_60538633130155809820b3185c81057f_A_4_Float = _Property_8ec0d512145619859d288abab740e3bf_Out_0_Vector4[3];
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_R_1_Float, _Split_60538633130155809820b3185c81057f_G_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2 = float2(_Split_60538633130155809820b3185c81057f_B_3_Float, _Split_60538633130155809820b3185c81057f_A_4_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2;
            Unity_TilingAndOffset_float(IN.uv0.xy, _Vector2_83b2ea7a32ab548fb8c20dce14204561_Out_0_Vector2, _Vector2_188e122ac0c7888f9f5fbde73f9edd75_Out_0_Vector2, _TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.tex, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.samplerstate, _Property_821e07b38fd0a08d85c4dd6e5b6bbac9_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_R_4_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.r;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_G_5_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.g;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_B_6_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.b;
            float _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4 = _BarkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_d37c4e2cc4f949f581f76dcb73d50e87_Out_0_Vector4, _Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4 = _TrunkBaseColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Property_0f3c5f287e8145bc95fd52cfba4b8fcc_Out_0_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_Mask);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_993f47501beb8286b10e988cd4c7e220_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.r;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.g;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.b;
            float _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float = _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4;
            Unity_Lerp_float4(_Multiply_e4794b5d7e19433599f2b4e150644bea_Out_2_Vector4, _Multiply_2453fa0c275a46cca1a866a080d90ddf_Out_2_Vector4, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_B_6_Float.xxxx), _Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4 = _DryColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4 = _HealthyColor;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Split_99caf98864a9e980997a02cedd282dd0_R_1_Float = IN.AbsoluteWorldSpacePosition[0];
            float _Split_99caf98864a9e980997a02cedd282dd0_G_2_Float = IN.AbsoluteWorldSpacePosition[1];
            float _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float = IN.AbsoluteWorldSpacePosition[2];
            float _Split_99caf98864a9e980997a02cedd282dd0_A_4_Float = 0;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2 = float2(_Split_99caf98864a9e980997a02cedd282dd0_R_1_Float, _Split_99caf98864a9e980997a02cedd282dd0_B_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float = _ColorNoiseTilling;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float;
            Unity_SimpleNoise_LegacySine_float(_Vector2_ddc95fa04fb4858daf984190322978b9_Out_0_Vector2, _Property_4d778d1ae72a416b96bf6cb1986a7d5d_Out_0_Float, _SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float;
            Unity_Absolute_float(_SimpleNoise_96327065e2b0428f83e25f93c7e5a748_Out_2_Float, _Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float = _HealthyandDryColorNoisePower;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float;
            Unity_Power_float(_Absolute_3da7acf58a45403cad1e7c432d78f027_Out_1_Float, _Property_0dff529d33cb42e388c9d874effe6e19_Out_0_Float, _Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float;
            Unity_Clamp_float(_Power_77b7c0eba07f4b9da46f2fa461c49201_Out_2_Float, float(0), float(1), _Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4;
            Unity_Lerp_float4(_Property_944e0c60198849afb235eb9940da5dd9_Out_0_Vector4, _Property_621f9271d8734c81b9001229b0296656_Out_0_Vector4, (_Clamp_efb2cde09ec64325a2f78a848b0827b2_Out_3_Float.xxxx), _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4;
            Unity_Multiply_float4_float4(_SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_RGBA_0_Vector4, _Lerp_b995ffde83d24283ac272745617fa60c_Out_3_Vector4, _Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_a52cc4db448642208842be98e18796fb_Out_0_Float = _Backface_Saturation;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3;
            Unity_Saturation_float((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Property_a52cc4db448642208842be98e18796fb_Out_0_Float, _Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_547f6c365f204d14a383183448811966_Out_0_Float = _Backface_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3;
            Unity_Blend_Screen_float3(_Saturation_1a5be2ae12084c59883f7d315d09cd80_Out_2_Vector3, (_Property_547f6c365f204d14a383183448811966_Out_0_Float.xxx), _Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float(1));
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3;
            Unity_Clamp_float3(_Blend_9d43ee127ca04ec09dd9151a833d8d61_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float2 _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2 = _Backface_Thickness_Mask_Remap;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float;
            Unity_Remap_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, float2 (0, 1), _Property_b0a46b9c34574501a2f500d2f5745793_Out_0_Vector2, _Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float;
            Unity_Clamp_float(_Remap_bbbefbf0fbaf41d8a6d07b465d45488f_Out_3_Float, float(0), float(1), _Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float = _Backface_Thickness_Mask_Threshold;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float;
            Unity_Power_float(_Clamp_6ac81c92e9a64e958055eca61b82e791_Out_3_Float, _Property_3a1e9cc1507b46b2af88ab75dfc37b44_Out_0_Float, _Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float;
            Unity_Clamp_float(_Power_1fccfa34ffba46ceac25f1238aa4e1b5_Out_2_Float, float(0), float(1), _Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float;
            Unity_OneMinus_float(_Clamp_e55b4d1f4fda4e97bcfe15cfe9c6fd05_Out_3_Float, _OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3;
            Unity_Lerp_float3((_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), _Clamp_f7855b2ac55c4d43b25a4a1e56dbbbf7_Out_3_Vector3, (_OneMinus_16a8ddad0aee4e5ca379aef306048984_Out_1_Float.xxx), _Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float;
            Unity_Absolute_float(_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_R_4_Float, _Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float = _Cross_Backface_Mask_Power;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float;
            Unity_Power_float(_Absolute_98dfaf1178334fc287f9e4d4b5f3a0f0_Out_1_Float, _Property_08b97a5bb158439e9155434b6637ac33_Out_0_Float, _Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float;
            Unity_Clamp_float(_Power_c8f61d8af16945f9b82731ed18d38dd9_Out_2_Float, float(0), float(1), _Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3;
            Unity_Lerp_float3(_Lerp_9c8a6dd2927446309acc26d9f217de99_Out_3_Vector3, (_Multiply_7440911fa0e24984a93265bf47ed64a5_Out_2_Vector4.xyz), (_Clamp_c8b7bf714ebb484d8aa73d545b2f9d59_Out_3_Float.xxx), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3;
            Unity_Lerp_float3((_Lerp_9056381ab3034355b45968f0d1ff2f1a_Out_3_Vector4.xyz), _Lerp_343d7507e4664bd7bc5108bcf0d55854_Out_3_Vector3, (_SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float.xxx), _Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float = _Global_Base_Brightness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3;
            Unity_Multiply_float3_float3(_Lerp_0d72c41eff034cfaaaf0208f4bf42433_Out_3_Vector3, (_Property_09c643c04af64fb18f3a77b935844ecc_Out_0_Float.xxx), _Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            Unity_Clamp_float3(_Multiply_61b0f4818da94adfa23e13d8e3e376a8_Out_2_Vector3, float3(0, 0, 0), float3(1, 1, 1), _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float = _Translucency_Intensivity_1;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float = _Translucency_Intensivity;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float;
            Unity_Lerp_float(_Property_6186b2d13dd64f45987518c064c1e2f5_Out_0_Float, _Property_62a9920d1a3e48aaaefdb195c3b18773_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4 = _Translucency_Color;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            UnityTexture2D _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D = UnityBuildTexture2DStructNoScale(_NormalMap);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float4 _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4 = SAMPLE_TEXTURE2D(_Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.tex, UnityBuildSamplerStateStruct(SamplerState_Linear_Repeat_Aniso8).samplerstate, _Property_147b07430832c98eb0a470557ee61c5e_Out_0_Texture2D.GetTransformedUV(_TilingAndOffset_a2e0bda8e800d280b7064fc016a7e6cd_Out_3_Vector2) );
            _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.rgb = UnpackNormal(_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4);
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_R_4_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.r;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_G_5_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.g;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_B_6_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.b;
            float _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_A_7_Float = _SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.a;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float = _Trunk_Normal_Scale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float = _NormalScale;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float;
            Unity_Lerp_float(_Property_b07156802a1240f7a8c14a272c5f1b36_Out_0_Float, _Property_72e436a108ad64868e46d548c585c5f3_Out_0_Float, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_G_5_Float, _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3;
            Unity_NormalStrength_float((_SampleTexture2D_3a56330a29e2f58a96a29a2135b19cbc_RGBA_0_Vector4.xyz), _Lerp_6624e2dc589744b094c6b643efa7fb2e_Out_3_Float, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float = _Thickness;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float = _ThicknessRemapMin;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float = _ThicknessRemapMax;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float = _Translucency_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float = _Translucency_Self_Shadow_Reduction_Smooth;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float = _Translucency_Self_Shadow_Reduction;
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3;
            MainLightDirection_float(_MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            Bindings_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float _URPTranslucency_1984a38cc4724c849f275126c28b8205;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceNormal = IN.WorldSpaceNormal;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceTangent = IN.WorldSpaceTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.WorldSpaceBiTangent = IN.WorldSpaceBiTangent;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.AbsoluteWorldSpacePosition = IN.AbsoluteWorldSpacePosition;
            _URPTranslucency_1984a38cc4724c849f275126c28b8205.FaceSign = IN.FaceSign;
            float3 _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float;
            float _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float;
            SG_URPTranslucency_bfe7ad954cc8b5b4892faef0323eeb84_float(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _Lerp_fa73977bf902442ea235bd8c41b84847_Out_3_Float, _Property_6b22fd1d3f534e709fd5092230d3c8e3_Out_0_Vector4, _NormalStrength_366affc5c8b42482a633d201ef52b9d6_Out_2_Vector3, _SampleTexture2D_d39fcf91fd1cab8c8ced62e9568e9bc4_A_7_Float, _Property_9d7240ed882146b19d53c7f747c5cc38_Out_0_Float, _Property_bb242320dceb44a1b7e5b70895550101_Out_0_Float, _Property_6c9c99a1e7864618ac36a63494f53fda_Out_0_Float, _Property_79786d3bf3084ca48be9645fdc575aa4_Out_0_Float, _Property_9d9b61fd80d3440f835a8de1fc4b6a37_Out_0_Float, _Property_6f14d5f4115c4498998a212cb694d47b_Out_0_Float, _MainLightDirection_b3194bbb0d76421abf605eb9d4cc9aa8_Direction_0_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_LightDirection_2_Float, _URPTranslucency_1984a38cc4724c849f275126c28b8205_MeshNormal_3_Float);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float3 _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            Unity_Add_float3(_Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3, _URPTranslucency_1984a38cc4724c849f275126c28b8205_OutVector4_1_Vector3, _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3);
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            #if defined(_USE_TRANSLUCENCY)
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Add_71c569888f03495eb932b64dfe4383cd_Out_2_Vector3;
            #else
            float3 _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3 = _Clamp_359788e8ad134650b865e76600af6700_Out_3_Vector3;
            #endif
            #endif
            #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
            float _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float = _AlphaCutoff;
            #endif
            surface.BaseColor = _UseTranslucency_fda21db28b014faf9e41aaa10e13ec71_Out_0_Vector3;
            surface.Alpha = _SampleTexture2D_91f1784012cdb683a2ab7a12fc14c94d_A_7_Float;
            surface.AlphaClipThreshold = _Property_067d68a770a25e8f978ca090306a96d8_Out_0_Float;
            return surface;
        }
        
        // --------------------------------------------------
        // Build Graph Inputs
        #ifdef HAVE_VFX_MODIFICATION
        #define VFX_SRP_ATTRIBUTES Attributes
        #define VFX_SRP_VARYINGS Varyings
        #define VFX_SRP_SURFACE_INPUTS SurfaceDescriptionInputs
        #endif
        VertexDescriptionInputs BuildVertexDescriptionInputs(Attributes input)
        {
            VertexDescriptionInputs output;
            ZERO_INITIALIZE(VertexDescriptionInputs, output);
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceNormal =                          input.normalOS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpaceTangent =                         input.tangentOS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.ObjectSpacePosition =                        input.positionOS;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        
            return output;
        }
        SurfaceDescriptionInputs BuildSurfaceDescriptionInputs(Varyings input)
        {
            SurfaceDescriptionInputs output;
            ZERO_INITIALIZE(SurfaceDescriptionInputs, output);
        
        #ifdef HAVE_VFX_MODIFICATION
        #if VFX_USE_GRAPH_VALUES
            uint instanceActiveIndex = asuint(UNITY_ACCESS_INSTANCED_PROP(PerInstance, _InstanceActiveIndex));
            /* WARNING: $splice Could not find named fragment 'VFXLoadGraphValues' */
        #endif
            /* WARNING: $splice Could not find named fragment 'VFXSetFragInputs' */
        
        #endif
        
            
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // must use interpolated tangent, bitangent and normal before they are normalized in the pixel shader.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 unnormalizedNormalWS = input.normalWS;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        const float renormFactor = 1.0 / length(unnormalizedNormalWS);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // use bitangent on the fly like in hdrp
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // IMPORTANT! If we ever support Flip on double sided materials ensure bitangent and tangent are NOT flipped.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float crossSign = (input.tangentWS.w > 0.0 ? 1.0 : -1.0)* GetOddNegativeScale();
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        float3 bitang = crossSign * cross(input.normalWS.xyz, input.tangentWS.xyz);
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceNormal = renormFactor * input.normalWS.xyz;      // we want a unit length Normal Vector node in shader graph
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // to pr               eserve mikktspace compliance we use same scale renormFactor as was used on the normal.
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        // This                is explained in section 2.2 in "surface gradient based bump mapping framework"
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceTangent = renormFactor * input.tangentWS.xyz;
        #endif
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.WorldSpaceBiTangent = renormFactor * bitang;
        #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.AbsoluteWorldSpacePosition = GetAbsolutePositionWS(input.positionWS);
        #endif
        
        
            #if UNITY_UV_STARTS_AT_TOP
            #else
            #endif
        
        
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        output.uv0 = input.texCoord0;
        #endif
        
        #if UNITY_ANY_INSTANCING_ENABLED
        #else // TODO: XR support for procedural instancing because in this case UNITY_ANY_INSTANCING_ENABLED is not defined and instanceID is incorrect.
        #endif
        #if defined(SHADER_STAGE_FRAGMENT) && defined(VARYINGS_NEED_CULLFACE)
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN output.FaceSign =                    IS_FRONT_VFACE(input.cullFace, true, false);
        #else
        #define BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        #if defined(KEYWORD_PERMUTATION_0) || defined(KEYWORD_PERMUTATION_1)
        BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        #endif
        
        #undef BUILD_SURFACE_DESCRIPTION_INPUTS_OUTPUT_FACESIGN
        
                return output;
        }
        
        // --------------------------------------------------
        // Main
        
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/Varyings.hlsl"
        #include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/PBR2DPass.hlsl"
        
        // --------------------------------------------------
        // Visual Effect Vertex Invocations
        #ifdef HAVE_VFX_MODIFICATION
        #include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/VisualEffectVertex.hlsl"
        #endif
        
        ENDHLSL
        }
    }
    CustomEditor "UnityEditor.ShaderGraph.GenericShaderGraphMaterialGUI"
    CustomEditorForRenderPipeline "UnityEditor.ShaderGraphLitGUI" "UnityEngine.Rendering.Universal.UniversalRenderPipelineAsset"
    FallBack "Hidden/Shader Graph/FallbackError"
}