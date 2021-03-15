;NSIS Modern User Interface
;Basic Example Script
;Written by Victor Martin

;--------------------------------
;Include Modern UI

!include "MUI2.nsh"
;!include "ZipDLL.nsh"

;--------------------------------
;General

;Name and file
Name "LanzaAyuda"
OutFile "InstallAyuda.exe"
Unicode True

;Default installation folder
InstallDir "$LOCALAPPDATA\LanzaAyuda"

;Get installation folder from registry if available
InstallDirRegKey HKCU "Software\LanzaAyuda" ""

;Request application privileges for Windows Vista
RequestExecutionLevel user

;--------------------------------
;Interface Configuration

!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP "IESMontecillos.bmp" ; optional
!define !define MUI_HEADERIMAGE_RIGHT
!define MUI_ABORTWARNING

;--------------------------------
;Pages

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_LICENSE "licencia.txt"
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_WELCOME
!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

!insertmacro MUI_LANGUAGE "Spanish"

;--------------------------------
;Installer Sections

Function CallbackTest
  Pop $R8
  Pop $R9

  SetDetailsPrint textonly
  DetailPrint "Extracting $R8 / $R9..."
  SetDetailsPrint both
FunctionEnd

Section "Principal LanzaAyuda" SecDummy

SetOutPath "$INSTDIR"



;ADD YOUR OWN FILES HERE...
SetOutPath $INSTDIR
SetCompress off
DetailPrint "Extracting package..."
SetDetailsPrint listonly
File dist.7z
SetCompress auto
;!insertmacro ZIPDLL_EXTRACT "$INSTDIR\LanzaAyuda.zip" "$INSTDIR" "<ALL>"
SetDetailsPrint both
;Store installation folder
WriteRegStr HKCU "Software\LanzaAyuda" "" $INSTDIR

;Create uninstaller
WriteUninstaller "$INSTDIR\Uninstall.exe"

GetFunctionAddress $R9 CallbackTest
  Nsis7z::ExtractWithCallback "$INSTDIR\dist.7z" $R9

  Delete "$OUTDIR\dist.7z"

SectionEnd

;--------------------------------
;Descriptions

;Language strings
LangString DESC_SecDummy ${LANG_SPANISH} "A test section."

;Assign language strings to sections
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
!insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

;ADD YOUR OWN FILES HERE...

Delete "$INSTDIR\Uninstall.exe"

RMDir "$INSTDIR"

DeleteRegKey /ifempty HKCU "Software\LanzaAyuda"

SectionEnd