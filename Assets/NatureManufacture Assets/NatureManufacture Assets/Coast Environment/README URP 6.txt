!!WARNING!!
UNITY 6 PERFORMANCE ISSUE (BUG)!!
https://issuetracker.unity3d.com/issues/terrain-detail-mesh-triangles-value-increases-when-occlusion-culling-is-used-and-cast-shadows-is-enabled-on-the-mesh
We report a bug that when you use occlusion culling all foliage meshes at terrain multiply their triangles if they have shadow cast turned on. 
Seams its not only related to culling.
Until Unity fixes that performance at the Unity 6 Demo scene will be poor.
!!!Unity 6 display 200% more triangles, 2x more batches then it should. We compare 2022.3 and Unity 6 and seams than when we turn off shadows at light: triangles back to normal.
Remember about that until unity fix shadows issue. Bug is related to unity terrain.
Unity 2022.3 is free from these issues.

Download the pack via your actual engine version so that URP files match the URP engine version.
Built-in is non supported as unity and users abandon that pipeline.
For HD RP please visit "HD Support Pack" and import the support pack which will replace shaders and materials just for your HD RP version. Please also follow the readme inside that folder.

URP Unity 6
- you need Unity 6
- you need URP SRP pipeline 17 if you use higher please import a higher support pack.

Step 1 
Go to "PC_Renderer" or the version of that file that you use:
1. You can improve the FPS amount by 30% if you change the rendering path from forward to deferred at the rendering setting. The scene has many reflection probes.
Change the Rendering path from forward to deferred. Forward render is ok too but it's slower for big open scenes.
!!WARNING!! at URP unity 6 deferred render is bugged. Object shadows moves with camera position at terrain object or it render black terrain layers at terrain with more then 4 textures.
Im not sure what engine version you will use but all versions until 6000.0.34f1 are bugged and bug still exist. Unity 2022.3 doesn't have this issue.

2. Add decal support if you want to use our decals on walls:
  * Add Renderer Feature --> Decal --> Max Draw Distance 200-300
  * !!If you use deferred render change decal technique to avoid flickering seams "AUTO" doesn't work well (bugged) on deferred!! "Use SCREEN SPACE" for deferred render.
  * Turn on use rendering layers: Decals use layers to avoid painting them on objects that are above or just shouldn't have the specific decal on themself.

Step 2
-Turn a few options in "PC_RPAsset" or other profile that you use:
	       * "Opaque Texture" This will fix water - they need to grab the screen the color (depth buffer)
	       * "Depth Texture" This will fix water - they need to grab the screen color (depth buffer)
- Optionaly use 1k or 2k shadow resolution. We used 2k.
- Turn on HDR if it is turned off

Step 3         
- Import the VFX graph particles "Visual Effect Graph”, you can find it in the package manager, in the unity registry. It's a unity particle system, much faster than older.

Step 4 Go to project settings: 
    - Player and set:  Color Space to Linear
    - Quality settings: Go to quality settings and: 
	 * turn off vsync
	 * lod bias should be around 1 max 2 higher values will generate more triangles.
                        
Step 4 Find "Coast Scene" and open it.
You can also open "Overview Scene" to check all assets.

Step 5 - HIT PLAY!:)

Step 6 -  Make note that Unity often compiles shaders even after you hit play for a long time, so performance will rise after Unity ends the shader compilation
Wait a moment until it ends. 
