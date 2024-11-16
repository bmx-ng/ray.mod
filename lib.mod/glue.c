/*
  Copyright (c) 2024 Bruce A Henderson

  This software is provided 'as-is', without any express or implied
  warranty. In no event will the authors be held liable for any damages
  arising from the use of this software.

  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

     1. The origin of this software must not be misrepresented; you must not
     claim that you wrote the original software. If you use this software
     in a product, an acknowledgment in the product documentation would be
     appreciated but is not required.

     2. Altered source versions must be plainly marked as such, and must not be
     misrepresented as being the original software.

     3. This notice may not be removed or altered from any source
     distribution.
*/
#include <stdlib.h>
#include "raylib.h"
#include "reasings.h"
#include "brl.mod/blitz.mod/blitz.h"

void bmx_raylib_CloseWindow() {
	CloseWindow();
}

void bmx_raylib_DrawText(const char *text, int posX, int posY, int fontSize, Color color) {
	DrawText(text, posX, posY, fontSize, color);
}

void bmx_raylib_DrawTextEx(Font font, const char *text, Vector2 position, float fontSize, float spacing, Color tint) {
	DrawTextEx(font, text, position, fontSize, spacing, tint);
}

void bmx_raylib_ShowCursor() {
	ShowCursor();
}

Image bmx_raylib_LoadImage(const char *fileName) {
	return LoadImage(fileName);
}

void bmx_raylib_RLFree(void * obj) {
	RL_FREE(obj);
}

static BBArray * bmx_FilePathList_to_BBArray(FilePathList list) {
  int n = list.count;

  if ( n == 0 ) {
    return &bbEmptyArray;
  }

	BBArray *p=bbArrayNew1D( "$",n );
	BBString **s=(BBString**)BBARRAYDATA( p,p->dims );
	for( int i=0;i<n;++i ){
		s[i] = bbStringFromUTF8String( (unsigned char *)list.paths[i] );
	}
	return p;
}

BBArray * bmx_raylib_LoadDroppedFiles() {
  FilePathList list = LoadDroppedFiles();

  BBArray * arr = bmx_FilePathList_to_BBArray(list);

  UnloadDroppedFiles(list);

  return arr;
}
