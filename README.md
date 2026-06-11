# PSO Quest Editor
## Building
Open the .dproj file in Delphi (tested using Delphi 12 Community Edition) and optionally install (Component -> Install packages -> Add) the Designtime.bpl package file located in the Text editor folder, then build with Shift+F9.
DirectX 9c is required; the specific DLL is included in the source. 

The script text editor utilizes the TTextEditor control by Lasse Markus Rautiainen: https://github.com/TextEditorPro/TTextEditor

## Good to known
In Delphi the memory management for buffer was using a C like command allocmem and freemem, conveniently a string in the old version of Delphi was similar to a binary buffer with auto allocation. This was bad pratice but my young self didnt bother and used it everywhere. String start at 1 for the character array and you can use + to add to it.

The code is a mess and has few comment, i never bothered to improve it and recently only upgraded it to the latess Delphi version and did some bug fix.