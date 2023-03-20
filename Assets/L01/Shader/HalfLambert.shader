// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33387,y:32762,varname:node_3138,prsc:2|emission-9030-RGB;n:type:ShaderForge.SFN_LightVector,id:449,x:31995,y:32573,varname:node_449,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:6367,x:31995,y:32812,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:111,x:32195,y:32703,varname:node_111,prsc:2,dt:0|A-449-OUT,B-6367-OUT;n:type:ShaderForge.SFN_Multiply,id:2998,x:32385,y:32776,varname:node_2998,prsc:2|A-111-OUT,B-1-OUT;n:type:ShaderForge.SFN_Add,id:4026,x:32587,y:32776,varname:node_4026,prsc:2|A-2998-OUT,B-7810-OUT;n:type:ShaderForge.SFN_Append,id:5412,x:32814,y:32776,varname:node_5412,prsc:2|A-4026-OUT,B-3402-OUT;n:type:ShaderForge.SFN_Vector1,id:3402,x:32616,y:32954,varname:node_3402,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Tex2d,id:9030,x:33066,y:32776,ptovrint:False,ptlb:node_9030,ptin:_node_9030,varname:node_9030,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:74114f0d22eba234b85fc7fd2d68d97a,ntxv:3,isnm:False|UVIN-5412-OUT;n:type:ShaderForge.SFN_Vector1,id:1,x:32185,y:32874,varname:node_1,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Vector1,id:7810,x:32385,y:32954,varname:node_7810,prsc:2,v1:0.5;proporder:9030;pass:END;sub:END;*/

Shader "Shader Forge/HalfLambert" {
    Properties {
        _node_9030 ("node_9030", 2D) = "bump" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_9030; uniform float4 _node_9030_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float2 node_5412 = float2(((dot(lightDirection,i.normalDir)*0.5)+0.5),0.2);
                float4 _node_9030_var = tex2D(_node_9030,TRANSFORM_TEX(node_5412, _node_9030));
                float3 emissive = _node_9030_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_9030; uniform float4 _node_9030_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
