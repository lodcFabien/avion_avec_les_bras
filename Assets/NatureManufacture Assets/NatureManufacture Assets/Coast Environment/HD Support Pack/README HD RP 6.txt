!!WARNING!!
UNITY 6 PERFORMANCE ISSUE (BUG)!!
https://issuetracker.unity3d.com/issues/terrain-detail-mesh-triangles-value-increases-when-occlusion-culling-is-used-and-cast-shadows-is-enabled-on-the-mesh
We report a bug that when you use occlusion culling all foliage meshes at terrain multiply their triangles if they have shadow cast turned on. 
Seams its not only related to culling.
Until Unity fixes that performance at the Unity 6 Demo scene will be poor.
!!!Unity 6 display 200% more triangles, 2x more batches then it should. We compare 2022.3 and Unity 6 and seams than when we turn off shadows at light: triangles back to normal.
Remember about that until unity fix shadows issue. Bug is related to unity terrain.
Unity 2022.3 is free from these issues.

BEFORE YOU START:
- you need Unity 6
- you need HD SRP pipeline 17 if you use higher etc custom shaders could not work but seems they should. 
- for higher HD RP version download pack via higher engine version and import higher support pack

Step 1 
	!!!! IMPORTANT !!!! Open "Project settings" ->"Gaphics"-> "Diffusion Profile List"
	and drag and drop our SSS settings diffusion profiles for foliage and water into the Diffusion profile list:
		  NM_Oak_Leaves
		  NM_Pines
		  NM_Sea_Foliage
		  NM_SSSSettings_Water_RAM3
		  NM_Water_Seaside
	Without this foliage, water, particles will not become affected by scattering and they will look wrong - debug mode.
        There is also a fix button on each material that uses these profiles and it will automatically add profiles to the list from the material panel.
Step 2 If you want to use Screen Space Reflection on water surfaces visit: 
 1. HDRP High Fidelity and turn on screen space reflection and transparent option
 2. Open "Project settings" ->"Gaphics"->Camera--> Lighting and turn on screen space reflection and transparents option

Step 3 Open "Project settings" and "Quality" and set:
	- Set VSync to don't sync

Step 4 Find the "Coast Demo" scene and open it.

Step 5 - HIT PLAY!:)

Step 6 If you want to use Screen Space Global Ilumination which looks super cool but also eat 50% of FPS turn it on at Sky and Fog Volume

Step 7 - Make note that Unity often compiles shaders even after you hit play for a long time, so performance will rise after Unity ends the shader compilation
Wait a moment until it ends. 
to misunderstanding. 

About scene construction:
		- Prefab wind manages wind speed and direction at the scene
                - More details you will find at Readme file: "README Demo Scene Construction"
		 You could adjust the fog resolution, we set it to low as it's the most expensive thing at the scene. For better devices, you could use medium quality.
		- Remember to have "always refresh" at the scene window turned on, it's in "toggle skybox, fog, and various other effects".
 You can find it at the top right at the scene window. Without this option turned off fog and wind will not refresh properly at scene view, and will work only at playmode.

IMPORTANT1:
If you notice in the console error:
No more space in Reflection Probe Atlas. To solve this issue, increase the size of the Reflection Probe Atlas in the HDRP settings.
UnityEngine.GUIUtility:ProcessEvent (int,intptr,bool&)
Just change reflection atlas size at hd rp settings into 4kx8k or higher.
Go to: Edit--> Project Settings --> find "Reflection 2D Atlas Size" --> set it to 8x8k or lower if it would not throw any error on 4x8k for example.


IMPORTANT2:
If you notice in the console warning:
Maximum reflection probes on screen reached. To fix this error, increase the 'Maximum Cube Reflection Probes on Screen' property in the HDRP asset.
UnityEngine.GUIUtility:ProcessEvent (int,intptr,bool&)
Go to: Edit--> Project Settings --> find "Maximum Cube Reflection Probes on Screen" --> set it to 64