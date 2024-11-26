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
#define RAYGUI_IMPLEMENTATION
#define RAYGUI_SUPPORT_ICONS
#include "raygui.h"

#if !defined(_WIN32)
#include "brl.mod/blitz.mod/blitz.h"
#else
#include "brl.mod/blitz.mod/blitz_debug.h"
#include "brl.mod/blitz.mod/blitz_array.h"

#if defined(_WIN64)
 typedef __int64 LONG_PTR; 
 typedef unsigned __int64 UINT_PTR;
#else
 typedef long LONG_PTR;
 typedef unsigned int UINT_PTR;
#endif
typedef UINT_PTR WPARAM;
typedef LONG_PTR LPARAM;

#include "brl.mod/blitz.mod/blitz_string.h"
#endif


int bmx_raygui_GuiTabBar(Rectangle bounds, BBArray * p, int * active) {

    int n=p->scales[0];
	BBString **s=(BBString**)BBARRAYDATA( p,p->dims );

    const char **text = (const char **)malloc(n * sizeof(char *));
    for( int i=0;i<n;++i ){
        text[i] = bbStringToUTF8String(s[i]);
    }

    int res = GuiTabBar(bounds, text, n, active);

	for( int i=0;i<n;++i ){
		bbMemFree( (void*)text[i] );
	}

    free( text );

    return res;
}
