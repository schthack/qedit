# PSO Quest editor
## What do i need to build ?
The source code has been ported to be compatible with the Delphi community 10.X  
DirectX 9c is required, the specific dll is included in the source.

## Good to known
In Delphi the memory management for buffer was using a C like command allocmem and freemem, conveniently a string in the old version of Delphi was similar to a binary buffer with auto allocation. This was bad pratice but my young self didnt bother and used it everywhere. String start at 1 for the character array and you can use + to add to it.

The code is a mess and has few comment, i never bothered to improve it and recently only upgraded it to the latess Delphi version and did some bug fix.