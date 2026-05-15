About scene construction:
	- There is a post-process profile: Manage post-process by scene Post Process Volume you will find it in Render Parent.
	- P"refab_Wind" manages wind speed and direction at the scene
        - All ground and decal textures we left in 2k resolution because Unity has a 6 GB file limit. 
        We will upload them in 4k resolution as a separate pack with a FREE upgrade from this asset. So if you need a higher texture resolution you will be able to download it for free.
        After you import 4k files they will replace 2k out of the box.
        - Many objects/meshes are bent via our R.A.M 3 lake, river sea, and fence generator. Cliffs are tilled, you can place them via splines. 
        It's super useful and fast way to place such objects at the scene. You can use also other spline tools if they allow you to bend meshes. 
        We give you a 50% discount (upgrade) from Sea Side to R.A.M 3 pack.
        - We left profiles, splines for cliffs, fences, lakes, seas, and rivers and automatic terrain painting in "R.A.M 3 Profiles and Sources" so you can easily use our settings in your development. 
        You will get good results out of the box.
        - "R.A.M 3 Profiles and Sources" also contain all splines from scene so you can kick actual mesh and generate it/modify from spline
        -  Sea is our R.A.M 3 object with tesselation via distance LOD Manager. You only keep high quality when camera is close enough. It could be usefull script not only for sea :)

!!WARNING!!
UNITY 6 PERFORMANCE ISSUE (BUG)!!
https://issuetracker.unity3d.com/issues/terrain-detail-mesh-triangles-value-increases-when-occlusion-culling-is-used-and-cast-shadows-is-enabled-on-the-mesh
We report a bug that when you use occlusion culling all foliage meshes at terrain multiply their triangles if they have shadow cast turned on. 
Seams its not only related to culling.
Until Unity fixes that performance at the Unity 6 Demo scene will be poor.
!!!Unity 6 display 200% more triangles, 2x more batches then it should. We compare 2022.3 and Unity 6 and seams than when we turn off shadows at light: triangles back to normal.
Remember about that until unity fix shadows issue. Bug is related to unity terrain.
Unity 2022.3 is free from these issues.